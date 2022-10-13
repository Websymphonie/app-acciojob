import 'dart:convert' as convert;

import 'package:acciojob/services/models/place_search.dart';
import 'package:http/http.dart' as http;

class PlaceService {
  Future<List<PlaceSearch>> getAutocomplete(String search) async {
    const String key = 'AIzaSyBykBOClJdeGVFxbb1G7RsPGDtJllwRbI0';
    var url =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&types=(cities)&key=$key";
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['predictions'] as List;
    return jsonResults.map((place) => PlaceSearch.fromJson(place)).toList();
  }
}
