import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:myfirstproject/auth/dio_client.dart';

class ApiTask {
  final DioClient _dioClient;

  ApiTask(this._dioClient);

  final logger = Logger();

  Future<List<Map<String, dynamic>>> getTasks(String jwtToken) async {
    try {
      final response = await _dioClient.dio.get(
        '/employee/tasklist',
        options: Options(
          headers: {
            'Authorization': 'Bearer $jwtToken',
          },
        ),
      );

      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(response.data);
      } else {
        throw Exception("Failed to get tasks");
      }
    } catch (e) {
      logger.e("Error occurred $e");
      throw Exception("Error occurred $e");
    }
  }
}
