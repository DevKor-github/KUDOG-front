class Subscribe {
  String name = '';
  String email = '';
  String provider = '';
  int id = 0;
  List<String> categories = List.empty(growable: true);

  Subscribe(
      {required this.name,
      required this.email,
      required this.provider,
      required this.id,
      required this.categories});

  Subscribe.fromJson(Map<String, dynamic> jsonMap) {
    name = jsonMap['name'];
    email = jsonMap['email'];
    provider = jsonMap['provider'];
    id = jsonMap['id'];

    for (int i = 0; i < jsonMap['categories'].length; i++) {
      categories.add(jsonMap['categories'][i]);
    }
  }

  static List<Subscribe> FromJson(
      Map<String, List<Map<String, dynamic>>> jsonMap) {
    List<Subscribe> list = List<Subscribe>.empty();

    list.add(Subscribe.fromJson(jsonMap['records']![0]));

    for (int i = 0; i < jsonMap['records']!.length; i++) {
      list.add(Subscribe.fromJson(jsonMap['records']![i]));
    }

    return list;
  }

  Map<String, dynamic> tojson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['provider'] = this.provider;
    data['id'] = this.id;
    data['categories'] = this.categories;
    return data;
  }
}
