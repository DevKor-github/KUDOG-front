class UserInfo {
  String? name;
  String? email;
  String? sendTime;
  List<String>? providerBookmarks;

  UserInfo({this.name, this.email, this.sendTime, this.providerBookmarks});

  UserInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    sendTime = json['sendTime'];
    providerBookmarks = json['providerBookmarks'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['sendTime'] = this.sendTime;
    data['providerBookmarks'] = this.providerBookmarks;
    return data;
  }
}
