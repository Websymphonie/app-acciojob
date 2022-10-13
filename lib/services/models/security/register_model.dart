import 'dart:convert';

RegisterModel registerModelFromJson(String str) =>
    RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  int? id;
  String? nom;
  String? prenoms;
  String? email;
  String? password;
  String? contacts;

  RegisterModel({
    this.id,
    required this.nom,
    required this.prenoms,
    required this.email,
    required this.password,
    this.contacts,
  });

  RegisterModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nom = json['nom'];
    prenoms = json['prenoms'];
    email = json['email'];
    password = json['password'];
    contacts = json['contacts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nom'] = nom;
    data['prenoms'] = prenoms;
    data['email'] = email;
    data['password'] = password;
    data['contacts'] = contacts;
    return data;
  }
}
