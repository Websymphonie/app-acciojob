import 'dart:convert';

import 'package:acciojob/commons/show_custom_snack_bar.dart';
import 'package:acciojob/services/controllers/commande_controller.dart';
import 'package:acciojob/services/data/repository/order_repository.dart';
import 'package:acciojob/services/models/commandes/commande.dart';
import 'package:acciojob/services/models/order.dart';
import 'package:acciojob/services/models/response_model.dart';
import 'package:acciojob/services/models/user/user_model.dart';
import 'package:acciojob/utils/themes.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  final OrderRepository orderRepository;

  OrderController({required this.orderRepository});

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<ResponseModel> saveOther(Order order) async {
    _isLoading = true;
    update();
    Response response = await orderRepository.saveOther(order);

    late ResponseModel responseModel;
    if (response.statusCode == 200 || response.statusCode == 201) {
      responseModel = ResponseModel(true, response.body['message']);
      update();
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> save(Order order) async {
    _isLoading = true;
    update();
    Response response = await orderRepository.save(order);

    late ResponseModel responseModel;
    if (response.statusCode == 200 || response.statusCode == 201) {
      responseModel = ResponseModel(true, response.body['message']);
      update();
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> cancel(Commandes commande, UserModel user) async {
    _isLoading = true;
    update();
    Response response = await orderRepository.cancel(commande);

    late ResponseModel responseModel;
    if (response.statusCode == 200 || response.statusCode == 201) {
      responseModel = ResponseModel(true, response.body['message']);
      var msg = json.encode(response.body['message']);
      showCustomSnackBar(
        msg,
        isError: false,
        title: "Infos",
        color: MyThemes.whiteColor,
        background: MyThemes.successPrimary,
      );
      Get.find<CommandeController>().getCommandes();
      update();
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }
}
