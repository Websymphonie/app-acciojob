import 'dart:async';

import 'package:acciojob/utils/blocs/application_bloc.dart';
import 'package:acciojob/utils/constants/constants.dart';
import 'package:acciojob/utils/constants/dimensions.dart';
import 'package:acciojob/utils/location_service.dart';
import 'package:acciojob/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyGoogleMap extends StatefulWidget {
  @override
  State<MyGoogleMap> createState() => _MyGoogleMapState();
}

class _MyGoogleMapState extends State<MyGoogleMap> {
  final Completer<GoogleMapController> _controller = Completer();
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _latController = TextEditingController();
  final TextEditingController _lngController = TextEditingController();
  double latitude = AppConstants.LATITUDE;
  double longitude = AppConstants.LONGITUDE;
  final Set<Marker> _markers = <Marker>{};

  @override
  void initState() {
    super.initState();
    _latController.text = latitude.toString();
    _lngController.text = longitude.toString();

    _setMarker();

    _markers.add(
      Marker(
        markerId: MarkerId('marker'),
        position: LatLng(latitude, longitude),
        draggable: true,
        onDrag: (dragPosition) {
          latitude = dragPosition.latitude;
          longitude = dragPosition.longitude;
        },
        infoWindow: InfoWindow(
          title: _searchController.text,
        ),
      ),
    );
  }

  void _setMarker() async {
    Position position = await _determinePosition();
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    final GoogleMapController controller = await _controller.future;
    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
      _latController.text = position.latitude.toString();
      _lngController.text = position.longitude.toString();
      var description = placemarks[0].name! +
          " - " +
          placemarks[0].street! +
          " - " +
          placemarks[0].locality! +
          ", " +
          placemarks[0].country!;
      _searchController.text = description;
      _markers.add(
        Marker(
          markerId: MarkerId('marker'),
          position: LatLng(position.latitude, position.longitude),
          draggable: true,
          onDrag: (dragPosition) {
            latitude = dragPosition.latitude;
            longitude = dragPosition.longitude;
          },
          infoWindow: InfoWindow(
            title: description,
          ),
        ),
      );

      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 12,
          ),
        ),
      );
    });
  }

  Future<void> _goToPlace(Map<String, dynamic> place) async {
    final double lat = place['geometry']['location']['lat'];
    final double lng = place['geometry']['location']['lng'];
    final GoogleMapController controller = await _controller.future;

    setState(() {
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(lat, lng),
            zoom: 12,
          ),
        ),
      );
      _latController.text = lat.toString();
      _lngController.text = lng.toString();
      _markers.add(
        Marker(
          markerId: MarkerId('marker'),
          position: LatLng(lat, lng),
          draggable: true,
          onDrag: (dragPosition) {
            latitude = dragPosition.latitude;
            longitude = dragPosition.longitude;
          },
          infoWindow: InfoWindow(
            title: _searchController.text,
          ),
        ),
      );
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 14.4746,
    );
    final Applicationbloc applicationbloc = Applicationbloc();
    return Column(
      children: [
        FormBuilderTextField(
          name: 'adresse',
          controller: _searchController,
          textCapitalization: TextCapitalization.words,
          onChanged: (value) {
            applicationbloc.searchPlace(value!);
          },
          decoration: InputDecoration(
            suffixIcon: IconButton(
              color: MyThemes.primaryColor,
              onPressed: () async {
                var place =
                    await LocationService().getPlace(_searchController.text);
                _goToPlace(place);
              },
              icon: Icon(
                Icons.search,
              ),
            ),
            filled: true,
            fillColor: Colors.grey.shade300,
            hintText: 'Indiquez un lieu',
            enabledBorder: InputBorder.none,
          ),
        ),
        Container(
          height: Dimensions.height300,
          width: MediaQuery.of(context).size.width,
          child:GoogleMap(
            mapToolbarEnabled: true,
            scrollGesturesEnabled: true,
            compassEnabled: false,
            indoorViewEnabled: true,
            zoomGesturesEnabled: false,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: true,
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            markers: _markers,
            onTap: (LatLng place) async {
              List<Placemark> placemarks = await placemarkFromCoordinates(
                place.latitude, place.longitude,);
              var description = placemarks[0].name! +
                  " - " +
                  placemarks[0].street! +
                  " - " +
                  placemarks[0].locality! +
                  ", " +
                  placemarks[0].country!;
              _searchController.text = description;
              _markers.add(
                Marker(
                  markerId: MarkerId("marker"),
                  position: place,
                  draggable: true,
                  onDragEnd: (dragPosition) {
                    _latController.text = dragPosition.latitude.toString();
                    _lngController.text = dragPosition.longitude.toString();
                  },
                  infoWindow: InfoWindow(
                    title: description,
                  ),
                ),
              );
              final GoogleMapController controller =
              await _controller.future;
              controller.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: place,
                    zoom: 12,
                  ),
                ),
              );
              _latController.text = place.latitude.toString();
              _lngController.text = place.longitude.toString();
              setState(() {});
            },
            onMapCreated: (GoogleMapController controller) async {
              _controller.complete(controller);
            },
          ),
        ),
        Visibility(
          visible: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: FormBuilderTextField(
                  name: 'latitude',
                  controller: _latController,
                ),
              ),
              Expanded(
                child: FormBuilderTextField(
                  name: 'longitude',
                  controller: _lngController,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
