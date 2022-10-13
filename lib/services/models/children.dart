import 'dart:convert';

import 'package:acciojob/services/models/groupe.dart';
import 'package:flutter/foundation.dart';

class ChildrenModel {
  static List<Children> childrens = [];

  static Children getById(int id) =>
      childrens.firstWhere((element) => element.id == id);

  static Children getByPosition(int pos) => childrens[pos];
}

class Children {
  final int? id;
  final String? name;
  final String? short_name;
  final String? short_description;
  final String? description;
  final String? content;
  final String? imageFile;
  final String? filename;
  final String? icon;
  final int? delais_execution;
  final String? image_url_base;
  final int? base_price;
  final String? parent;
  final bool? is_online;
  final bool? is_feature;
  final bool? is_filter;
  final List<Groupe>? groupes;

  Children(
      {required this.id,
      required this.name,
      required this.short_name,
      required this.short_description,
      required this.description,
      required this.content,
      required this.imageFile,
      required this.filename,
      required this.icon,
      required this.delais_execution,
      required this.image_url_base,
      required this.base_price,
      required this.parent,
      required this.is_online,
      required this.is_feature,
      required this.is_filter,
      required this.groupes});

  Children copyWith({
    int? id,
    String? name,
    String? short_name,
    String? short_description,
    String? description,
    String? content,
    String? imageFile,
    String? filename,
    String? icon,
    int? delais_execution,
    String? image_url_base,
    int? base_price,
    String? parent,
    bool? is_online,
    bool? is_feature,
    bool? is_filter,
    List<Groupe>? groupes,
  }) {
    return Children(
      id: id ?? this.id,
      name: name ?? this.name,
      short_name: short_name ?? this.short_name,
      short_description: short_description ?? this.short_description,
      description: description ?? this.description,
      content: content ?? this.content,
      imageFile: imageFile ?? this.imageFile,
      filename: filename ?? this.filename,
      icon: icon ?? this.icon,
      delais_execution: delais_execution ?? this.delais_execution,
      image_url_base: image_url_base ?? this.image_url_base,
      base_price: base_price ?? this.base_price,
      parent: parent ?? this.parent,
      is_online: is_online ?? this.is_online,
      is_feature: is_feature ?? this.is_feature,
      is_filter: is_filter ?? this.is_filter,
      groupes: groupes ?? this.groupes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'short_name': short_name,
      'short_description': short_description,
      'description': description,
      'content': content,
      'imageFile': imageFile,
      'filename': filename,
      'icon': icon,
      'delais_execution': delais_execution,
      'imageUrlBase': image_url_base,
      'basePrice': base_price,
      'parent': parent,
      'isOnline': is_online,
      'isFeature': is_feature,
      'is_filter': is_filter,
      'groupes': groupes?.map((x) => x.toMap()).toList(),
    };
  }

  factory Children.fromMap(Map<String, dynamic> map) {
    return Children(
      id: map['id']?.toInt(),
      name: map['name'],
      short_name: map['short_name'],
      short_description: map['short_description'],
      description: map['description'],
      content: map['content'],
      imageFile: map['imageFile'],
      filename: map['filename'],
      icon: map['icon'],
      delais_execution: map['delais_execution']?.toInt(),
      image_url_base: map['image_url_base'],
      base_price: map['base_price']?.toInt(),
      parent: map['parent'],
      is_online: map['is_online'],
      is_feature: map['is_feature'],
      is_filter: map['is_filter'],
      groupes: map['groupes'] != null
          ? List<Groupe>.from(map['groupes']?.map((x) => Groupe.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Children.fromJson(String source) =>
      Children.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Children(id: $id, name: $name, short_name: $short_name, short_description: $short_description, description: $description, content: $content, imageFile: $imageFile, filename: $filename, icon: $icon, delais_execution: $delais_execution, image_url_base: $image_url_base, base_price: $base_price, parent: $parent, is_online: $is_online, is_feature: $is_feature, is_filter: $is_filter, groupes: $groupes)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Children &&
        other.id == id &&
        other.name == name &&
        other.short_name == short_name &&
        other.short_description == short_description &&
        other.description == description &&
        other.content == content &&
        other.imageFile == imageFile &&
        other.filename == filename &&
        other.icon == icon &&
        other.delais_execution == delais_execution &&
        other.image_url_base == image_url_base &&
        other.base_price == base_price &&
        other.parent == parent &&
        other.is_online == is_online &&
        other.is_feature == is_feature &&
        other.is_filter == is_filter &&
        listEquals(other.groupes, groupes);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        short_name.hashCode ^
        short_description.hashCode ^
        description.hashCode ^
        content.hashCode ^
        imageFile.hashCode ^
        filename.hashCode ^
        icon.hashCode ^
        delais_execution.hashCode ^
        image_url_base.hashCode ^
        base_price.hashCode ^
        parent.hashCode ^
        is_online.hashCode ^
        is_feature.hashCode ^
        is_filter.hashCode ^
        groupes.hashCode;
  }
}
