class UpperCategory {
  int? id;
  String? name;

  UpperCategory({this.id, this.name});

  UpperCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class LowerCategory {
  int? id;
  String? name;
  String? url;
  UpperCategory? upperCategory;

  LowerCategory({this.id, this.name, this.url, this.upperCategory});

  LowerCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    url = json['url'];
    upperCategory = json['provider'] != null
        ? new UpperCategory.fromJson(json['provider'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['url'] = this.url;
    if (this.upperCategory != null) {
      data['provider'] = this.upperCategory!.toJson();
    }
    return data;
  }
}
