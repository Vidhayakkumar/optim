//get Products
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import 'dio_client.dart';

class ApiService {
  final DioClient _dioClient;

  ApiService(this._dioClient);

  final logger = Logger();

  Future<Map<String, dynamic>> loginUser(String email, String password) async {
    var response = await _dioClient.dio
        .post('/signin', data: {"username": email, "password": password});
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('');
    }
  }
}
