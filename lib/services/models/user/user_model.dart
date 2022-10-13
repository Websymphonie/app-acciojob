class UserModel {
  int? id;
  String? email;
  String? nom;
  String? prenoms;
  String? contacts;

  UserModel({
    this.id,
    this.email,
    this.nom,
    this.prenoms,
    this.contacts,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toInt(),
      email: json['email'],
      nom: json['nom'],
      prenoms: json['prenoms'],
      contacts: json['contacts'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'nom': nom,
      'prenoms': prenoms,
      'contacts': contacts,
    };
  }
}
