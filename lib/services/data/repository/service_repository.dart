import 'package:acciojob/services/data/api/api_client.dart';
import 'package:acciojob/utils/constants/constants.dart';
import 'package:get/get.dart';

class ServiceRepository extends GetxService {
  final ApiClient apiClient;

  ServiceRepository({required this.apiClient});

  Future<Response> getServiceList() async {
    return await apiClient.getData(AppConstants.SERVICE_URI);
  }
}
