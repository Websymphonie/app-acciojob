import 'dart:convert';

import 'package:acciojob/services/data/repository/static_service_repository.dart';
import 'package:acciojob/services/models/services.dart';
import 'package:get/get.dart';

class StaticServiceController extends GetxController {
  final StaticServiceRepository staticserviceRepository;

  StaticServiceController({required this.staticserviceRepository}); //Private

  List<dynamic> _serviceList = []; //Private
  List<dynamic> get serviceList => _serviceList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getServices() async {
    Response response = await staticserviceRepository.getService();
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      var servicesData = decodedData['hydra:member'];
      ServiceModel.services = List.from(servicesData)
          .map<Service>((service) => Service.fromMap(service))
          .toList();
      _serviceList = [];
      _serviceList.addAll(ServiceModel.services);
      _isLoaded = true;
      update();
    } else {}
  }
}
