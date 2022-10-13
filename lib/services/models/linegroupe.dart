import 'dart:convert';

class LinegroupeModel {
  static List<Linegroupe> linegroupes = [];

  static Linegroupe getById(int id) =>
      linegroupes.firstWhere((element) => element.id == id);

  static Linegroupe getByPosition(int pos) => linegroupes[pos];
}

class Linegroupe {
  final int? id;
  final String? name;
  final int? price;

  Linegroupe({
    required this.id,
    required this.name,
    required this.price,
  });

  Linegroupe copyWith({
    int? id,
    String? name,
    int? price,
  }) {
    return Linegroupe(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
    };
  }

  factory Linegroupe.fromMap(Map<String, dynamic> map) {
    return Linegroupe(
      id: map['id']?.toInt(),
      name: map['name'],
      price: map['price']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Linegroupe.fromJson(String source) =>
      Linegroupe.fromMap(json.decode(source));

  @override
  String toString() => 'Linegroupes(id: $id, name: $name, price: $price)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Linegroupe &&
        other.id == id &&
        other.name == name &&
        other.price == price;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ price.hashCode;
}
