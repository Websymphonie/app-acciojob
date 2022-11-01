import 'dart:convert';

import 'package:acciojob/services/data/repository/user_repository.dart';
import 'package:acciojob/services/models/response_model.dart';
import 'package:acciojob/services/models/user/user_model.dart';
import 'package:get/get.dart';

class UserController extends GetxController implements GetxService {
  final UserRepository userRepository;

  UserController({required this.userRepository});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  UserModel _userModel = UserModel();
  UserModel get userModel => _userModel;

  Future<ResponseModel> getUserInfos() async {
    Response response = await userRepository.getUserInfos();
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      //Je dois avoir la meme structure des donnée du serveur
      dynamic jsonObject = json.decode(response.body);
      _userModel = UserModel.fromJson(jsonObject);
      _isLoading = true;
      responseModel = ResponseModel(true, "Successfully");
      update();
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();

    return responseModel;
  }

  Future<ResponseModel> updateUser(UserModel userModel) async {
    _isLoading = true;
    update();
    Response response = await userRepository.updateUser(userModel);

    late ResponseModel responseModel;
    if (response.statusCode == 200 || response.statusCode == 201) {
      responseModel = ResponseModel(true, response.body);
      update();
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> delete(String id) async {
    _isLoading = true;
    update();
    Response response = await userRepository.delete(id);

    late ResponseModel responseModel;

    if (response.statusCode == 200 || response.statusCode == 204) {
      responseModel = ResponseModel(true, "Votre compte à bien été supprimé.");
      update();
    } else {
      responseModel = ResponseModel(false, response.statusText!);
      update();
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  bool clearShareData() {
    return userRepository.clearShareData();
  }
}
