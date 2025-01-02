import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../dio_client.dart';

class ApiProduct {
  final DioClient _dioClient;

  ApiProduct(this._dioClient);

  final logger = Logger();

  Future<List<Map<String, dynamic>>> getProducts(String jwtToken) async {
    try {
      final response = await _dioClient.dio.get(
        '/employee/getAllProducts',
        options: Options(
          headers: {
            'Authorization': 'Bearer $jwtToken',
          },
        ),
      );
      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(response.data);
      } else {
        throw Exception('Failed to get products');
      }
    } catch (e) {
      logger.e('Error occurred: $e');
      throw Exception('Error occurred: $e');
    }
  }
}