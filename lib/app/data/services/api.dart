import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:eoffice/app/data/services/secure_storage.dart';
import 'package:eoffice/app/data/utils/variables.dart';
import 'package:eoffice/app/routes/app_pages.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart' hide Response;

final dio = Dio(
  BaseOptions(
    baseUrl: dotenv.env['API_BASE_URL'] ?? '',
    headers: {'X-API-KEY': dotenv.env['X_API_KEY']},
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
  ),
);

String error(DioException v) {
  print(v.type);
  print(v.message);
  print(dio.options.baseUrl);
  switch (v.type) {
    case DioExceptionType.connectionTimeout:
      return AppVariable.rto;
    case DioExceptionType.badResponse:
      if (v.response!.statusCode == 401) {
        SecureStorageService().deleteData("token");
        Get.offAllNamed(Routes.LOGIN);
        return "Unauthorized";
      } else if (v.response != null) {
        return "${jsonDecode(v.response!.toString())['message']}";
      } else {
        return "${v.message}";
      }
    case DioExceptionType.connectionError:
      return AppVariable.noInternet;
    default:
      return AppVariable.unknown;
  }
}

class Api {
  var box = SecureStorageService();
  Future<Response> postWithoutToken({String? path, Object? data}) async {
    try {
      final response = await dio.post(path!, data: data);
      return response;
    } on DioException catch (e) {
      throw error(e);
    }
  }

  Future<Response> postWithToken({String? path, Object? data}) async {
    print(dio.options.baseUrl);
    var token = await box.getData("token");
    try {
      final response = await dio.post(
        path!,
        data: data,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      return response;
    } on DioException catch (e) {
      throw error(e);
    }
  }

  Future<Response> putWithToken({
    String? path,
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    var token = await box.getData("token");
    try {
      final response = await dio.put(
        path!,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      return response;
    } on DioException catch (e) {
      throw error(e);
    }
  }

  Future<Response> putFileToken({
    String? path,
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    var token = await box.getData("token");
    try {
      final response = await dio.put(
        path!,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: {"Authorization": "Bearer $token"},
          contentType: Headers.multipartFormDataContentType,
        ),
      );

      return response;
    } on DioException catch (e) {
      throw error(e);
    }
  }

  Future<Response> getWithToken({
    String? path,
    Map<String, dynamic>? queryParameters,
  }) async {
    var token = await box.getData("token");
    try {
      final response = await dio.get(
        path!,
        queryParameters: queryParameters,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      return response;
    } on DioException catch (e) {
      throw error(e);
    }
  }

  Future<Response> deleteWithToken({
    String? path,
    Map<String, dynamic>? queryParameters,
    Object? data,
  }) async {
    var token = await box.getData("token");
    try {
      final response = await dio.delete(
        path!,
        queryParameters: queryParameters,
        data: data,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      return response;
    } on DioException catch (e) {
      throw error(e);
    }
  }
}
