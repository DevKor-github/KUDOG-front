class Notice {
  //글 간단 정보
  int? id;
  String? title;
  String? date;
  bool? scrapped;

  Notice({this.id, this.title, this.date, this.scrapped});

  Notice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    date = json['date'];
    scrapped = json['scrapped'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['date'] = this.date;
    data['scrapped'] = this.scrapped;
    return data;
  }
}

class NoticeDetail {
  int? id;
  String? title;
  String? content;
  String? date;
  int? view;
  String? url;
  bool? scrapped;
  String? writer;
  int? scrapCount;
  String? category;
  String? provider;

  NoticeDetail(
      {this.id,
      this.title,
      this.content,
      this.date,
      this.view,
      this.url,
      this.scrapped,
      this.writer,
      this.scrapCount,
      this.category,
      this.provider});

  NoticeDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    date = json['date'];
    view = json['view'];
    url = json['url'];
    scrapped = json['scrapped'];
    writer = json['writer'];
    scrapCount = json['scrapCount'];
    category = json['category'];
    provider = json['provider'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['date'] = this.date;
    data['view'] = this.view;
    data['url'] = this.url;
    data['scrapped'] = this.scrapped;
    data['writer'] = this.writer;
    data['scrapCount'] = this.scrapCount;
    data['category'] = this.category;
    data['provider'] = this.provider;
    return data;
  }
}

class NoticeList {
  List<Notice>? notices;
  int? page;
  int? totalNotice;
  int? totalPage;

  NoticeList({this.notices, this.page, this.totalNotice, this.totalPage});

  NoticeList.fromJson(Map<String, dynamic> json) {
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
}
