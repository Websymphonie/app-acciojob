import 'package:acciojob/commons/show_custom_snack_bar.dart';
import 'package:acciojob/pages/services/google_map.dart';
import 'package:acciojob/pages/services/service_page.dart';
import 'package:acciojob/screens/orders/orders_screen.dart';
import 'package:acciojob/services/controllers/commune_controller.dart';
import 'package:acciojob/services/controllers/login_controller.dart';
import 'package:acciojob/services/controllers/order_controller.dart';
import 'package:acciojob/services/controllers/user_controller.dart';
import 'package:acciojob/services/models/children.dart';
import 'package:acciojob/services/models/order.dart';
import 'package:acciojob/services/models/user/user_model.dart';
import 'package:acciojob/utils/constants/constants.dart';
import 'package:acciojob/utils/constants/dimensions.dart';
import 'package:acciojob/utils/themes.dart';
import 'package:acciojob/widgets/app_button.dart';
import 'package:acciojob/widgets/app_pick_location.dart';
import 'package:acciojob/widgets/big_text.dart';
import 'package:acciojob/widgets/custom_search_delegate.dart';
import 'package:acciojob/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceOtherDetailsPage extends StatefulWidget {
  final UserModel? user;
  final Children? service;
  const ServiceOtherDetailsPage({Key? key, this.service, required this.user})
      : super(key: key);

  @override
  State<ServiceOtherDetailsPage> createState() =>
      _ServiceOtherDetailsPageState();
}

