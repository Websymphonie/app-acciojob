import 'package:acciojob/commons/custom_loader.dart';
import 'package:acciojob/commons/delayed_animation.dart';
import 'package:acciojob/commons/show_custom_snack_bar.dart';
import 'package:acciojob/services/controllers/login_controller.dart';
import 'package:acciojob/services/models/security/login_model.dart';
import 'package:acciojob/utils/api_route.dart';
import 'package:acciojob/utils/conectivity_provider.dart';
import 'package:acciojob/utils/constants/dimensions.dart';
import 'package:acciojob/utils/routes.dart';
import 'package:acciojob/utils/themes.dart';
import 'package:acciojob/widgets/app_button.dart';
import 'package:acciojob/widgets/no_connexion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool circular = false;
  bool visibilityPassword = true;
  ApiRoutes apiRoutes = ApiRoutes();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
  }

  _cheLogin(BuildContext context, LoginController loginController) async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty) {
      showCustomSnackBar(
        "Veuillez saisir votre adresse email",
        title: "Email",
      );
    } else if (!GetUtils.isEmail(email)) {
      showCustomSnackBar(
        "Adresse email invalide",
        title: "Email",
      );
    } else if (password.isEmpty) {
      showCustomSnackBar(
        "Veuillez saisir votre Mot de passe",
        title: "Mot de passe",
      );
    } else if (password.length < 6) {
      showCustomSnackBar(
        "Votre mot de passe doit comporter au moins 6 caractères",
        title: "Mot de passe",
      );
    } else {
      LoginModel loginModel = LoginModel(email: email, password: password);
      loginController.login(loginModel).then((status) {
        if (status.isSuccess) {
          showCustomSnackBar(
            "Vous êtes maintenant connecté",
            isError: false,
            title: "Félicitation",
            color: MyThemes.whiteColor,
            background: MyThemes.successPrimary,
          );
          Get.offNamed(RouteHelper.initial);
        } else {
          showCustomSnackBar(status.message);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityProvider>(builder: (context, model, child) {
      if (model.isOnline) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: MyThemes.primaryColor,
              title: Text(
                'Se connecter',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: Dimensions.font15,
                ),
              ),
            ),
            body: GetBuilder<LoginController>(builder: (_loginController) {
              return _loginController.isLoading == false
                  ? Material(
                      color: Colors.white,
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            children: [
                              DelayedAnimation(
                                delay: 800,
                                child: Image.asset(
                                  'assets/images/login_cover.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              DelayedAnimation(
                                delay: 1000,
                                child: Text(
                                  'Se connecter',
                                  style: TextStyle(
                                      fontSize: Dimensions.font28,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.height20,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: Dimensions.height16,
                                  horizontal: Dimensions.width32,
                                ),
                                child: Column(
                                  children: [
                                    DelayedAnimation(
                                      delay: 1200,
                                      child: TextFormField(
                                        style: TextStyle(
                                            fontSize: MyThemes.fontSizeInput),
                                        decoration: InputDecoration(
                                          hintText: "Saisissez votre email",
                                          labelText: "Adresse email",
                                          labelStyle: TextStyle(
                                            fontSize: MyThemes.fontSizeInput,
                                            color: MyThemes.primaryColor,
                                          ),
                                          border: UnderlineInputBorder(
                                            borderSide: const BorderSide(
                                                width: 1, color: Colors.blue),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: MyThemes.primaryColor),
                                          ),
                                        ),
                                        validator:
                                            FormBuilderValidators.compose([
                                          FormBuilderValidators.required(
                                              errorText:
                                                  "Adresse email obligatoire"),
                                          FormBuilderValidators.email(
                                              errorText:
                                                  "Veuillez saisir un email valide"),
                                        ]),
                                        controller: _emailController,
                                      ),
                                    ),
                                    DelayedAnimation(
                                      delay: 1400,
                                      child: TextFormField(
                                        obscureText: visibilityPassword,
                                        style: TextStyle(
                                            fontSize: MyThemes.fontSizeInput),
                                        decoration: InputDecoration(
                                          suffixIcon: IconButton(
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
                                          hintText:
                                              "Saisissez votre mot de passe",
                                          labelText: "Mot de passe",
                                          labelStyle: TextStyle(
                                            fontSize: MyThemes.fontSizeInput,
                                            color: MyThemes.primaryColor,
                                          ),
                                          border: UnderlineInputBorder(
                                            borderSide: const BorderSide(
                                                width: 1, color: Colors.blue),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: MyThemes.primaryColor),
                                          ),
                                        ),
                                        validator:
                                            FormBuilderValidators.compose([
                                          FormBuilderValidators.required(
                                              errorText:
                                                  "Mot de passe obligatoire"),
                                        ]),
                                        controller: _passwordController,
                                      ),
                                    ),
                                    SizedBox(height: Dimensions.height20),
                                    DelayedAnimation(
                                      delay: 1600,
                                      child: AppButton(
                                        label: "Se connecter",
                                        backgroundColor: MyThemes.primaryColor,
                                        textColor: MyThemes.whiteColor,
                                        onTap: () => _cheLogin(
                                            context, _loginController),
                                      ),
                                    ),
                                    SizedBox(height: Dimensions.height10),
                                    DelayedAnimation(
                                      delay: 1800,
                                      child: Text("Vous n'avez pas de compte?"),
                                    ),
                                    SizedBox(height: Dimensions.height10),
                                    DelayedAnimation(
                                      delay: 2000,
                                      child: AppButton(
                                        label: "S'inscrire",
                                        onTap: () => Get.toNamed(
                                          RouteHelper.getRegisterPage(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : const CustomLoader();
            }));
      } else {
        return NoConnexion();
      }
    });
  }
}
