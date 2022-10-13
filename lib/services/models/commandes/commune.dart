class CommuneModel {
  static List<Communes> communes = [];

  static Communes getById(int id) =>
      communes.firstWhere((element) => element.id == id);

  static Communes getByPosition(int pos) => communes[pos];
}

class Communes {
  int? id;
  String? name;

  Communes({this.id, this.name});

  Communes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
