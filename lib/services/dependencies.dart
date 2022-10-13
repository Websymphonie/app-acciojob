import 'package:acciojob/services/controllers/about_controller.dart';
import 'package:acciojob/services/controllers/commande_controller.dart';
import 'package:acciojob/services/controllers/commune_controller.dart';
import 'package:acciojob/services/controllers/contact_controller.dart';
import 'package:acciojob/services/controllers/location_controller.dart';
import 'package:acciojob/services/controllers/login_controller.dart';
import 'package:acciojob/services/controllers/order_controller.dart';
import 'package:acciojob/services/controllers/page_static_controller.dart';
import 'package:acciojob/services/controllers/register_controller.dart';
import 'package:acciojob/services/controllers/service_controller.dart';
import 'package:acciojob/services/controllers/static_service_controller.dart';
import 'package:acciojob/services/controllers/user_controller.dart';
import 'package:acciojob/services/data/api/api_client.dart';
import 'package:acciojob/services/data/repository/about_repository.dart';
import 'package:acciojob/services/data/repository/commande_repository.dart';
import 'package:acciojob/services/data/repository/commune_repository.dart';
import 'package:acciojob/services/data/repository/contact_repository.dart';
import 'package:acciojob/services/data/repository/location_repository.dart';
import 'package:acciojob/services/data/repository/login_repository.dart';
import 'package:acciojob/services/data/repository/order_repository.dart';
import 'package:acciojob/services/data/repository/page_repository.dart';
import 'package:acciojob/services/data/repository/register_repository.dart';
import 'package:acciojob/services/data/repository/service_repository.dart';
import 'package:acciojob/services/data/repository/static_service_repository.dart';
import 'package:acciojob/services/data/repository/user_repository.dart';
import 'package:acciojob/utils/constants/constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  final sharedPreferencies = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferencies);

  //Api Client
  Get.lazyPut(() => ApiClient(
      appBaseUrl: AppConstants.SITE_WEB_URL, sharedPreferences: Get.find()));

  //Repositories
  Get.lazyPut(() => RegisterRepository(apiClient: Get.find()));
  Get.lazyPut(() =>
      LoginRepository(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() =>
      UserRepository(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => ServiceRepository(apiClient: Get.find()));
  Get.lazyPut(() => CommandeRepository(apiClient: Get.find()));
  Get.lazyPut(() => CommuneRepository(apiClient: Get.find()));
  Get.lazyPut(() => PageRepository(apiClient: Get.find()));
  Get.lazyPut(() => StaticServiceRepository(apiClient: Get.find()));
  Get.lazyPut(() => ContactRepository(apiClient: Get.find()));
  Get.lazyPut(() => AboutRepository(apiClient: Get.find()));
  Get.lazyPut(() => OrderRepository(apiClient: Get.find()));
  Get.lazyPut(() =>
      LocationRepository(apiClient: Get.find(), sharedPreferences: Get.find()));

  //Controllers
  Get.lazyPut(() => ServiceController(serviceRepository: Get.find()));
  Get.lazyPut(() => CommandeController(commandeRepository: Get.find()));
  Get.lazyPut(() => CommuneController(communeRepository: Get.find()));
  Get.lazyPut(() => PageStaticController(pageRepository: Get.find()));
  Get.lazyPut(
      () => StaticServiceController(staticserviceRepository: Get.find()));
  Get.lazyPut(() => ContactController(contactRepository: Get.find()));
  Get.lazyPut(() => AboutController(aboutRepository: Get.find()));
  Get.lazyPut(() => RegisterController(registerRepository: Get.find()));
  Get.lazyPut(() =>
      LoginController(loginRepository: Get.find(), userRepository: Get.find()));
  Get.lazyPut(() => UserController(userRepository: Get.find()));
  Get.lazyPut(() => LocationController(locationRepository: Get.find()));
  Get.lazyPut(() => OrderController(orderRepository: Get.find()));
}
