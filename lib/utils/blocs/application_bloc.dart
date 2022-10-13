import 'package:acciojob/services/models/place_search.dart';
import 'package:acciojob/services/place_service.dart';
import 'package:acciojob/utils/location_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class Applicationbloc with ChangeNotifier {
  final geoLocatorService = LocationService();
  final placeService = PlaceService();

  //Variables
  late Position currentLocation;
  List<PlaceSearch> searchResult = [];

  Applicationbloc() {
    setCurrentLocation();
  }

  setCurrentLocation() async {
    currentLocation = await geoLocatorService.getCurrentLocation();
    notifyListeners();
  }

  searchPlace(String search) async {
    searchResult = await placeService.getAutocomplete(search);
    notifyListeners();
  }
}
