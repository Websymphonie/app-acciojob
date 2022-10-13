import 'package:acciojob/commons/show_custom_snack_bar.dart';
import 'package:acciojob/services/controllers/user_controller.dart';
import 'package:acciojob/services/models/user/user_model.dart';
import 'package:acciojob/utils/constants/dimensions.dart';
import 'package:acciojob/utils/routes.dart';
import 'package:acciojob/utils/themes.dart';
import 'package:acciojob/widgets/app_button.dart';
import 'package:acciojob/widgets/custom_search_delegate.dart';
import 'package:acciojob/widgets/home_button.dart';
import 'package:acciojob/widgets/title_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class ProfilScreen extends StatefulWidget {
  final UserModel? user;
  const ProfilScreen({Key? key, this.user}) : super(key: key);

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  final double coverHeight = 100.0;
  final double profilHeight = 80.0;
  final fontSize = 14.0;

  bool circular = false;
  late String email, username, nom, prenom, contacts;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomsController = TextEditingController();
  final TextEditingController _contactsController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      _nomController.text = widget.user!.nom!;
      _prenomsController.text = widget.user!.prenoms!;
      _emailController.text = widget.user!.email!;
      _contactsController.text = widget.user!.contacts!;
    }
  }

  updateUser(BuildContext context, user, userController) async {
    if (_formKey.currentState!.validate()) {
      UserModel userModel = UserModel(
        nom: _nomController.text,
        prenoms: _prenomsController.text,
        email: _emailController.text,
        contacts: _contactsController.text,
      );

      userController.updateUser(userModel).then((status) {
        if (status.isSuccess) {
          showCustomSnackBar(
            "Vos informations ont bien été mise à jour!",
            isError: false,
            title: "Modification",
            color: MyThemes.whiteColor,
            background: MyThemes.successPrimary,
          );
          Get.offAllNamed(RouteHelper.initial);
        } else {
          showCustomSnackBar(status.message);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyThemes.primaryColor,
        title: TitleWidget(label: "Mon profil"),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              );
            },
            icon: Icon(
              Icons.search,
              color: MyThemes.blackColor,
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: HomeButton(),
      body: GetBuilder<UserController>(builder: (userController) {
        return ListView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.zero,
          children: [
            buildTop(),
            buildContent(userController.userModel, userController),
          ],
        );
      }),
    );
  }

  Widget buildContent(user, userController) => Column(
        children: [
          SizedBox(height: Dimensions.height8),
          Text(
            user.nom + ' ' + user.prenoms,
            style: TextStyle(
                fontSize: Dimensions.font20, fontWeight: FontWeight.bold),
          ),
          Text(
            user.email,
            style: TextStyle(
              fontSize: Dimensions.font15,
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          SizedBox(height: 16),
          Divider(
            color: Colors.grey,
          ),
          buildProfileForm(user, userController),
        ],
      );

  Widget buildProfileForm(user, userController) => FormBuilder(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.only(
                left: Dimensions.width16, right: Dimensions.width16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    CupertinoFormSection(
                      header: Text("Informations personnelles"),
                      children: [
                        CupertinoFormRow(
                          child: CupertinoTextFormFieldRow(
                            placeholder: "Entrez votre nom",
                            controller: _nomController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Le champ nom ne peut être vide";
                              }
                              return null;
                            },
                            onSaved: (val) {
                              nom = val!;
                            },
                          ),
                          prefix: Text(
                            "Nom",
                            style: TextStyle(
                              fontSize: fontSize,
                            ),
                          ),
                        ),
                        CupertinoFormRow(
                          child: CupertinoTextFormFieldRow(
                            placeholder: "Entrez votre prénom",
                            controller: _prenomsController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Le champ prénnoms ne peut être vide";
                              }
                              return null;
                            },
                            onSaved: (val) {
                              prenom = val!;
                            },
                          ),
                          prefix: Text(
                            "Prénoms",
                            style: TextStyle(
                              fontSize: fontSize,
                            ),
                          ),
                        ),
                      ],
                    ),
                    CupertinoFormSection(
                      header: Text("Infos contacts"),
                      children: [
                        CupertinoFormRow(
                          child: CupertinoTextFormFieldRow(
                            placeholder: "Entrez votre email",
                            controller: _emailController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Le champ email ne peut être vide";
                              }
                              if (!value.contains("@")) {
                                return "Adresse email invalide";
                              }
                              return null;
                            },
                            onSaved: (val) {
                              email = val!;
                            },
                          ),
                          prefix: Text(
                            "Email",
                            style: TextStyle(
                              fontSize: fontSize,
                            ),
                          ),
                        ),
                        CupertinoFormRow(
                          child: CupertinoTextFormFieldRow(
                            placeholder: "Entrez votre numéro",
                            controller: _contactsController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Le champ téléphone ne peut être vide";
                              }
                              return null;
                            },
                            onSaved: (val) {
                              contacts = val!;
                            },
                          ),
                          prefix: Text(
                            "Téléphone",
                            style: TextStyle(
                              fontSize: fontSize,
                            ),
                          ),
                        ),
                      ],
                    ),
                    /*CupertinoFormSection(
                      header: Text(
                        "Infos utilisateur",
                        style: TextStyle(
                          fontSize: fontSize,
                        ),
                      ),
                      children: [
                        CupertinoFormRow(
                          child: CupertinoTextFormFieldRow(
                            placeholder: "Entrez votre votre nom d'utilisateur",
                            controller: _usernameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Le champ username ne peut être vide";
                              }
                              return null;
                            },
                            onSaved: (val) {
                              username = val!;
                            },
                          ),
                          prefix: Text(
                            "Nom d'utilisateur",
                            style: TextStyle(
                              fontSize: fontSize,
                            ),
                          ),
                        ),
                      ],
                    ),*/
                    SizedBox(height: Dimensions.height20),
                    AppButton(
                      label: "Sauvegarder les infos",
                      isLoading: !userController.isLoading,
                      onTap: () => updateUser(context, user, userController),
                    ),
                    SizedBox(
                      height: Dimensions.height40,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  Widget buildTop() {
    final top = coverHeight - profilHeight / 2;
    final bottom = profilHeight / 2;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: bottom),
          child: buildCoverImage(),
        ),
        Positioned(
          top: top,
          child: buildProfileCover(),
        ),
      ],
    );
  }

  Widget buildCoverImage() => Container(
        height: coverHeight,
        color: MyThemes.darkBlueColor,
        child: Image.asset(
          'assets/images/placeholder.png',
          width: double.infinity,
          height: coverHeight,
          fit: BoxFit.cover,
        ),
      );

  Widget buildProfileCover() => CircleAvatar(
        radius: profilHeight / 2,
        backgroundColor: Colors.grey.shade800,
        backgroundImage: AssetImage(
          'assets/images/avatar.png',
        ),
      );
}
