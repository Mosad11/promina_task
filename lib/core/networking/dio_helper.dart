import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://flutter.prominaagency.com/api/',
        receiveDataWhenStatusError: true,
        followRedirects: false,
        contentType: "multipart/form-data",
        validateStatus: (status) {
          return status! < 500;
        }));
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio!.options.headers = {'Authorization': "Bearer $token"};
    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> postData(
      {required String url,
      Map<String, dynamic>? query,
      String? token,
      required Map<String, dynamic> data}) async {
    dio!.options.headers = {'Authorization': "Bearer $token"};
    return dio!.post(url, queryParameters: query, data: FormData.fromMap(data));
  }

  static Future<Response> putData(
      {required String url,
      Map<String, dynamic>? query,
      String? token,
      required dynamic data}) async {
    dio!.options.headers = {'Authorization': "Bearer $token"};
    return dio!.post(url, queryParameters: query, data: data);
  }
}
