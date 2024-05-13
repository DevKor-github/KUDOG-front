class ScrapBox {
  String? name;
  String? description;
  int? id;
  int? noticeCount;

  ScrapBox({this.name, this.description, this.id, this.noticeCount});

  ScrapBox.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    id = json['id'];
    noticeCount = json['noticeCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['id'] = this.id;
    data['noticeCount'] = this.noticeCount;
    return data;
  }
}
