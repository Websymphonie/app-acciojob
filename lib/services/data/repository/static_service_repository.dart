import 'package:acciojob/services/data/api/api_client.dart';
import 'package:acciojob/utils/constants/constants.dart';
import 'package:get/get.dart';

class StaticServiceRepository extends GetxService {
  final ApiClient apiClient;

  StaticServiceRepository({required this.apiClient});

  Future<Response> getService() async {
    return await apiClient.getData(AppConstants.STATIC_SERVICE_URI);
  }
}
