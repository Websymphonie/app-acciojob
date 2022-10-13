import 'package:acciojob/services/data/api/api_client.dart';
import 'package:acciojob/services/models/commandes/commande.dart';
import 'package:acciojob/services/models/order.dart';
import 'package:acciojob/utils/constants/constants.dart';
import 'package:get/get.dart';

class OrderRepository extends GetxService {
  final ApiClient apiClient;

  OrderRepository({required this.apiClient});

  Future<Response> save(Order order) async {
    return await apiClient.postData(AppConstants.ORDER_URI, order.toJson());
  }

  Future<Response> saveOther(Order order) async {
    return await apiClient.postData(
        AppConstants.ORDER_OTHER_URI, order.toJson());
  }

  Future<Response> cancel(Commandes commande) async {
    return await apiClient
        .getData(AppConstants.ORDER_CANCEL_URI + commande.id.toString());
  }
}
