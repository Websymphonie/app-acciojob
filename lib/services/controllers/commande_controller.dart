import 'dart:convert';

import 'package:acciojob/services/controllers/user_controller.dart';
import 'package:acciojob/services/data/repository/commande_repository.dart';
import 'package:acciojob/services/models/commandes/commande.dart';
import 'package:get/get.dart';

class CommandeController extends GetxController {
  final CommandeRepository commandeRepository;

  CommandeController({required this.commandeRepository});

  List<dynamic> _commandeList = []; //Private
  List<dynamic> get commandeList => _commandeList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getCommandes() async {
    _isLoaded = true;
    var user = Get.find<UserController>().userModel;

    Response response = await commandeRepository.getCommandes(user.id!);

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      var commandesData = decodedData['hydra:member'];

      CommandesModel.commandes = List.from(commandesData)
          .map<Commandes>((commande) => Commandes.fromMap(commande))
          .toList();
      _commandeList = [];
      _commandeList.addAll(CommandesModel.commandes);
      update();
    } else {}
    _isLoaded = false;
    update();
  }
}
