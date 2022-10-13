import 'dart:convert';

import 'package:acciojob/services/data/repository/location_repository.dart';
import 'package:acciojob/services/models/maps/address_model.dart';
import 'package:acciojob/utils/constants/constants.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationController extends GetxController implements GetxService {
  final LocationRepository locationRepository;

  LocationController({required this.locationRepository});

  bool _loading = false;
  late Position _position = Position(
    latitude: AppConstants.LATITUDE,
    longitude: AppConstants.LONGITUDE,
    timestamp: DateTime.now(),
    heading: 1,
    accuracy: 1,
    altitude: 1,
    speedAccuracy: 1,
    speed: 1,
  );
  late Position _pickPosition;
  Placemark _placemark = Placemark();
  Placemark _pickPlaceMark = Placemark();

  final List<AddressModel> _addressList = [];
  List<AddressModel> get addressList => _addressList;

  late final List<AddressModel> _allAddressList = [];
  final List<String> _addressTypeList = ["home", "office", "others"];
  List<String> get addressTypeList => _addressTypeList;
  int _addressTypeIndex = 0;
  int get addressTypeIndex => _addressTypeIndex;

  late GoogleMapController _mapController;
  final bool _updateAddressData = true;
  final bool _changeAddress = true;

  bool get loading => _loading;
  Placemark get placemark => _placemark;
  Placemark get pickPlaceMark => _pickPlaceMark;
  Position get position => _position;
  Position get pickPosition => _pickPosition;

  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
    update();
  }

  void updatePosition(CameraPosition position, bool fromAddress) async {
    if (_updateAddressData) {
      _loading = true;
      try {
        if (fromAddress) {
          _position = Position(
            latitude: position.target.latitude,
            longitude: position.target.longitude,
            timestamp: DateTime.now(),
            heading: 1,
            accuracy: 1,
            altitude: 1,
            speedAccuracy: 1,
            speed: 1,
          );
        } else {
          _pickPosition = Position(
            latitude: position.target.latitude,
            longitude: position.target.longitude,
            timestamp: DateTime.now(),
            heading: 1,
            accuracy: 1,
            altitude: 1,
            speedAccuracy: 1,
            speed: 1,
          );
        }

        if (_changeAddress) {
          String _address = await getAddressFromGeocode(
            LatLng(
              position.target.latitude,
              position.target.longitude,
            ),
          );

          fromAddress
              ? _placemark = Placemark(name: _address)
              : _pickPlaceMark = Placemark(name: _address);
        }
        update();
      } catch (e) {
        throw ("Erreur" + e.toString());
      }
    }
  }

  Future<String> getAddressFromGeocode(LatLng latLng) async {
    String _address = "Location Inconnue";
    Response response = await locationRepository.getAddressFromGeocode(latLng);
    var data = json.decode(response.body);
    if (data['status'] == 'OK') {
      _address = data["results"][0]["formatted_address"].toString();
    } else {
      throw ('Error getting form google api');
    }
    update();
    return _address;
  }

  late Map<String, dynamic> _getAddress;
  Map get getAddress => _getAddress;

  AddressModel getUserAddress() {
    late AddressModel _addressModel;
    _getAddress = jsonDecode(locationRepository.getUserAddress());
    try {
      _addressModel = AddressModel.fromJson(
          jsonDecode(locationRepository.getUserAddress()));
    } catch (e) {
      throw ("Erreur" + e.toString());
    }
    update();
    return _addressModel;
  }

  void setAddressTypeIndex(int index) {
    _addressTypeIndex = index;
    update();
  }

  Future<void> updateAddress(String address, String lat, String lng) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    address = prefs.getString(AppConstants.ADDRESS_FROM_MAP)!;
    lat = prefs.getString(AppConstants.LAT_FROM_MAP)!;
    lng = prefs.getString(AppConstants.LNG_FROM_MAP)!;
    update();
  }
}
