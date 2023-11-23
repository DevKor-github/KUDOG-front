class User {
  String? name;
  String? studentId;
  int? grade;
  String? major;
  String? subscriberEmail;
  String? portalEmail;

  User(
      {this.name,
      this.studentId,
      this.grade,
      this.major,
      this.subscriberEmail,
      this.portalEmail});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    studentId = json['studentId'];
    grade = json['grade'];
    major = json['major'];
    subscriberEmail = json['subscriberEmail'];
    portalEmail = json['portalEmail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['studentId'] = this.studentId;
    data['grade'] = this.grade;
    data['major'] = this.major;
    data['subscriberEmail'] = this.subscriberEmail;
    data['portalEmail'] = this.portalEmail;
    return data;
  }
}
