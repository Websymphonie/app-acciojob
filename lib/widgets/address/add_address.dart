import 'dart:async';

import 'package:acciojob/services/controllers/location_controller.dart';
import 'package:acciojob/services/controllers/login_controller.dart';
import 'package:acciojob/services/controllers/user_controller.dart';
import 'package:acciojob/utils/blocs/application_bloc.dart';
import 'package:acciojob/utils/constants/constants.dart';
import 'package:acciojob/utils/constants/dimensions.dart';
import 'package:acciojob/utils/themes.dart';
import 'package:acciojob/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../utils/location_service.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({Key? key}) : super(key: key);

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final Completer<GoogleMapController> _controller = Completer();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();

  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  final Set<Marker> _markers = <Marker>{};
  late bool _isLogged;

  CameraPosition _cameraPosition = const CameraPosition(
    target: LatLng(AppConstants.LATITUDE, AppConstants.LONGITUDE),
    zoom: 12,
  );

  late LatLng _initialPosition =
      LatLng(AppConstants.LATITUDE, AppConstants.LONGITUDE);

  @override
  void initState() {
    super.initState();
    _setMarker();
    _isLogged = Get.find<LoginController>().userLoggedIn();
    if (_isLogged) {
      Get.find<UserController>().getUserInfos();
    }
    if (Get.find<LocationController>().addressList.isNotEmpty) {
      Get.find<LocationController>().getUserAddress();
      _cameraPosition = CameraPosition(
        target: LatLng(
          double.parse(Get.find<LocationController>().getAddress["latitude"]),
          double.parse(Get.find<LocationController>().getAddress["longitude"]),
        ),
      );

      _initialPosition = LatLng(
        double.parse(Get.find<LocationController>().getAddress["latitude"]),
        double.parse(Get.find<LocationController>().getAddress["longitude"]),
      );
    }

    _markers.add(
      Marker(
        markerId: MarkerId('marker'),
        position: _initialPosition,
      ),
    );
  }

  void _setMarker() async {
    Position position = await _determinePosition();
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    final GoogleMapController controller = await _controller.future;
    setState(() {
      _latitudeController.text = position.latitude.toString();
      _longitudeController.text = position.longitude.toString();
      var description = placemarks[0].name! +
          " - " +
          placemarks[0].street! +
          " - " +
          placemarks[0].locality! +
          ", " +
          placemarks[0].country!;
      _addressController.text = description;
      _markers.add(
        Marker(
          markerId: MarkerId('marker'),
          position: LatLng(position.latitude, position.longitude),
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
      _latitudeController.text = lat.toString();
      _longitudeController.text = lng.toString();
      _markers.add(
        Marker(
          markerId: MarkerId('marker'),
          position: LatLng(lat, lng),
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
    return GetBuilder<UserController>(builder: (userController) {
      if (_contactPersonName.text.isEmpty) {
        _contactPersonName.text =
            '${userController.userModel.nom} ${userController.userModel.prenoms}';
        _contactPersonNumber.text = '${userController.userModel.contacts}';
        if (Get.find<LocationController>().addressList.isNotEmpty) {
          _addressController.text =
              Get.find<LocationController>().getUserAddress().address;
        }
      }
      return GetBuilder<LocationController>(builder: (locationController) {
        _latitudeController.text =
            '${Get.find<LocationController>().position.latitude}';
        _longitudeController.text =
            '${Get.find<LocationController>().position.longitude}';
        _addressController.text = '${locationController.placemark.name ?? ''}'
            '${locationController.placemark.locality ?? ''}'
            '${locationController.placemark.postalCode ?? ''}'
            '${locationController.placemark.country ?? ''}';
        final Applicationbloc applicationbloc = Applicationbloc();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: Dimensions.height300,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(
                left: Dimensions.width5,
                right: Dimensions.width5,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(width: 2, color: MyThemes.primaryColor),
              ),
              child: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: _initialPosition,
                      zoom: 12,
                    ),
                    mapType: MapType.normal,
                    scrollGesturesEnabled: true,
                    zoomControlsEnabled: true,
                    compassEnabled: false,
                    indoorViewEnabled: true,
                    mapToolbarEnabled: true,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    markers: _markers,
                    onCameraIdle: () {
                      locationController.updatePosition(_cameraPosition, true);
                    },
                    onCameraMove: ((position) => _cameraPosition = position),
                    onMapCreated: (GoogleMapController controller) async {
                      locationController.setMapController(controller);
                    },
                    onTap: (LatLng position) async {
                      List<Placemark> placemarks =
                          await placemarkFromCoordinates(
                        position.latitude,
                        position.longitude,
                      );
                      _markers.add(
                        Marker(
                          markerId: MarkerId("marker"),
                          position: position,
                        ),
                      );
                      final GoogleMapController controller =
                          await _controller.future;
                      controller.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                            target: position,
                            zoom: 12,
                          ),
                        ),
                      );
                      _latitudeController.text = position.latitude.toString();
                      _longitudeController.text = position.longitude.toString();
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: Dimensions.width20,
                top: Dimensions.height20,
              ),
              child: SizedBox(
                height: Dimensions.height50,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: locationController.addressTypeList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          locationController.setAddressTypeIndex(index);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.width20,
                            vertical: Dimensions.height10,
                          ),
                          margin: EdgeInsets.only(right: Dimensions.width10),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20 / 4),
                            color: Theme.of(context).cardColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[200]!,
                                spreadRadius: 1,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: Icon(
                            index == 0
                                ? Icons.home_filled
                                : index == 1
                                    ? Icons.work
                                    : Icons.location_on,
                            color: locationController.addressTypeIndex == index
                                ? MyThemes.primaryColor
                                : Theme.of(context).disabledColor,
                          ),
                        ),
                      );
                    }),
              ),
            ),
            SizedBox(
              height: Dimensions.height20,
            ),
            BigText(text: "Adresse"),
            SizedBox(
              height: Dimensions.height20,
            ),
            FormBuilderTextField(
              name: 'adresse',
              controller: _addressController,
              onChanged: (value) {
                applicationbloc.searchPlace(value!);
              },
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  color: MyThemes.primaryColor,
                  onPressed: () async {
                    var place = await LocationService()
                        .getPlace(_addressController.text);
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
            SizedBox(
              height: Dimensions.height20,
            ),
            FormBuilderTextField(
              name: 'nom',
              controller: _contactPersonName,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade300,
                hintText: 'Nom et prénoms',
                enabledBorder: InputBorder.none,
              ),
            ),
            SizedBox(
              height: Dimensions.height20,
            ),
            FormBuilderTextField(
              name: 'contacts',
              controller: _contactPersonNumber,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade300,
                hintText: 'Contacts',
                enabledBorder: InputBorder.none,
              ),
            ),
            Visibility(
              visible: true,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: FormBuilderTextField(
                      name: 'latitude',
                      controller: _latitudeController,
                    ),
                  ),
                  Expanded(
                    child: FormBuilderTextField(
                      name: 'longitude',
                      controller: _longitudeController,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      });
    });
  }
}
