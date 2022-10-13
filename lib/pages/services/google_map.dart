// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:acciojob/commons/show_custom_snack_bar.dart';
import 'package:acciojob/services/controllers/location_controller.dart';
import 'package:acciojob/services/models/children.dart';
import 'package:acciojob/services/models/user/user_model.dart';
import 'package:acciojob/utils/constants/constants.dart';
import 'package:acciojob/utils/constants/dimensions.dart';
import 'package:acciojob/utils/location_service.dart';
import 'package:acciojob/utils/themes.dart';
import 'package:acciojob/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyGoogleMap extends StatefulWidget {
  final UserModel? user;
  final Children? service;
  bool pageType = false;
  MyGoogleMap({
    Key? key,
    this.service,
    this.user,
    required this.pageType,
  }) : super(key: key);

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
  double zoom = 12;
  final Set<Marker> _markers = <Marker>{};

  DetailsResult? startPosition;

  late FocusNode startFocusNode;

  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _latController.text = latitude.toString();
    _lngController.text = longitude.toString();
    String ApiKey = AppConstants.GOOGLE_API_KEY;
    googlePlace = GooglePlace(ApiKey);
    startFocusNode = FocusNode();
    _setMarker();
  }

  @override
  void dispose() {
    super.dispose();
    startFocusNode.dispose();
  }

  void _setMarker() async {
    Position position = await _determinePosition();
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    final GoogleMapController controller = await _controller.future;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var lat = prefs.getString(AppConstants.LATITUDE.toString()) != null
        ? double.parse(prefs.getString(AppConstants.LATITUDE.toString())!)
        : position.latitude;
    var lng = prefs.getString(AppConstants.LONGITUDE.toString()) != null
        ? double.parse(prefs.getString(AppConstants.LONGITUDE.toString())!)
        : position.longitude;

    setState(() {
      latitude = lat;
      longitude = lng;
      _latController.text = prefs.getString(AppConstants.LATITUDE.toString()) ??
          position.latitude.toString();
      _lngController.text =
          prefs.getString(AppConstants.LONGITUDE.toString()) ??
              position.longitude.toString();
      var description =
          prefs.getString(AppConstants.ADDRESS_FROM_MAP.toString()) ??
              placemarks[0].name! +
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
          position: LatLng(lat, lng),
          draggable: true,
          onDrag: (dragPosition) {
            latitude = dragPosition.latitude;
            longitude = dragPosition.longitude;
          },
          infoWindow: InfoWindow(
            title: prefs.getString(AppConstants.ADDRESS_FROM_MAP.toString()) ??
                description,
          ),
        ),
      );

      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(lat, lng),
            zoom: zoom,
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
            zoom: zoom,
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

  void autocompleteSearch(String value) async {
    var results = await googlePlace.autocomplete.get(value);
    if (results != null && results.predictions != null && mounted) {
      setState(() {
        predictions = results.predictions!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: zoom,
    );

    Future<void> _getCurrentPosition() async {
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(latitude, longitude),
            zoom: zoom,
          ),
        ),
      );
    }

    //final Applicationbloc applicationbloc = Applicationbloc();
    bool searchContainer = true;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyThemes.primaryColor,
          title: Text(
            "Localisez vous",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: Dimensions.font15,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          titleTextStyle: TextStyle(
            fontSize: Dimensions.height15,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        body: Stack(
          children: [
            Positioned(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: GoogleMap(
                  mapToolbarEnabled: true,
                  scrollGesturesEnabled: true,
                  compassEnabled: false,
                  indoorViewEnabled: true,
                  zoomGesturesEnabled: true,
                  myLocationEnabled: true,
                  zoomControlsEnabled: true,
                  mapType: MapType.normal,
                  initialCameraPosition: _kGooglePlex,
                  markers: Set.from(_markers),
                  onTap: (LatLng place) async {
                    List<Placemark> placemarks = await placemarkFromCoordinates(
                      place.latitude,
                      place.longitude,
                    );
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
                          _latController.text =
                              dragPosition.latitude.toString();
                          _lngController.text =
                              dragPosition.longitude.toString();
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
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.all(Dimensions.height10),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Column(
                    children: [
                      FormBuilderTextField(
                        name: 'adresse',
                        focusNode: startFocusNode,
                        controller: _searchController,
                        textCapitalization: TextCapitalization.words,
                        onChanged: (String? value) {
                          if (_debounce?.isActive ?? false) _debounce!.cancel();
                          _debounce =
                              Timer(const Duration(microseconds: 1000), () {
                            if (value!.isNotEmpty) {
                              searchContainer = false;
                              autocompleteSearch(value);
                            } else {
                              setState(() {
                                predictions = [];
                                startPosition = null;
                              });
                            }
                          });
                          //applicationbloc.searchPlace(value!);
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            color: MyThemes.primaryColor,
                            onPressed: () async {
                              var place = await LocationService()
                                  .getPlace(_searchController.text);
                              _goToPlace(place);
                            },
                            icon: Icon(
                              Icons.search,
                            ),
                          ),
                          filled: true,
                          fillColor: MyThemes.whiteColor,
                          hintText: 'Indiquez un lieu',
                          enabledBorder: InputBorder.none,
                        ),
                      ),
                      searchContainer
                          ? Container(
                              color: MyThemes.creamColor,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: predictions.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      leading: CircleAvatar(
                                        child: Icon(
                                          Icons.pin_drop,
                                          color: MyThemes.whiteColor,
                                        ),
                                      ),
                                      title: Text(
                                        predictions[index]
                                            .description
                                            .toString(),
                                      ),
                                      onTap: () async {
                                        final placeId =
                                            predictions[index].placeId;
                                        final details = await googlePlace
                                            .details
                                            .get(placeId!);
                                        if (details != null &&
                                            details.result != null &&
                                            mounted) {
                                          if (startFocusNode.hasFocus) {
                                            setState(() {
                                              startPosition = details.result;
                                              _searchController.text =
                                                  details.result!.name!;
                                              predictions = [];
                                              searchContainer = true;
                                            });
                                          }

                                          if (startPosition != null) {
                                            final GoogleMapController
                                                controller =
                                                await _controller.future;

                                            setState(() {
                                              controller.animateCamera(
                                                CameraUpdate.newCameraPosition(
                                                  CameraPosition(
                                                    target: LatLng(
                                                      startPosition!.geometry!
                                                          .location!.lat!,
                                                      startPosition!.geometry!
                                                          .location!.lng!,
                                                    ),
                                                    zoom: zoom,
                                                  ),
                                                ),
                                              );
                                              _markers.add(
                                                Marker(
                                                  markerId: MarkerId('marker'),
                                                  position: LatLng(
                                                    startPosition!.geometry!
                                                        .location!.lat!,
                                                    startPosition!.geometry!
                                                        .location!.lng!,
                                                  ),
                                                  draggable: true,
                                                  onDrag: (dragPosition) {
                                                    latitude =
                                                        dragPosition.latitude;
                                                    longitude =
                                                        dragPosition.longitude;
                                                  },
                                                  infoWindow: InfoWindow(
                                                    title:
                                                        _searchController.text,
                                                  ),
                                                ),
                                              );
                                              predictions = [];
                                              searchContainer = true;
                                            });
                                          }
                                        }
                                      },
                                    );
                                  }),
                            )
                          : Container()
                    ],
                  ),
                ),
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
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Container(
                margin: EdgeInsets.only(left: 70, right: 70),
                child: AppButton(
                  label: "Utiliser cette adresse",
                  backgroundColor: MyThemes.primaryColor,
                  textColor: MyThemes.whiteColor,
                  width: MediaQuery.of(context).size.width * 0.5,
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString(
                        AppConstants.ADDRESS_FROM_MAP, _searchController.text);
                    prefs.setString(
                        AppConstants.LAT_FROM_MAP, _latController.text);
                    prefs.setString(
                        AppConstants.LNG_FROM_MAP, _lngController.text);

                    Get.defaultDialog(
                      title: "Votre adresse",
                      content: Column(
                        children: [
                          Text(_searchController.text),
                          SizedBox(
                            height: Dimensions.height15,
                          ),
                          Text(
                            "NB: Une fois Confirmé, retournez au formulaire en cliquant sur la flêche de retour en haut à gauche.",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Dimensions.font12,
                              color: MyThemes.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      buttonColor: MyThemes.primaryColor,
                      actions: [
                        ElevatedButton(
                          child: Text("Annuler"),
                          onPressed: () => Get.back(),
                        ),
                        ElevatedButton(
                          child: Text("Confirmer"),
                          onPressed: () {
                            Get.back();
                            Get.find<LocationController>().updateAddress(
                                _searchController.text,
                                _latController.text,
                                _lngController.text);
                            showCustomSnackBar(
                              "Adresse sélectionnée: " + _searchController.text,
                              isError: false,
                              title: "Infos",
                              color: MyThemes.whiteColor,
                              background: MyThemes.successPrimary,
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: MyThemes.darkCreamColor,
          foregroundColor: MyThemes.whiteColor,
          onPressed: _getCurrentPosition,
          mini: true,
          child: Icon(Icons.gps_fixed_sharp),
        ),
      ),
    );
  }
}
