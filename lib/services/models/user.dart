import 'dart:convert';

class UserModel {
  static List<User> users = [];

  static User getById(int id) =>
      users.firstWhere((element) => element.id == id);

  static User getByPosition(int pos) => users[pos];
}

class User {
  final int? id;
  final String? email;
  final String? password;
  final String? username;
  final String? nom;
  final String? prenoms;
  final String? contacts;

  User({
    this.id,
    this.email,
    this.password,
    this.username,
    this.nom,
    this.prenoms,
    this.contacts,
  });

  User copyWith({
    int? id,
    String? email,
    String? password,
    String? username,
    String? nom,
    String? prenoms,
    String? contacts,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      username: username ?? this.username,
      nom: nom ?? this.nom,
      prenoms: prenoms ?? this.prenoms,
      contacts: contacts ?? this.contacts,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'username': username,
      'nom': nom,
      'prenoms': prenoms,
      'contacts': contacts,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id']?.toInt(),
      email: map['email'],
      password: map['password'],
      username: map['username'],
      nom: map['nom'],
      prenoms: map['prenoms'],
      contacts: map['contacts'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() =>
      'User(id: $id, email: $email, password: $password, username: $username, nom: $nom, prenoms: $prenoms, contacts: $contacts)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.email == email &&
        other.password == password &&
        other.username == username &&
        other.nom == nom &&
        other.prenoms == prenoms &&
        other.contacts == contacts;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      email.hashCode ^
      password.hashCode ^
      username.hashCode ^
      nom.hashCode ^
      prenoms.hashCode ^
      contacts.hashCode;
}
