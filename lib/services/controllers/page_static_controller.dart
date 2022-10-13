import 'dart:convert';

import 'package:acciojob/services/data/repository/page_repository.dart';
import 'package:acciojob/services/models/pages.dart';
import 'package:get/get.dart';

class PageStaticController extends GetxController {
  final PageRepository pageRepository;

  PageStaticController({required this.pageRepository});

  late Page _page; //Private
  Page get page => _page;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getPage(int id) async {
    Response response = await pageRepository.getPage(id);
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      _page = Page.fromJson(decodedData);
      _isLoaded = true;
      update();
    } else {}
  }
}
