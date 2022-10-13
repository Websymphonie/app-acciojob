class CategoriesModel {
  static List<Categories> categories = [];

  static Categories getById(int id) =>
      categories.firstWhere((element) => element.id == id);

  static Categories getByPosition(int pos) => categories[pos];
}

class Categories {
  int? id;
  String? name;
  String? filename;
  String? icon;
  int? delaisExecution;
  String? imageUrlBase;

  Categories(
      {this.id,
      this.name,
      this.filename,
      this.icon,
      this.delaisExecution,
      this.imageUrlBase});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    filename = json['filename'];
    icon = json['icon'];
    delaisExecution = json['delais_execution'];
    imageUrlBase = json['image_url_base'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['filename'] = filename;
    data['icon'] = icon;
    data['delais_execution'] = delaisExecution;
    data['image_url_base'] = imageUrlBase;
    return data;
  }
}
