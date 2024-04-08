class SubscribeList {
  String? title;

  String? department;
  List<String>? categories;

  SubscribeList({this.title, this.department, this.categories});

  SubscribeList.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    department = json['department'];
    categories = json['scrapped'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['department'] = this.department;
    data['categories'] = this.categories;
    return data;
  }
}
