import 'dart:convert';

import 'package:acciojob/commons/show_custom_snack_bar.dart';
import 'package:acciojob/pages/services/google_map.dart';
import 'package:acciojob/pages/services/service_page.dart';
import 'package:acciojob/screens/orders/orders_screen.dart';
import 'package:acciojob/services/controllers/commune_controller.dart';
import 'package:acciojob/services/controllers/user_controller.dart';
import 'package:acciojob/services/models/children.dart';
import 'package:acciojob/services/models/groupe.dart';
import 'package:acciojob/services/models/linegroupe.dart';
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
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ServiceDetailsPage extends StatefulWidget {
  final UserModel? user;
  final Children? service;
  const ServiceDetailsPage({Key? key, this.service, required this.user})
      : super(key: key);

  @override
  State<ServiceDetailsPage> createState() => _ServiceDetailsPageState();
}

class _ServiceDetailsPageState extends State<ServiceDetailsPage> {
  bool circular = false;
  List<Groupe> groupes = [];
  List<Linegroupe> linegroupes = [];

  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _latController = TextEditingController();
  final TextEditingController _lngController = TextEditingController();
  final TextEditingController _clientController = TextEditingController();

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    Get.find<UserController>().getUserInfos();
    getDataFormMap();
    _clientController.text = widget.user!.id.toString();
    setState(() {
      groupes = widget.service!.groupes!;
    });
  }

  void getDataFormMap() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _searchController.text =
        prefs.getString(AppConstants.ADDRESS_FROM_MAP) ?? '';
    _latController.text = prefs.getString(AppConstants.LAT_FROM_MAP) ?? '';
    _lngController.text = prefs.getString(AppConstants.LNG_FROM_MAP) ?? '';
    setState(() {});
  }

  saveDatas() async {
    setState(() {
      circular = true;
    });
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      var datas = _formKey.currentState!.value;
      final Map<dynamic, dynamic> orders = {};
      final Map<dynamic, dynamic> checkboxs = {};
      final quantities = [];
      final Map<dynamic, dynamic> radios = {};
      String _groupId = '';

      datas.forEach((key, value) {
        if (key.contains('checKbox_')) {
          var idGroupe = key.split("_")[1];
          setState(() {
            _groupId = idGroupe;
          });
          checkboxs[idGroupe] = value; //Groupe et ses options (checkbox)
        }
        if (key.contains('qte_')) {
          var idOption = key.split("_")[1];
          quantities.add({
            _groupId: {idOption: value} //Option et leurs quantités
          });
        }
        if (key.contains('radio_')) {
          var idGroupe = key.split("_")[1];
          radios[idGroupe] = value; //Groupe et ses options (radio)
        }
      });

      setState(() {
        orders.addAll({
          'priceBase': widget.service!.base_price != null
              ? double.parse(widget.service!.base_price.toString())
              : 0.0,
          'dateHeure': datas['dateheure'].toString(),
          'latitude': _latController.text,
          'longitude': _lngController.text,
          'adresse': _searchController.text,
          'isAcceptCondition': datas['isAcceptCondition'],
          'communes': int.parse(datas['communes']),
          'categories': int.parse(widget.service!.id.toString()),
          'clients': int.parse(_clientController.text),
          'checkboxs': checkboxs,
          'quantities': quantities,
          'radios': radios,
        });
      });

      final response = await http.post(
        Uri.parse(AppConstants.ORDER_URI),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(orders),
      );
      var result = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // If the server did return a 200 OK response,
        showCustomSnackBar(
          result['message'],
          isError: false,
          title: "Succès",
          color: MyThemes.whiteColor,
          background: MyThemes.successPrimary,
        );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => Overlay(
              initialEntries: [
                OverlayEntry(
                  builder: (context) => OrdersScreen(
                    user: widget.user,
                  ),
                ),
              ],
            ),
          ),
          (route) => false,
        );
      } else {
        setState(() {
          circular = false;
        });
        //String output = json.decode(response.body);
        showCustomSnackBar(
          result['message'] ?? result['hydra:description'],
          title: "Erreur",
        );
      }
    } else {
      setState(() {
        circular = false;
      });
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
          pageType: true,
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
                  delegate: CustomSearchDelegate(user: widget.user));
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
      body: SingleChildScrollView(
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
                  groupes.isNotEmpty
                      ? FormBuilder(
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
                                      validator: FormBuilderValidators.compose([
                                        FormBuilderValidators.required(),
                                      ]),
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
                                        hint:
                                            Text('Sélectionnez votre commune'),
                                        items: commune.communeList
                                            .map(
                                              (commune) => DropdownMenuItem(
                                                value: commune.id.toString(),
                                                child: Text(commune.name),
                                              ),
                                            )
                                            .toList(),
                                        validator:
                                            FormBuilderValidators.compose([
                                          FormBuilderValidators.required(),
                                        ]),
                                      );
                                    }),
                                    SizedBox(
                                      height: Dimensions.height10,
                                    ),
                                    ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: groupes.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final groupe = groupes[index];
                                        var linegroupes =
                                            groupes[index].linegroupes!;
                                        return Card(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ListTile(
                                                title: Text(
                                                  groupe.label!,
                                                  style: TextStyle(
                                                    fontSize: Dimensions.font16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: getForms(context, groupe,
                                                    linegroupes),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
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
                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                  ],
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  isLoading: circular,
                                  onTap: () => saveDatas(),
                                ),
                                SizedBox(
                                  height: Dimensions.height20,
                                ),
                              ],
                            ),
                          ),
                        )
                      : Center(
                          child:
                              Text('Ce service est indisponible en ce moment'),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

getForms(BuildContext context, Groupe groupe, List<Linegroupe> linegroupes) {
  if (groupe.champtype == 'radio') {
    List<FormBuilderFieldOption> options = linegroupes.map((option) {
      return FormBuilderFieldOption(
        value: option.id.toString(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            children: [
              Container(
                width: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      option.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    (option.price != null && option.price!.toInt() > 0)
                        ? Text(
                            option.price.toString() + " CFA",
                          )
                        : Text("--"),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();

    return FormBuilderRadioGroup(
      orientation: OptionsOrientation.vertical,
      name: 'radio_' + groupe.id.toString(),
      options: options,
    );
  } else {
    List<FormBuilderFieldOption> options = linegroupes.map((option) {
      return FormBuilderFieldOption(
        value: option.id.toString(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            children: [
              Container(
                width: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      option.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    (option.price != null && option.price!.toInt() > 0)
                        ? Text(
                            option.price.toString() + " CFA",
                          )
                        : Text("--"),
                  ],
                ),
              ),
              Container(
                width: 120,
                child: FormBuilderTouchSpin(
                  name: "qte_" + option.id.toString(),
                  initialValue: 0,
                  step: 1,
                  min: 0,
                  iconSize: 24.0,
                  iconPadding: EdgeInsets.zero,
                  addIcon: const Icon(Icons.arrow_right),
                  subtractIcon: const Icon(Icons.arrow_left),
                  textStyle: TextStyle(fontSize: 15),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      enabledBorder: InputBorder.none),
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
    return FormBuilderCheckboxGroup(
      orientation: OptionsOrientation.vertical,
      name: 'checKbox_' + groupe.id.toString(),
      options: options,
    );
  }
}
