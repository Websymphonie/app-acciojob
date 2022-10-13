class EtatModel {
  static List<Status> status = [];

  static Status getById(int id) =>
      status.firstWhere((element) => element.id == id);

  static Status getByPosition(int pos) => status[pos];
}

class Status {
  int? id;
  String? name;
  String? color;
  String? icon;

  Status({this.id, this.name, this.color, this.icon});

  Status.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    color = json['color'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['color'] = color;
    data['icon'] = icon;
    return data;
  }
}
