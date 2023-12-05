import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenService{
  void refreshToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? refreshToken = sharedPreferences.getString("refresh_token");
    try {
      Response response = await Dio().post(
        "https://api.kudog.devkor.club/auth/refresh",
        options: Options(
          headers: {
            'Authorization': 'Bearer $refreshToken',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 201) {
        print("POST 요청 성공");
        String? newAccessToken = response.data["accessToken"];
        String? newRefreshToken = response.data["responseToken"];
        sharedPreferences.setString("access_token", newAccessToken!);
        sharedPreferences.setString("refresh_token", newRefreshToken!);
      } else {
        print("POST 요청 실패");
        print("Status Code : ${response.statusCode}");
      }
    } catch (e) {
      print("POST 요청 에러");
      print(e.toString());
    }
  }
}