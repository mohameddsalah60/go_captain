import 'dart:developer';

import 'package:dio/dio.dart';

class ApiService {
  final String _baseLink = 'https://api.authevo.dev/v1/otp';
  final Dio dio;
  final options = Options(
    headers: {
      "Content-Type": "application/json",
      'Authorization':
          'Bearer sk_db3c37fb1a950f8726cec0df7b056d3c45fcb06d2bd9031cdc755fe9e6b2eb75',
    },
  );

  ApiService({required this.dio});

  Future<Map<String, dynamic>> get({
    required String endPoint,
    String? endPoint2,
    int? id,
    Options? headers,
  }) async {
    final Response<dynamic> response;
    if (endPoint2 != null) {
      if (id != null) {
        response = await dio.get(
          '$_baseLink$endPoint$endPoint2$id',
          options: headers ?? options,
        );
      } else {
        response = await dio.get(
          '$_baseLink$endPoint$endPoint2',
          options: headers ?? options,
        );
      }
    } else {
      response = await dio.get(
        '$_baseLink/$endPoint',
        options: headers ?? options,
      );
    }
    return response.data;
  }

  Future<Map<String, dynamic>> post({
    required String endPoint,
    Options? headers,
    Object? data,
  }) async {
    final response = await dio.post(
      '$_baseLink/$endPoint',
      data: data,
      options: headers ?? options,
    );
    log("api service response :${response.data}");
    final responseData = response.data;

    return responseData;
  }

  Future<Map<String, dynamic>> put({
    required String endPoint,
    Options? headers,
    Object? data,
  }) async {
    final response = await dio.put(
      '$_baseLink$endPoint',
      data: data,
      options: headers ?? options,
    );

    final responseData = response.data;

    return responseData;
  }

  Future<Map<String, dynamic>> delete({
    required String endPoint,
    Options? headers,
    Object? data,
  }) async {
    final response = await dio.delete(
      '$_baseLink$endPoint',
      data: data,
      options: headers ?? options,
    );

    final responseData = response.data;

    return responseData;
  }

  Stream<Map<String, dynamic>> getStream({
    required String endPoint,
    Options? headers,
  }) async* {
    final Response<dynamic> response;

    response = await dio.get(
      '$_baseLink$endPoint',
      options: headers ?? options,
    );
    yield response.data;
  }
}
