class User {
  String? name; //멤버 변수들
  String? studentId;
  int? grade;
  String? major;
  String? subscriberEmail;
  String? portalEmail;

  User( // 사용자 객체를 생성할때 사용하는 생성자
      {this.name,
      this.studentId,
      this.grade,
      this.major,
      this.subscriberEmail,
      this.portalEmail});

  User.fromJson(Map<String, dynamic> json) { //주어진 Json 맵에서 각 필드를 추출하고, 사용자 객체의 속성에 할당
    name = json['name'];
    studentId = json['studentId'];
    grade = json['grade'];
    major = json['major'];
    subscriberEmail = json['subscriberEmail'];
    portalEmail = json['portalEmail'];
  }

  Map<String, dynamic> toJson() { //User 객체를 Json 형식의 맵으로 변환, 객체를 서버로 전송할 때 사용
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
