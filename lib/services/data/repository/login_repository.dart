import 'package:acciojob/services/data/api/api_client.dart';
import 'package:acciojob/services/models/security/login_model.dart';
import 'package:acciojob/utils/constants/constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepository {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  LoginRepository({required this.apiClient, required this.sharedPreferences});

  Future<Response> registration(LoginModel loginModel) async {
    return await apiClient.postData(AppConstants.LOGIN, loginModel.toJson());
  }

  Future<Response> login(LoginModel loginModel) async {
    return await apiClient.postData(AppConstants.LOGIN, loginModel.toJson());
  }

  bool userLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.APP_TOKEN);
  }

  Future<String> getUserToken() async {
    return sharedPreferences.getString(AppConstants.APP_TOKEN) ?? "None";
  }

  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.APP_TOKEN, token);
  }

  Future<bool> saveUserId(int id) async {
    apiClient.id = id.toString();
    apiClient.updateSessionHeader(id.toString());
    return await sharedPreferences.setString(
        AppConstants.APP_USER_ID, id.toString());
  }

  Future<void> saveUserEmailAndPassword(LoginModel loginModel) async {
    try {
      await sharedPreferences.setString(
          AppConstants.APP_USER_ID, loginModel.id.toString());
      await sharedPreferences.setString(
          AppConstants.APP_USER_EMAIL, loginModel.email!);
      await sharedPreferences.setString(
          AppConstants.APP_USER_PASSWORD, loginModel.password!);
    } catch (e) {
      rethrow;
    }
  }
}
