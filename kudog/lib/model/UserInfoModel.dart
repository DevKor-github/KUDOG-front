class UserInfo {
  String? name;
  String? email;
  String? password;
  String? sendTime;

  UserInfo({this.name, this.email, this.password, this.sendTime});

  UserInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    sendTime = json['sendTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['sendTime'] = this.sendTime;
    return data;
  }
}
