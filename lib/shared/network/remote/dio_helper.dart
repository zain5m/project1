import 'package:dio/dio.dart';
import 'package:project1/shared/network/remote/end_points.dart';

class DioHelper {
  static Dio? dio;
  static Map<String, dynamic>? headers = <String, dynamic>{};

  static void init() {
    dio = Dio(
      BaseOptions(
        // 192.168.1.11:8000/api/post/home
        // baseUrl: 'https://supermarket14.000webhostapp.com/api/',
        // baseUrl: 'http://localhost:8000/api/',
        // baseUrl: 'http://192.168.1.103:8000/api/',
        // baseUrl: 'http://192.168.1.103:8000/api/',
        baseUrl: '$HOST/api/',
        receiveDataWhenStatusError: true,

        validateStatus: (status) {
          return status! <= 500;
        },
      ),
    );
  }

  //!  details For Header
  static Future<Response> getData({
    required String? url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio!.options.headers = {
      "Accept": "application/json",
      'Authorization': "Bearer $token",
    };
    return await dio!.get(
      url!,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String? url,
    dynamic data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio!.options.headers = {
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    };

    return await dio!.post(
      url!,
      data: data,
      queryParameters: query,
    );
  }

  // static Future<Response> postDataImage({
  //   required String? url,
  //   dynamic data,
  //   Map<String, dynamic>? query,
  //   String? token,
  // }) async
  // {
  //   dio!.options.contentType = "application/javascript";
  //   dio!.options.headers["Authorization"] = "Bearer $token";
  //   // dio!.options.headers = {
  //   //   "Accept": "application/javascript",
  //   //   "Authorization": "Bearer $token",
  //   // };

  //   return await dio!.post(
  //     url!,
  //     data: data,
  //     queryParameters: query,
  //   );
  // }

  static Future<Response> putData({
    required String url,
    dynamic data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio!.options.headers = {
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    };
    return await dio!.put(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> deleteData({
    required String url,
    dynamic data,
    String? token,
    Map<String, dynamic>? query,
  }) async {
    dio!.options.headers = {
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    };

    return await dio!.delete(
      url,
      queryParameters: query,
      data: data,
    );
  }

  // static Future<Response> deleteData1({
  //   required String url,
  //   required Map<String, dynamic> data,
  //   Map<String, dynamic>? query,
  // }) async {
  //   return await dio!.(
  //     url,
  //     queryParameters: query,
  //     data: data,
  //   );
  // }
}
