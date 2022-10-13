import 'package:acciojob/commons/custom_loader.dart';
import 'package:acciojob/commons/delayed_animation.dart';
import 'package:acciojob/commons/show_custom_snack_bar.dart';
import 'package:acciojob/services/controllers/register_controller.dart';
import 'package:acciojob/services/models/security/register_model.dart';
import 'package:acciojob/utils/conectivity_provider.dart';
import 'package:acciojob/utils/constants/dimensions.dart';
import 'package:acciojob/utils/routes.dart';
import 'package:acciojob/utils/themes.dart';
import 'package:acciojob/widgets/app_button.dart';
import 'package:acciojob/widgets/header_title.dart';
import 'package:acciojob/widgets/no_connexion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool visibilityPassword = true;
  bool visibilityConfirmPassword = true;
  bool isLoading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomsController = TextEditingController();
  final TextEditingController _contactsController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
  }

  final _formKey = GlobalKey<FormState>();

  saveUser(BuildContext context, RegisterController registerController) async {
    if (_passwordController.text != _passwordConfirmController.text) {
      showCustomSnackBar(
        "Mots de passes non identiques",
        title: "Mot de passe",
      );
    } else {
      if (_formKey.currentState!.validate()) {
        RegisterModel registerModel = RegisterModel(
          nom: _nomController.text,
          prenoms: _prenomsController.text,
          email: _emailController.text,
          password: _passwordController.text,
          contacts: _contactsController.text,
        );
        registerController.register(registerModel).then((status) {
          if (status.isSuccess) {
            showCustomSnackBar(
              "Vous êtes maintenant inscrit(e)",
              isError: false,
              title: "Félicitation",
              color: MyThemes.whiteColor,
              background: MyThemes.successPrimary,
            );
            Get.offAllNamed(RouteHelper.getLoginPage());
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double fontSize = Dimensions.font14;
    return Consumer<ConnectivityProvider>(builder: (context, model, child) {
      if (model.isOnline) {
        return Scaffold(
          backgroundColor: MyThemes.creamColor,
          appBar: AppBar(
            backgroundColor: MyThemes.primaryColor,
            title: Text(
              "S'inscrire",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: Dimensions.font15,
              ),
            ),
          ),
          body: GetBuilder<RegisterController>(builder: (_registerController) {
            return _registerController.isLoading == false
                ? SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: Dimensions.width16,
                            right: Dimensions.width16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: Dimensions.height10,
                            ),
                            DelayedAnimation(
                              delay: 500,
                              child: HeaderTitle(
                                title: 'Inscription',
                                subtitle: 'Créer un compte Acciojob',
                              ),
                            ),
                            Column(
                              children: [
                                DelayedAnimation(
                                  delay: 800,
                                  child: CupertinoFormSection(
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
                                        ),
                                        prefix: Text(
                                          "Nom",
                                          style: TextStyle(fontSize: fontSize),
                                        ),
                                      ),
                                      CupertinoFormRow(
                                        child: CupertinoTextFormFieldRow(
                                          placeholder: "Entrez votre prénom",
                                          controller: _prenomsController,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Le champ prénoms ne peut être vide";
                                            }
                                            return null;
                                          },
                                        ),
                                        prefix: Text(
                                          "Prénoms",
                                          style: TextStyle(fontSize: fontSize),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                DelayedAnimation(
                                  delay: 1000,
                                  child: CupertinoFormSection(
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
                                        ),
                                        prefix: Text(
                                          "Email",
                                          style: TextStyle(fontSize: fontSize),
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
                                        ),
                                        prefix: Text(
                                          "Téléphone",
                                          style: TextStyle(fontSize: fontSize),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                DelayedAnimation(
                                  delay: 1200,
                                  child: CupertinoFormSection(
                                    header: Text("Sécurité"),
                                    children: [
                                      CupertinoFormRow(
                                        child: CupertinoTextFormFieldRow(
                                          obscureText: visibilityPassword,
                                          placeholder:
                                              "Entrez votre mot de passe",
                                          controller: _passwordController,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Le champ password ne peut être vide";
                                            }
                                            return null;
                                          },
                                        ),
                                        prefix: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              visibilityPassword =
                                                  !visibilityPassword;
                                            });
                                          },
                                          icon: Icon(visibilityPassword
                                              ? Icons.visibility_off
                                              : Icons.visibility),
                                        ),
                                      ),
                                      CupertinoFormRow(
                                        child: CupertinoTextFormFieldRow(
                                          obscureText:
                                              visibilityConfirmPassword,
                                          placeholder:
                                              "Confirmez votre mot de passe",
                                          controller:
                                              _passwordConfirmController,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Le champ password confirm ne peut être vide";
                                            }
                                            return null;
                                          },
                                        ),
                                        prefix: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              visibilityConfirmPassword =
                                                  !visibilityConfirmPassword;
                                            });
                                          },
                                          icon: Icon(visibilityConfirmPassword
                                              ? Icons.visibility_off
                                              : Icons.visibility),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: Dimensions.height20),
                                DelayedAnimation(
                                  delay: 1400,
                                  child: AppButton(
                                    label: "S'inscrire",
                                    onTap: () =>
                                        saveUser(context, _registerController),
                                  ),
                                ),
                                SizedBox(height: Dimensions.height10),
                                DelayedAnimation(
                                  delay: 1600,
                                  child: Text("Vous avez déjà un compte?"),
                                ),
                                SizedBox(height: Dimensions.height10),
                                DelayedAnimation(
                                  delay: 1800,
                                  child: AppButton(
                                    label: "Se connecter",
                                    backgroundColor: MyThemes.primaryColor,
                                    textColor: MyThemes.whiteColor,
                                    onTap: () {
                                      Get.toNamed(RouteHelper.getLoginPage());
                                    },
                                  ),
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
                  )
                : const CustomLoader();
          }),
        );
      } else {
        return NoConnexion();
      }
    });
  }
}
