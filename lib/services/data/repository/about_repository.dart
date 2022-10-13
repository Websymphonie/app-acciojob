import 'package:acciojob/services/data/api/api_client.dart';
import 'package:acciojob/utils/constants/constants.dart';
import 'package:get/get.dart';

class AboutRepository extends GetxService {
  final ApiClient apiClient;

  AboutRepository({required this.apiClient});

  Future<Response> getAbout(int id) async {
    return await apiClient.getData(AppConstants.PAGE_ABOUT_URI + id.toString());
  }
}
