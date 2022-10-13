import 'dart:convert';

import 'package:acciojob/services/data/repository/about_repository.dart';
import 'package:acciojob/services/models/abouts.dart';
import 'package:get/get.dart';

class AboutController extends GetxController {
  final AboutRepository aboutRepository;

  AboutController({required this.aboutRepository});

  late About _about; //Private
  About get about => _about;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getAbout(int id) async {
    Response response = await aboutRepository.getAbout(id);
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      _about = About.fromJson(decodedData);
      _isLoaded = true;
      update();
    } else {}
  }
}
