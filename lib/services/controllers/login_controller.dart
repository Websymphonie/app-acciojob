import 'package:acciojob/services/data/repository/login_repository.dart';
import 'package:acciojob/services/data/repository/user_repository.dart';
import 'package:acciojob/services/models/response_model.dart';
import 'package:acciojob/services/models/security/login_model.dart';
import 'package:get/get.dart';

class LoginController extends GetxController implements GetxService {
  final LoginRepository loginRepository;
  final UserRepository userRepository;

  LoginController(
      {required this.loginRepository, required this.userRepository});

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<ResponseModel> login(LoginModel loginModel) async {
    _isLoading = true;
    update();
    Response response = await loginRepository.login(loginModel);
    late ResponseModel responseModel;
    if (response.statusCode == 200 || response.statusCode == 201) {
      loginRepository.saveUserToken(response.body['token']);
      loginRepository.saveUserId(response.body['id']);
      userRepository.getUserInfos();
      responseModel = ResponseModel(true, response.body['token']);
      update();
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  void saveUserEmailAndPassword(LoginModel loginModel) {
    loginRepository.saveUserEmailAndPassword(loginModel);
  }

  bool userLoggedIn() {
    return loginRepository.userLoggedIn();
  }

  Future<String> userTokenIn() {
    return loginRepository.getUserToken();
  }
}
