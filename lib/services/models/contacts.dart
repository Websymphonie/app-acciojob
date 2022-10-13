class ContactModel {
  static List<Contact> contacts = [];

  static Contact getById(int id) =>
      contacts.firstWhere((element) => element.id == id);

  static Contact getByPosition(int pos) => contacts[pos];
}

class Contact {
  int? id;
  String? description;
  String? telephone;
  String? cellulaire;
  String? email;
  String? adresses;
  String? facebook;
  String? twitter;
  String? linkedin;
  String? youtube;

  Contact(
      {this.id,
        this.description,
        this.telephone,
        this.cellulaire,
        this.email,
        this.adresses,
        this.facebook,
        this.twitter,
        this.linkedin,
        this.youtube});

  Contact.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    telephone = json['telephone'];
    cellulaire = json['cellulaire'];
    email = json['email'];
    adresses = json['adresses'];
    facebook = json['facebook'];
    twitter = json['twitter'];
    linkedin = json['linkedin'];
    youtube = json['youtube'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['description'] = description;
    data['telephone'] = telephone;
    data['cellulaire'] = cellulaire;
    data['email'] = email;
    data['adresses'] = adresses;
    data['facebook'] = facebook;
    data['twitter'] = twitter;
    data['linkedin'] = linkedin;
    data['youtube'] = youtube;
    return data;
  }
}
