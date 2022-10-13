import 'package:acciojob/services/models/commandes/groupe.dart';
import 'package:acciojob/services/models/commandes/item.dart';

class LinecommandesModel {
  static List<Linecommandes> linecommandes = [];

  static Linecommandes getById(int id) =>
      linecommandes.firstWhere((element) => element.id == id);

  static Linecommandes getByPosition(int pos) => linecommandes[pos];
}

class Linecommandes {
  int? id;
  int? price;
  int? quantity;
  Items? items;
  Groupes? groupes;

  Linecommandes({this.id, this.price, this.quantity, this.items, this.groupes});

  Linecommandes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    quantity = json['quantity'];
    items = json['items'] != null ? Items.fromJson(json['items']) : null;
    groupes =
        json['groupes'] != null ? Groupes.fromJson(json['groupes']) : null;
  }

  factory Linecommandes.fromMap(Map<String, dynamic> map) {
    return Linecommandes(
      id: map['id']?.toInt() ?? 0,
      price: map['price'] ?? '',
      quantity: map['quantity'] ?? 0,
      items: map['items'] != null ? Items.fromJson(map['items']) : null,
      groupes: map['groupes'] != null ? Groupes.fromJson(map['groupes']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['price'] = price;
    data['quantity'] = quantity;
    if (items != null) {
      data['items'] = items!.toJson();
    }
    if (groupes != null) {
      data['groupes'] = groupes!.toJson();
    }
    return data;
  }
}
