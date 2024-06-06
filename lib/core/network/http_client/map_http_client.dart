import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MapHttpClient {
  final _httpInstant = Dio(BaseOptions(
    baseUrl: 'https://places.googleapis.com/v1/',
    headers: {
      'Content-Type': 'application/json',
      'X-Goog-Api-Key': 'ENTER_API_KEY',
      'X-Goog-FieldMask':
          'places.displayName,places.formattedAddress,places.location',
    },
  ));

  Future<dynamic> postData(
    String path,
    dynamic body,
  ) async {
    try {
      final response = await _httpInstant.post<Map>(
        path,
        data: body,
      );
      return response.data;
    } catch (e) {
      return debugPrint('post error: $e');
    }
  }
}
