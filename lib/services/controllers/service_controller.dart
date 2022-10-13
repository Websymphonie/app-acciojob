import 'dart:convert';

import 'package:acciojob/services/data/repository/service_repository.dart';
import 'package:acciojob/services/models/services/service.dart';
import 'package:get/get.dart';

class ServiceController extends GetxController {
  final ServiceRepository serviceRepository;

  ServiceController({required this.serviceRepository});

  List<dynamic> _serviceList = []; //Private
  List<dynamic> get serviceList => _serviceList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getServiceList() async {
    Response response = await serviceRepository.getServiceList();

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
