

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import 'dio_client.dart';

class ApiProduct{


  final DioClient _dioClient;

  ApiProduct(this._dioClient);

  final logger = Logger();

  //get Products
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
        print(response.data);
        return List<Map<String, dynamic>>.from(response.data);

      } else {
        throw Exception('Failed to get products');
      }
    } catch (e) {
      print(e);
      throw Exception('Error occurred: $e');

    }
  }
}