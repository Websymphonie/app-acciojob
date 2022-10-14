import 'package:acciojob/services/controllers/about_controller.dart';
import 'package:acciojob/services/controllers/commune_controller.dart';
import 'package:acciojob/services/controllers/contact_controller.dart';
import 'package:acciojob/services/controllers/login_controller.dart';
import 'package:acciojob/services/controllers/order_controller.dart';
import 'package:acciojob/services/controllers/page_static_controller.dart';
import 'package:acciojob/services/controllers/service_controller.dart';
import 'package:acciojob/services/controllers/static_service_controller.dart';
import 'package:acciojob/services/dependencies.dart' as dep;
import 'package:acciojob/utils/conectivity_provider.dart';
import 'package:acciojob/utils/constants/constants.dart';
import 'package:acciojob/utils/routes.dart';
import 'package:acciojob/utils/themes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final showSecurity = prefs.getBool(AppConstants.APP_SHOW_SECURITY) ?? false;
  await dep.init();
  if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(App(showSecurity: showSecurity));
}

class App extends StatefulWidget {
  final bool showSecurity;
  const App({Key? key, required this.showSecurity}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
    configLoading();
  }

  void configLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.yellow
      ..backgroundColor = Colors.green
      ..indicatorColor = Colors.yellow
      ..textColor = Colors.yellow
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = false;
  }

  @override
  Widget build(BuildContext context) {
    Get.find<OrderController>();
    Get.find<ServiceController>().getServiceList();
    Get.find<CommuneController>().getCommuneList();
    Get.find<PageStaticController>().getPage(4);
    Get.find<StaticServiceController>().getServices();
    Get.find<ContactController>().getContact(1);
    Get.find<AboutController>().getAbout(1);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ConnectivityProvider(),
          child: GetMaterialApp(
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              FormBuilderLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('fr', 'FR'),
            ],
            navigatorKey: Get.key,
            themeMode: ThemeMode.light,
            debugShowCheckedModeBanner: false,
            theme: MyThemes.ligthTheme(context),
            darkTheme: MyThemes.darkTheme(context),
            initialRoute: /*widget.showSecurity
                ? */
                Get.find<LoginController>().userLoggedIn()
                    ? RouteHelper.getHomePage()
                    : RouteHelper
                        .getSplashScreen() /*: RouteHelper.getSplashScreen()*/,
            getPages: RouteHelper.routes,
            builder: EasyLoading.init(),
          ),
        )
      ],
      child: GetMaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          FormBuilderLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('fr', 'FR'),
        ],
        navigatorKey: Get.key,
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        theme: MyThemes.ligthTheme(context),
        darkTheme: MyThemes.darkTheme(context),
        initialRoute: /*widget.showSecurity
            ? */
            Get.find<LoginController>().userLoggedIn()
                ? RouteHelper.getHomePage()
                : RouteHelper
                    .getSplashScreen() /*: RouteHelper.getSplashScreen()*/,
        getPages: RouteHelper.routes,
        builder: EasyLoading.init(),
      ),
    );
  }
}
