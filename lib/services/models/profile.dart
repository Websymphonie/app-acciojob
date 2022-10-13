import 'dart:convert';

class ProfileModel {
  static List<Profile> profiles = [];

  static Profile getById(int id) =>
      profiles.firstWhere((element) => element.id == id);

  static Profile getByPosition(int pos) => profiles[pos];
}

class Profile {
  final int? id;
  final String? email;
  final String? username;
  final String? nom;
  final String? prenoms;
  final String? contacts;

  Profile({
    this.id,
    this.email,
    this.username,
    this.nom,
    this.prenoms,
    this.contacts,
  });

  Profile copyWith({
    int? id,
    String? email,
    String? username,
    String? nom,
    String? prenoms,
    String? contacts,
  }) {
    return Profile(
      id: id ?? this.id,
      email: email ?? this.email,
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
      'username': username,
      'nom': nom,
      'prenoms': prenoms,
      'contacts': contacts,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      id: map['id']?.toInt(),
      email: map['email'],
      username: map['username'],
      nom: map['nom'],
      prenoms: map['prenoms'],
      contacts: map['contacts'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Profile.fromJson(String source) =>
      Profile.fromMap(json.decode(source));

  @override
  String toString() =>
      'Profile(id: $id, email: $email, username: $username, nom: $nom, prenoms: $prenoms, contacts: $contacts)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Profile &&
        other.id == id &&
        other.email == email &&
        other.username == username &&
        other.nom == nom &&
        other.prenoms == prenoms &&
        other.contacts == contacts;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      email.hashCode ^
      username.hashCode ^
      nom.hashCode ^
      prenoms.hashCode ^
      contacts.hashCode;
}
