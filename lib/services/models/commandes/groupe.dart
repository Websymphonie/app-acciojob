class GroupeModel {
  static List<Groupes> groupes = [];

  static Groupes getById(int id) =>
      groupes.firstWhere((element) => element.id == id);

  static Groupes getByPosition(int pos) => groupes[pos];
}

class Groupes {
  int? id;
  String? name;
  String? label;
  String? champ;

  Groupes({this.id, this.name, this.label, this.champ});

  Groupes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    label = json['label'];
    champ = json['champ'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['label'] = label;
    data['champ'] = champ;
    return data;
  }
}
