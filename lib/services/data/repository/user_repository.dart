import 'package:acciojob/services/data/api/api_client.dart';
import 'package:acciojob/services/models/user/user_model.dart';
import 'package:acciojob/utils/constants/constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  final ApiClient apiClient;
  late SharedPreferences sharedPreferences;
  UserRepository({required this.apiClient, required this.sharedPreferences});

  Future<Response> getUserInfos() async {
    var id = sharedPreferences.getString(AppConstants.APP_USER_ID);
    var uri = AppConstants.USER_INFOS_URI + '/' + id.toString();
    return await apiClient.getData(uri);
  }

  Future<Response> updateUser(UserModel userModel) async {
    var id = sharedPreferences.getString(AppConstants.APP_USER_ID);
    var uri = AppConstants.CLIENT_URI + '/' + id.toString();
    return await apiClient.putData(uri, userModel.toJson());
  }

  Future<Response> delete(String id) async {
    return await apiClient.deleteData(
      "${AppConstants.USER_DELETE_URI}/$id",
    );
  }

  bool clearShareData() {
    sharedPreferences.remove(AppConstants.APP_TOKEN);
    sharedPreferences.remove(AppConstants.APP_USER_ID);
    sharedPreferences.remove(AppConstants.APP_USER_PASSWORD);
    sharedPreferences.remove(AppConstants.APP_USER_EMAIL);
    sharedPreferences.remove(AppConstants.APP_SHOW_SECURITY);
    sharedPreferences.remove(AppConstants.ADDRESS_FROM_MAP);
    sharedPreferences.remove(AppConstants.LAT_FROM_MAP);
    sharedPreferences.remove(AppConstants.LNG_FROM_MAP);
    sharedPreferences.remove("user");
    apiClient.token = '';
    apiClient.updateHeader('');
    return true;
  }
}
