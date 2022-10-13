import 'package:acciojob/services/data/api/api_client.dart';
import 'package:acciojob/utils/constants/constants.dart';
import 'package:get/get.dart';

class CommandeRepository extends GetxService {
  final ApiClient apiClient;

  CommandeRepository({required this.apiClient});

  Future<Response> getCommandes(int id) async {
    return await apiClient
        .getData(AppConstants.CLIENT_URI + '/' + id.toString() + '/commandes');
  }
}
