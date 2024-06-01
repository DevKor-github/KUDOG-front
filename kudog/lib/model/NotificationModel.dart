class Notification {
  List<Records>? records;
  int? page;
  int? totalPage;
  int? totalRecords;
  int? pageSize;

  Notification(
      {this.records,
      this.page,
      this.totalPage,
      this.totalRecords,
      this.pageSize});

  Notification.fromJson(Map<String, dynamic> json) {
    if (json['records'] != null) {
      records = <Records>[];
      json['records'].forEach((v) {
        records!.add(new Records.fromJson(v));
      });
    }
    page = json['page'];
    totalPage = json['totalPage'];
    totalRecords = json['totalRecords'];
    pageSize = json['pageSize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.records != null) {
      data['records'] = this.records!.map((v) => v.toJson()).toList();
    }
    data['page'] = this.page;
    data['totalPage'] = this.totalPage;
    data['totalRecords'] = this.totalRecords;
    data['pageSize'] = this.pageSize;
    return data;
  }
}

class Records {
  String? title;
  String? body;
  String? date;
  bool? isNew;

  Records({this.title, this.body, this.date, this.isNew});

  Records.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
    date = json['date'];
    isNew = json['isNew'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['body'] = this.body;
    data['date'] = this.date;
    data['isNew'] = this.isNew;
    return data;
  }
}
