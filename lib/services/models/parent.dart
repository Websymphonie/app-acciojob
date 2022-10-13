import 'package:acciojob/services/models/groupe.dart';

class ParentModel {
  static List<Parent> parents = [];

  static Parent getById(int id) =>
      parents.firstWhere((element) => element.id == id);

  static Parent getByPosition(int pos) => parents[pos];
}

class Parent {
  int? id;
  String? name;
  String? short_name;
  String? base_price;
  String? short_description;
  String? description;
  String? content;
  String? filename;
  String? icon;
  int? delais_execution;
  String? image_url_base;
  String? parent;
  bool? is_online;
  bool? is_feature;
  bool? is_filter;
  List<Groupe>? groupes;

  Parent(
      {this.id,
      this.name,
      this.short_name,
      this.base_price,
      this.short_description,
      this.description,
      this.content,
      this.filename,
      this.icon,
      this.delais_execution,
      this.image_url_base,
      this.parent,
      this.is_online,
      this.is_feature,
      this.is_filter,
      this.groupes});

  Parent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    short_name = json['short_name'];
    base_price = json['base_price'];
    short_description = json['short_description'];
    description = json['description'];
    content = json['content'];
    filename = json['filename'];
    icon = json['icon'];
    delais_execution = json['delais_execution'];
    image_url_base = json['image_url_base'];
    parent = json['parent'];
    is_online = json['is_online'];
    is_feature = json['is_feature'];
    is_filter = json['is_filter'];
    if (json['groupes'] != null) {
      groupes = <Groupe>[];
      json['groupes'].forEach((v) {
        groupes!.add(Groupe.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['short_name'] = short_name;
    data['base_price'] = base_price;
    data['short_description'] = short_description;
    data['description'] = description;
    data['content'] = content;
    data['filename'] = filename;
    data['icon'] = icon;
    data['delais_execution'] = delais_execution;
    data['image_url_base'] = image_url_base;
    data['parent'] = parent;
    data['is_online'] = is_online;
    data['is_feature'] = is_feature;
    data['is_filter'] = is_filter;
    if (groupes != null) {
      data['groupes'] = groupes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
