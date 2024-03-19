import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  static final DioClient _instance = DioClient._privateConstructor();
  factory DioClient() => _instance;
  final Dio _client = Dio(BaseOptions(
    baseUrl: 'https://api.kudog.devkor.club',
  ));

  DioClient._privateConstructor() {
    _client.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        String? token = sharedPreferences.getString("access_token");

        options.headers['Authorization'] = 'Bearer $token';
        options.headers['Content-Type'] = 'application/json';
        return handler.next(options);
      },
      onError: (e, handler) async {
        if (e.response?.statusCode == 401) {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          try {
            String? refreshToken = sharedPreferences.getString("refresh_token");

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
              String? newAccessToken = response.data["accessToken"];
              String? newRefreshToken = response.data["refreshToken"];
              sharedPreferences.setString("access_token", newAccessToken!);
              sharedPreferences.setString("refresh_token", newRefreshToken!);
              var headers = e.requestOptions.headers;

              headers.update(
                  'Authorization', (value) => 'Bearer $newAccessToken');
              Response responseWithNewToken = await Dio().request(
                  e.requestOptions.path,
                  options: Options(
                      method: e.requestOptions.method, headers: headers),
                  data: e.requestOptions.data,
                  queryParameters: e.requestOptions.queryParameters);

              return handler.resolve(responseWithNewToken);
            }
          } on DioError catch (e) {
            sharedPreferences.remove("access_token");
            sharedPreferences.remove("refresh_token");
            // TODO: 로그인 만료 피드백 및 로그인 화면으로
            return handler.reject(e);
          }
        }
      },
    ));
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    return await _client.post(path,
        options: options,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress);
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
  }) async {
    return await _client.get(path,
        options: options,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress);
  }

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    return await _client.put(path,
        options: options,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress);
  }

  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return await _client.delete(
      path,
      options: options,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
    );
  }

  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    return await _client.patch(path,
        options: options,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress);
  }

  Future<Response<T>> request<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    return await _client.request(path,
        options: options,
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress);
  }
}
