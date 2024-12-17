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

//
// Future<Map<String, dynamic>> loginUser(String email, String password) async {
//
//
//   Dio dio = Dio();
//
//
//
//   // Define the URL of your backend authentication endpoint
//   const String url = 'http://164.52.197.27:8082/signin';
//
//   // Define the payload (you may need to adjust the structure based on your API)
//   Map<String, dynamic> loginData = {
//
//     "username":email,
//     "password":password
//   };
//
//   try {
//     // Send a POST request to the server
//     Response response = await dio.post(url, data: loginData);
//
//     // Check if login was successful
//     if (response.statusCode == 200) {
//
//       String token=response.data['role'];
//
//       return token;
//
//
//     } else {
//
//
//
//       print('Login failed: ${response.data['message']}');
//       return response.data['message'];
//
//
//     }
//   } catch (e) {
//
//     return "Error occurred";
//
//
//
//   }
// }
