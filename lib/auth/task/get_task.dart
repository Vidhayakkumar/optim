import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:myfirstproject/auth/api_service/dio_client.dart';

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

  Future<List<Map<String, dynamic>>> getNoteLead(String jwtToken, int id)async{
    try{
      final response= await _dioClient.dio.get(
      '/employee/task/notes/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer $jwtToken',
          }
        )
      );
      if(response.statusCode == 200){
        return List<Map<String, dynamic>>.from(response.data);
      }else{
        throw Exception('Failed to get notes');
      }
    }catch(e){
      logger.e('failed to get note $e');
      throw Exception('Failed to access notes $e');
    }
  }
  Future<List<Map<String, dynamic>>> getLinkLead(String jwtToken, int id)async{
    try{
      final response= await _dioClient.dio.get(
          '/employee/task/links/$id',
          options: Options(
              headers: {
                'Authorization': 'Bearer $jwtToken',
              }
          )
      );
      if(response.statusCode == 200){
        return List<Map<String, dynamic>>.from(response.data);
      }else{
        throw Exception('Failed to get link');
      }
    }catch(e){
      logger.e('failed to get link $e');
      throw Exception('Failed to access link $e');
    }
  }
}
