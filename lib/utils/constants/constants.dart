import 'package:shared_preferences/shared_preferences.dart';

class AppConstants {
  String? token = "";
  static String? TOKEN = "";

  AppConstants() {
    getToken();
    TOKEN = token;
  }

  void getToken() async {
    SharedPreferences p = await SharedPreferences.getInstance();
    token = p.getString("token");
  }

  static const String APP_NAME = "Accio Job";
  static const APP_TOKEN = '';
  static const APP_USER_ID = '';
  static const APP_USER_EMAIL = '';
  static const APP_USER_PASSWORD = '';
  static const String APP_SHOW_SECURITY = 'ShowSecurity';
  static const int APP_VERSION = 1;
  static const String GOOGLE_API_KEY =
      "AIzaSyBUilLTn_wojm6T99TII67EZjJy_eqX8HE";

  static const String ADDRESS_FROM_MAP = 'address_form_map';
  static const String LAT_FROM_MAP = 'lat_form_map';
  static const String LNG_FROM_MAP = 'lng_form_map';

  static const double LATITUDE = 5.36126851564118;
  static const double LONGITUDE = -4.009190757100163;

  static const String USER_ADDRESS = "user_address";
  static const String GEOCODE_URI = "api/v1/config/geocode-api";
  static const String SITE_WEB_URL = "https://accio-job.com/";
  static const String BASE_URL = "application/api/v1/";
  static const String SERVICE_URI = BASE_URL + "services/parents";
  static const String COMMUNE_URI = BASE_URL + "communes/";
  static const String PAGE_CONFIDENTIALITE_URI = BASE_URL + "pages/";
  static const STATIC_SERVICE_URI = BASE_URL + 'static/services/';
  static const String PAGE_CONTACT_URI = BASE_URL + "parametres/";
  static const String PAGE_ABOUT_URI = BASE_URL + "abouts/";

  static String IMAGE_URL_DEFAULT =
      SITE_WEB_URL + "assetics/images/category-card-empty.png";
  static String IMAGE_URL_SERVICE =
      SITE_WEB_URL + "uploads/services/categories/";
  static String IMAGE_URL_STATIC_SERVICE = SITE_WEB_URL + "uploads/static/";
  static String DEFAULT_ILLUSTRATION =
      IMAGE_URL_STATIC_SERVICE + "default-illustration.png";

  static String LOGIN = "api/login";
  static String CLIENT_URI = BASE_URL + "clients";
  static String ORDER_URI = SITE_WEB_URL + BASE_URL + "orders/send";
  static String ORDER_OTHER_URI = BASE_URL + "commandes/other/post";
  static String ORDER_CANCEL_URI = BASE_URL + "commandes/cancel/";
  static String LOGOUT = SITE_WEB_URL + "auth/logout";
  static const USER_INFOS_URI = BASE_URL + 'clients/infos';
  static const USER_DELETE_URI = BASE_URL + 'clients';
}
