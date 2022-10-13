import 'dart:convert';

import 'package:acciojob/services/data/repository/commune_repository.dart';
import 'package:acciojob/services/models/commune.dart';
import 'package:get/get.dart';

class CommuneController extends GetxController {
  final CommuneRepository communeRepository;

  CommuneController({required this.communeRepository});

  List<dynamic> _communeList = []; //Private
  List<dynamic> get communeList => _communeList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getCommuneList() async {
    Response response = await communeRepository.getCommuneList();
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      var communesData = decodedData['hydra:member'];
      CommuneModel.communes = List.from(communesData)
          .map<Commune>((commune) => Commune.fromMap(commune))
          .toList();
      _communeList = [];
      _communeList.addAll(CommuneModel.communes);
      _isLoaded = true;
      update();
    } else {}
  }
}
