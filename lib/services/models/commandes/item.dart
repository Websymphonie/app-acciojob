class ItemsModel {
  static List<Items> items = [];

  static Items getById(int id) =>
      items.firstWhere((element) => element.id == id);

  static Items getByPosition(int pos) => items[pos];
}

class Items {
  int? id;
  String? name;
  int? price;

  Items({this.id, this.name, this.price});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    return data;
  }
}
