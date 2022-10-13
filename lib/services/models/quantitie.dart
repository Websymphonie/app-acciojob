import 'dart:convert';

class QuantitieModel {
  static List<Quantities> quantities = [];

  static Quantities getByPosition(int pos) => quantities[pos];
}

class Quantities {
  Quantities? quantities;

  Quantities({this.quantities});

  Map<String, dynamic> toMap() {
    return {};
  }

  factory Quantities.fromMap(Map<String, dynamic> map) {
    return Quantities();
  }

  String toJson() => json.encode(toMap());

  factory Quantities.fromJson(String source) =>
      Quantities.fromMap(json.decode(source));
}
