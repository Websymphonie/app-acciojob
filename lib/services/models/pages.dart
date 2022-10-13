class PageModel {
  static List<Page> pages = [];

  static Page getById(int id) =>
      pages.firstWhere((element) => element.id == id);

  static Page getByPosition(int pos) => pages[pos];
}

class Page {
  int? id;
  String? name;
  String? content;

  Page(
      {this.id,
        this.name,
        this.content});

  Page.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['content'] = content;
    return data;
  }
}
