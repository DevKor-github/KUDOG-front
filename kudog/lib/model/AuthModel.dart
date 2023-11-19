class LoginUser {
  String? email;
  String? password;

  LoginUser({this.email, this.password});

  LoginUser.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}

class UserToken {
  String? accessToken;
  String? refreshToken;

  UserToken({this.accessToken, this.refreshToken});

  UserToken.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    data['refreshToken'] = this.refreshToken;
    return data;
  }
}

class SignUpUser {
  String? name;
  String? subscriberEmail;
  String? portalEmail;
  String? password;
  String? major;
  String? studentId;
  int? grade;

  SignUpUser(
      {this.name,
      this.subscriberEmail,
      this.portalEmail,
      this.password,
      this.major,
      this.studentId,
      this.grade});

  SignUpUser.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    subscriberEmail = json['subscriberEmail'];
    portalEmail = json['portalEmail'];
    password = json['password'];
    major = json['major'];
    studentId = json['studentId'];
    grade = json['grade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['subscriberEmail'] = this.subscriberEmail;
    data['portalEmail'] = this.portalEmail;
    data['password'] = this.password;
    data['major'] = this.major;
    data['studentId'] = this.studentId;
    data['grade'] = this.grade;
    return data;
  }
}
