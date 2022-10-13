import 'package:acciojob/services/data/repository/register_repository.dart';
import 'package:acciojob/services/models/response_model.dart';
import 'package:acciojob/services/models/security/register_model.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController implements GetxService {
  final RegisterRepository registerRepository;

  RegisterController({required this.registerRepository});

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<ResponseModel> register(RegisterModel registerModel) async {
    _isLoading = true;
    update();
    Response response = await registerRepository.register(registerModel);

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
}
