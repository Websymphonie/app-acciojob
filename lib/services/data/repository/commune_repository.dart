import 'package:acciojob/services/data/api/api_client.dart';
import 'package:acciojob/utils/constants/constants.dart';
import 'package:get/get.dart';

class CommuneRepository extends GetxService {
  final ApiClient apiClient;

  CommuneRepository({required this.apiClient});

  Future<Response> getCommuneList() async {
    return await apiClient.getData(AppConstants.COMMUNE_URI);
  }
}
