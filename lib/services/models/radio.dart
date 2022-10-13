import 'dart:convert';

class RadioModel {
  static List<Radios> radios = [];

  static Radios getByPosition(int pos) => radios[pos];
}

class Radios {
  Radios? radios;

  Radios({this.radios});

  Map<String, dynamic> toMap() {
    return {};
  }

  factory Radios.fromMap(Map<String, dynamic> map) {
    return Radios();
  }

  String toJson() => json.encode(toMap());

  factory Radios.fromJson(String source) => Radios.fromMap(json.decode(source));
}
