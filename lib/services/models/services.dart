class ServiceModel {
  static List<Service> services = [];

  static Service getById(int id) =>
      services.firstWhere((element) => element.id == id);

  static Service getByPosition(int pos) => services[pos];
}

class Service {
  int? id;
  String? name;
  String? filename;
  String? description;

  Service({this.id, this.name, this.filename, this.description});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    filename = json['filename'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['filename'] = filename;
    data['description'] = description;
    return data;
  }

  factory Service.fromMap(Map<String, dynamic> map) {
    return Service(
        id: map['id']?.toInt() ?? 0,
        name: map['name'] ?? '',
        filename: map['filename'] ?? '',
        description: map['description'] ?? '');
  }
}
