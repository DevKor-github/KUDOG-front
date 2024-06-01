class ScrapList {
  List<Scrap> scraps = [];
  bool isInit = false;

  ScrapList();

  ScrapList.fromJson(Map<String, dynamic> json, {String key = 'notices'}) {
    if (key == null) key = 'notices';

    if (json[key] != null) {
      scraps = <Scrap>[];
      json[key].forEach((v) {
        scraps.add(new Scrap.fromJson(v));
      });
    }
  }
}

class Scrap {
  String? name;
  String? description;
  int? id;
  int? noticeCount;

  Scrap({this.name, this.description, this.id, this.noticeCount});

  Scrap.fromJson(Map<String, dynamic> jsonMap) {
    name = jsonMap['name'];
    description = jsonMap['description'];
    id = jsonMap['id'];
    noticeCount = jsonMap['noticeCount'];
  }

  Map<String, dynamic> tojson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['id'] = this.id;
    data['noticeCount'] = this.noticeCount;
    return data;
  }
}
