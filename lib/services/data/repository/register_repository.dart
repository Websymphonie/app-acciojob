import 'package:acciojob/services/data/api/api_client.dart';
import 'package:acciojob/services/models/security/register_model.dart';
import 'package:acciojob/utils/constants/constants.dart';
import 'package:get/get.dart';

class RegisterRepository {
  final ApiClient apiClient;

  RegisterRepository({required this.apiClient});

  Future<Response> register(RegisterModel registerModel) async {
    return await apiClient.postData(
        AppConstants.CLIENT_URI, registerModel.toJson());
  }
}
