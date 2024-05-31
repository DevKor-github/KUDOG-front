import 'dart:convert';

class NoticeList {
  List<Notice>? notices;
  int? page;
  int? totalPage;
  int? totalNotice;

  String? name;
  String? email;
  String? provider;
  List<String>? categories;
  String? sendTime;

  int? id;

  NoticeList(
      {this.notices, this.page, this.totalPage, this.totalNotice, this.id});

  void addFromJson(Map<String, dynamic> json, {String key = 'notices'}) {
    if (json[key] != null) {
      json[key].forEach((v) {
        notices!.add(new Notice.fromJson(v));
      });
    }
  }

  NoticeList.fromJson(Map<String, dynamic> json, {String key = 'notices'}) {
    id = json['id'];

    if (key == null) key = 'notices';
    if (json[key] != null) {
      notices = <Notice>[];
      json[key].forEach((v) {
        notices!.add(new Notice.fromJson(v));
      });
    }
    page = json['page'];
    totalPage = json['totalPage'];
    totalNotice = json['totalNotice'];

    name = json['name'];
    email = json['email'];
    provider = json['provider'];
    sendTime = json['sendTime'];

    json['categories']?.forEach((v) {
      categories = [];
      categories!.add(v);
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notices != null) {
      data['notices'] = this.notices!.map((v) => v.toJson()).toList();
    }
    data['page'] = this.page;
    data['totalPage'] = this.totalPage;
    data['totalNotice'] = this.totalNotice;
    return data;
  }
}

class Notice {
  late int id;
  late String title;
  late bool scrapped;
  late String date;
  late String mappedCategory;
  late String provider;
  late List<int> scrapBoxId;

  // Notice(
  //     {this.id,
  //     this.title,
  //     this.scrapped,
  //     this.date,
  //     this.mappedCategory,
  //     this.provider,
  //     this.scrapBoxId});

  Notice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    scrapped = json['scrapped'];
    date = json['date'];
    mappedCategory = json['category'];
    provider = json['provider'];
    scrapBoxId = json['scrapBoxId'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['scrapped'] = this.scrapped;
    data['date'] = this.date;
    data['mappedCategory'] = this.mappedCategory;
    data['provider'] = this.provider;
    data['scrapBoxId'] = this.scrapBoxId;
    return data;
  }
}

class SelectedNoticeList {
  List<Notice>? notices;
  String? page;
  int? totalNotice;
  int? totalPage;

  SelectedNoticeList(
      {this.notices, this.page, this.totalNotice, this.totalPage});

  SelectedNoticeList.fromJson(Map<String, dynamic> json) {
    if (json['notices'] != null) {
      notices = <Notice>[];
      json['notices'].forEach((v) {
        notices!.add(new Notice.fromJson(v));
      });
    }
    page = json['page'];
    totalNotice = json['totalNotice'];
    totalPage = json['totalPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notices != null) {
      data['notices'] = this.notices!.map((v) => v.toJson()).toList();
    }
    data['page'] = this.page;
    data['totalNotice'] = this.totalNotice;
    data['totalPage'] = this.totalPage;
    return data;
  }

  addFromJson(Map<String, dynamic> json) {
    if (json['notices'] != null) {
      json['notices'].forEach((v) {
        notices!.add(new Notice.fromJson(v));
      });
    }
    page = json['page'];
    totalNotice = json['totalNotice'];
    totalPage = json['totalPage'];
  }
}

class Filter {
  List<String>? categories;
  List<String>? providers;
  String? startDate;
  String? endDate;
  int? page;
  int pageSize = 10;
  String? keyword;

  Filter(
      {this.categories,
      this.providers,
      this.startDate,
      this.endDate,
      this.page,
      this.keyword});
}

class NoticeDetail {
  int? id;
  String? title;
  String? content;
  String? writer;
  String? date;
  String? url;
  int? view;
  bool? scrapped;
  int? scrapCount;
  String? provider;
  String? category;
  List<int>? scrapBoxId;
  String? mappedCategory;

  NoticeDetail(
      {this.id,
      this.title,
      this.content,
      this.writer,
      this.date,
      this.url,
      this.view,
      this.scrapped,
      this.scrapCount,
      this.provider,
      this.category,
      this.scrapBoxId,
      this.mappedCategory});

  NoticeDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    writer = json['writer'];
    date = json['date'];
    url = json['url'];
    view = json['view'];
    scrapped = json['scrapped'];
    scrapCount = json['scrapCount'];
    provider = json['provider'];
    category = json['category'];
    scrapBoxId = json['scrapBoxId'].cast<int>();
    mappedCategory = json['mappedCategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['writer'] = this.writer;
    data['date'] = this.date;
    data['url'] = this.url;
    data['view'] = this.view;
    data['scrapped'] = this.scrapped;
    data['scrapCount'] = this.scrapCount;
    data['provider'] = this.provider;
    data['category'] = this.category;
    data['scrapBoxId'] = this.scrapBoxId;
    data['mappedCategory'] = this.mappedCategory;
    return data;
  }
}
