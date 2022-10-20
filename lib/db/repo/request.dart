import 'package:dio/dio.dart';

import 'api_url.dart';

class DioClient {
  DioClient()
      : _dio = Dio(
          BaseOptions(
            baseUrl: AppApi.baseUrl,
            connectTimeout: DevEnvironment.connectTimeout,
            receiveTimeout: DevEnvironment.receiveTimeout,
            responseType: ResponseType.json,
          ),
        );

  late final Dio _dio;

  Future<Response> loginUser(mail, password) async {
    try {
      final response = await _dio
          .post("/api/v1/login", data: {"email": mail, "password": password});
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> createUser(mail, phone, password) async {
    try {
      final response = await _dio.post("/api/v1/registration",
          data: {"email": mail, "phone": phone, "password": password});
      print(response.data);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
