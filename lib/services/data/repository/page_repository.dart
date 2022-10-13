import 'package:acciojob/services/data/api/api_client.dart';
import 'package:acciojob/utils/constants/constants.dart';
import 'package:get/get.dart';

class PageRepository extends GetxService {
  final ApiClient apiClient;

  PageRepository({required this.apiClient});

  Future<Response> getPage(int id) async {
    return await apiClient
        .getData(AppConstants.PAGE_CONFIDENTIALITE_URI + id.toString());
  }
}
