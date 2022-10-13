import 'dart:convert';

import 'package:acciojob/services/models/children.dart';
import 'package:flutter/foundation.dart';

class ServiceModel {
  static List<Service> services = [];

  static Service getById(int id) =>
      services.firstWhere((element) => element.id == id);

  static Service getByPosition(int pos) => services[pos];
}

class Service {
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
  final String? base_price;
  final String? parent;
  final List<Children>? children;
  final bool? is_online;
  final bool? is_feature;
  final bool? is_filter;

  Service(
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
      required this.children,
      required this.is_online,
      required this.is_feature,
      required this.is_filter});

  Service copyWith({
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
    String? base_price,
    String? parent,
    List<Children>? children,
    bool? is_online,
    bool? is_feature,
    bool? is_filter,
  }) {
    return Service(
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
      children: children ?? this.children,
      is_online: is_online ?? this.is_online,
      is_feature: is_feature ?? this.is_feature,
      is_filter: is_filter ?? this.is_filter,
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
      'image_url_base': image_url_base,
      'base_price': base_price,
      'parent': parent,
      'children': children?.map((x) => x.toMap()).toList(),
      'is_online': is_online,
      'is_feature': is_feature,
      'is_filter': is_filter,
    };
  }

  factory Service.fromMap(Map<String, dynamic> map) {
    return Service(
        id: map['id']?.toInt() ?? 0,
        name: map['name'] ?? '',
        short_name: map['short_name'] ?? '',
        short_description: map['short_description'] ?? '',
        description: map['description'] ?? '',
        content: map['content'] ?? '',
        imageFile: map['imageFile'] ?? '',
        filename: map['filename'] ?? '',
        icon: map['icon'] ?? '',
        delais_execution: map['delais_execution']?.toInt() ?? 0,
        image_url_base: map['image_url_base'] ?? '',
        base_price: map['base_price'] ?? '',
        parent: map['parent'],
        children: map['children'] != null
            ? List<Children>.from(
                map['children']?.map((x) => Children.fromMap(x)))
            : null,
        is_online: map['is_online'],
        is_feature: map['is_feature'],
        is_filter: map['is_filter']);
  }

  String toJson() => json.encode(toMap());

  factory Service.fromJson(String source) =>
      Service.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Service(id: $id, name: $name, short_name: $short_name, short_description: $short_description, description: $description, content: $content, imageFile: $imageFile, filename: $filename, icon: $icon, delais_execution: $delais_execution, image_url_base: $image_url_base, base_price: $base_price, parent: $parent, children: $children, is_online: $is_online, is_feature: $is_feature, is_filter: $is_filter)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Service &&
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
        listEquals(other.children, children) &&
        other.is_online == is_online &&
        other.is_feature == is_feature &&
        other.is_filter == is_filter;
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
        children.hashCode ^
        is_online.hashCode ^
        is_feature.hashCode ^
        is_filter.hashCode;
  }
}
