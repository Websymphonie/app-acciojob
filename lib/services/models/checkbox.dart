import 'dart:convert';

class CheckboxModel {
  static List<Checkboxs> checkboxs = [];

  static Checkboxs getByPosition(int pos) => checkboxs[pos];
}

class Checkboxs {
  Checkboxs? checkboxs;

  Checkboxs({this.checkboxs});

  Map<String, dynamic> toMap() {
    return {};
  }

  factory Checkboxs.fromMap(Map<String, dynamic> map) {
    return Checkboxs();
  }

  String toJson() => json.encode(toMap());

  factory Checkboxs.fromJson(String source) =>
      Checkboxs.fromMap(json.decode(source));
}
