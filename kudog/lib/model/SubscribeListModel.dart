import 'dart:convert';

class Subscribe {
  String? name;
  String? email;
  String? provider;
  int? id;
  List<String>? categories = List.empty(growable: true);

  Subscribe({this.name, this.email, this.provider, this.categories});

  Subscribe.fromJson(Map<String, dynamic> jsonMap) {
    name = jsonMap['name'];
    email = jsonMap['email'];
    provider = jsonMap['provider'];
    id = jsonMap['id'];

    for (int i = 0; i < jsonMap['categories'].length; i++) {
      categories?.add(jsonMap['categories'][i]);
    }
  }

  static List<Subscribe> FromJson(
      Map<String, List<Map<String, dynamic>>> jsonMap) {
    List<Subscribe> list = List<Subscribe>.empty();

    print(jsonMap['records']![0]);

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
