import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:lash_map/db/models/client_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      print(response.data);

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> sendNewPassword(mail) async {
    try {
      final response =
          await _dio.post("/api/v1/restore", data: {"email": mail});

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> updateUserInfo(fullName, phone, lang) async {
    var prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";
    try {
      _dio.options.headers["token"] = token;

      final response = await _dio.put("/api/v1/account",
          data: {"fullName": fullName, "phone": phone, "lang": lang});

      return response;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<Response> updatePassword(password) async {
    var prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";
    try {
      _dio.options.headers["token"] = token;

      final response = await _dio
          .put("/api/v1/account/password", data: {"password": password});

      return response;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<Response> getUserInfo() async {
    var prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";
    print(token);

    try {
      _dio.options.headers["token"] = token;

      final response = await _dio.get("/api/v1/user");

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> updateClientInfo(id, fullName, phone, comment) async {
    var prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";
    try {
      _dio.options.headers["token"] = token;
      final response = await _dio.put("/api/v1/clients/$id",
          data: {"fullName": fullName, "phone": phone, "comment": comment});

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> getClientInfo(int id) async {
    var prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";

    try {
      _dio.options.headers["token"] = token;

      final response = await _dio.get("/api/v1/clients/$id");

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> deleteClient(int id) async {
    var prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";

    try {
      _dio.options.headers["token"] = token;

      final response = await _dio.delete("/api/v1/clients/$id");

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Response> addNewClient(fullName, phone, comment) async {
    var prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";
    try {
      _dio.options.headers["token"] = token;
      final response = await _dio.post("/api/v1/clients",
          data: {"fullName": fullName, "phone": phone, "comment": comment});

      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<ClientList>> getClients() async {
    var prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";
    try {
      _dio.options.headers["token"] = token;
      final response = await _dio.get(
        "/api/v1/clients",
      );
      final List data = response.data["data"]["clients"];
      List<ClientList> list =
          data.map((data) => ClientList.fromMap(data)).toList();

      list.sort(
        (a, b) {
          return a.fullName.toLowerCase().compareTo(b.fullName.toLowerCase());
        },
      );
      return list;
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
