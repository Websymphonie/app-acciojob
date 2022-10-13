import 'dart:convert';

class CommuneModel {
  static List<Commune> communes = [];

  static Commune getById(int id) =>
      communes.firstWhere((element) => element.id == id);

  static Commune getByPosition(int pos) => communes[pos];
}

class Commune {
  final int? id;
  final String? name;

  Commune({
    required this.id,
    required this.name,
  });

  Commune copyWith({
    int? id,
    String? name,
  }) {
    return Commune(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Commune.fromMap(Map<String, dynamic> map) {
    return Commune(
      id: map['id']?.toInt(),
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Commune.fromJson(String source) =>
      Commune.fromMap(json.decode(source));

  @override
  String toString() => 'Communes(id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Commune && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
