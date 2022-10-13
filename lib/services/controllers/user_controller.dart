import 'dart:convert';

import 'package:acciojob/services/data/repository/user_repository.dart';
import 'package:acciojob/services/models/response_model.dart';
import 'package:acciojob/services/models/user/user_model.dart';
import 'package:get/get.dart';

class UserController extends GetxController implements GetxService {
  final UserRepository userRepository;

  UserController({required this.userRepository});

  bool _isLoading = false;
  UserModel _userModel = UserModel();

  bool get isLoading => _isLoading;

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

  bool clearShareData() {
    return userRepository.clearShareData();
  }
}
