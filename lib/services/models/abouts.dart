class AboutModel {
  static List<About> abouts = [];

  static About getById(int id) =>
      abouts.firstWhere((element) => element.id == id);

  static About getByPosition(int pos) => abouts[pos];
}

class About {
  int? id;
  String? name;
  String? description;

  About(
      {this.id,
        this.name,
        this.description});

  About.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    return data;
  }
}
