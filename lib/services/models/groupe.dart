import 'dart:convert';

import 'package:acciojob/services/models/linegroupe.dart';
import 'package:flutter/foundation.dart';

class GroupeModel {
  static List<Groupe> groupes = [];

  static Groupe getById(int id) =>
      groupes.firstWhere((element) => element.id == id);

  static Groupe getByPosition(int pos) => groupes[pos];
}

class Groupe {
  final int? id;
  String? name;
  final String? label;
  final String? champtype;
  final List<Linegroupe>? linegroupes;

  Groupe({
    required this.id,
    required this.name,
    required this.label,
    required this.champtype,
    required this.linegroupes,
  });

  Groupe copyWith({
    int? id,
    String? name,
    String? label,
    String? champtype,
    List<Linegroupe>? linegroupes,
  }) {
    return Groupe(
      id: id ?? this.id,
      name: name ?? this.name,
      label: label ?? this.label,
      champtype: champtype ?? this.champtype,
      linegroupes: linegroupes ?? this.linegroupes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'label': label,
      'champtype': champtype,
      'linegroupes': linegroupes?.map((x) => x.toMap()).toList(),
    };
  }

  factory Groupe.fromMap(Map<String, dynamic> map) {
    return Groupe(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      label: map['label'] ?? '',
      champtype: map['champtype'] ?? '',
      linegroupes: map['linegroupes'] != null
          ? List<Linegroupe>.from(
              map['linegroupes']?.map((x) => Linegroupe.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Groupe.fromJson(String source) => Groupe.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Groupes(id: $id, name: $name, label: $label, champtype: $champtype, linegroupes: $linegroupes)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Groupe &&
        other.id == id &&
        other.name == name &&
        other.label == label &&
        other.champtype == champtype &&
        listEquals(other.linegroupes, linegroupes);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        label.hashCode ^
        champtype.hashCode ^
        linegroupes.hashCode;
  }
}
