import 'package:acciojob/services/data/api/api_client.dart';
import 'package:acciojob/utils/constants/constants.dart';
import 'package:get/get.dart';

class ContactRepository extends GetxService {
  final ApiClient apiClient;

  ContactRepository({required this.apiClient});

  Future<Response> getContact(int id) async {
    return await apiClient
        .getData(AppConstants.PAGE_CONTACT_URI + id.toString());
  }
}