class _ServiceOtherDetailsPageState extends State<ServiceOtherDetailsPage> {
  late bool _isLogged;
  final TextEditingController _clientController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _latController = TextEditingController();
  final TextEditingController _lngController = TextEditingController();

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    _isLogged = Get.find<LoginController>().userLoggedIn();
    if (_isLogged) {
      Get.find<UserController>().getUserInfos();
    }
    getDataFormMap();
    super.initState();
  }

  void getDataFormMap() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _searchController.text =
        prefs.getString(AppConstants.ADDRESS_FROM_MAP) ?? '';
    _latController.text = prefs.getString(AppConstants.LAT_FROM_MAP) ?? '';
    _lngController.text = prefs.getString(AppConstants.LNG_FROM_MAP) ?? '';
    setState(() {});
  }

  saveDatas(OrderController orderController) async {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      var datas = _formKey.currentState!.value;

      Order order = Order(
        priceBase: widget.service!.base_price,
        dateHeure: datas['dateheure'].toString(),
        latitude: _latController.text,
        longitude: _lngController.text,
        others: datas['other'].toString(),
        adresse: _searchController.text,
        isAcceptCondition: datas['isAcceptCondition'],
        clients: int.parse(_clientController.text),
        communes: int.parse(datas['communes']),
        categories: int.parse(widget.service!.id.toString()),
      );

      orderController.saveOther(order).then((status) {
        if (status.isSuccess) {
          showCustomSnackBar(
            "Votre commande a bien été enregistrée",
            isError: false,
            title: "Félicitation",
            color: MyThemes.whiteColor,
            background: MyThemes.successPrimary,
          );
          Get.offAll(OrdersScreen(user: widget.user));
        } else {
          showCustomSnackBar(status.message);
        }
      });
    } else {
      showCustomSnackBar("Veuillez renseigner les champs obligatoire",
          title: "Erreur",
          background: MyThemes.dangerPrimary,
          color: MyThemes.whiteColor);
    }
  }

  void goToGoogleMap() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => MyGoogleMap(
          service: widget.service,
          user: widget.user,
          pageType: false,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(0.0, 1.1);
          var curve = Curves.ease;
          var end = Offset.zero;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _clientController.text = widget.user!.id.toString();
      getDataFormMap();
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyThemes.primaryColor,
        title: TitleWidget(
            label: widget.service!.name!, textOverflow: TextOverflow.ellipsis),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(user: widget.user),
              );
            },
            icon: Icon(
              Icons.search,
              color: MyThemes.blackColor,
              size: Dimensions.iconSize24,
            ),
          )
        ],
        titleTextStyle: TextStyle(
          fontSize: Dimensions.height15,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => goToGoogleMap(),
        mini: true,
        foregroundColor: MyThemes.whiteColor,
        backgroundColor: MyThemes.darkBlueColor,
        child: Icon(Icons.add_location_alt),
      ),
      backgroundColor: MyThemes.creamColor,
      body: GetBuilder<OrderController>(builder: (_orderController) {
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Dimensions.height10,
              ),
              ServicePage(service: widget.service),
              SizedBox(
                height: Dimensions.height10,
              ),
              Container(
                margin: EdgeInsets.only(left: Dimensions.width15),
                child: BigText(
                  text: "De quel service avez vous besoin?",
                  size: Dimensions.font16,
                ),
              ),
              SizedBox(
                height: Dimensions.height10,
              ),
              Container(
                margin: EdgeInsets.only(left: Dimensions.width15),
                child: Column(
                  children: [
                    FormBuilder(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Container(
                        margin: EdgeInsets.only(right: Dimensions.width15),
                        child: Column(
                          children: [
                            Visibility(
                              visible: false,
                              child: TextFormField(
                                controller: _clientController,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FormBuilderDateTimePicker(
                                  name: 'dateheure',
                                  decoration: InputDecoration(
                                    labelText: 'Date & heure',
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: Dimensions.font16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    hintText: 'Date & heure',
                                  ),
                                ),
                                SizedBox(
                                  height: Dimensions.height10,
                                ),
                                GetBuilder<CommuneController>(
                                    builder: (commune) {
                                  return FormBuilderDropdown(
                                    name: 'communes',
                                    decoration: InputDecoration(
                                      labelText: 'Commune',
                                      labelStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: Dimensions.font22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    allowClear: true,
                                    hint: Text('Sélectionnez votre commune'),
                                    items: commune.communeList
                                        .map(
                                          (commune) => DropdownMenuItem(
                                            value: commune.id.toString(),
                                            child: Text(commune.name),
                                          ),
                                        )
                                        .toList(),
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(),
                                    ]),
                                  );
                                }),
                                SizedBox(
                                  height: Dimensions.height10,
                                ),
                                FormBuilderTextField(
                                  name: 'other',
                                  maxLines: 3,
                                  keyboardType: TextInputType.multiline,
                                  decoration: InputDecoration(
                                    labelText: 'Décrivez votre problèmes',
                                    labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: Dimensions.font16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    hintText:
                                        'Décrivez votre problèmes et laisser nous votre numéro de téléphone.',
                                  ),
                                  autovalidateMode: AutovalidateMode.always,
                                  validator: FormBuilderValidators.required(),
                                ),
                                SizedBox(
                                  height: Dimensions.height10,
                                ),
                                FormBuilderSwitch(
                                  name: 'isAcceptCondition',
                                  initialValue: false,
                                  title: Text(
                                      "J'accepte les conditions d'utilisation"),
                                  validator: FormBuilderValidators.equal(
                                    true,
                                    errorText:
                                        'Vous devez accepter les termes et conditions pour continuer',
                                  ),
                                ),
                                Visibility(
                                  visible: false,
                                  child: FormBuilderTextField(
                                    name: 'adresse',
                                    enabled: false,
                                    controller: _searchController,
                                    decoration: InputDecoration(
                                      labelText: 'Adresse',
                                      labelStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: Dimensions.font16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      hintText: 'Adresse',
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: false,
                                  child: FormBuilderTextField(
                                    name: 'latitude',
                                    enabled: false,
                                    controller: _latController,
                                    decoration: InputDecoration(
                                      labelText: 'Latitude',
                                      labelStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: Dimensions.font16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      hintText: 'Latitude',
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: false,
                                  child: FormBuilderTextField(
                                    name: 'longitude',
                                    enabled: false,
                                    controller: _lngController,
                                    decoration: InputDecoration(
                                      labelText: 'Longitude',
                                      labelStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: Dimensions.font16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      hintText: 'Longitude',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Dimensions.height20,
                            ),
                            AppPickLocation(
                              label: 'Choisir ma localisation',
                              onTap: () => goToGoogleMap(),
                            ),
                            SizedBox(
                              height: Dimensions.height20,
                            ),
                            AppButton(
                              label: "Envoyer",
                              backgroundColor: MyThemes.primaryColor,
                              textColor: MyThemes.whiteColor,
                              width: MediaQuery.of(context).size.width * 0.5,
                              isLoading: _orderController.isLoading,
                              onTap: () => saveDatas(_orderController),
                            ),
                            SizedBox(
                              height: Dimensions.height20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
