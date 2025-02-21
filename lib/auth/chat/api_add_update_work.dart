

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:myfirstproject/auth/api_service/dio_client.dart';

class ApiAddUpdateWork{

  final DioClient _dioClient;
  ApiAddUpdateWork(this._dioClient);

  final logger = Logger();

  Future<void> makeGroup(String jwtToken,String groupName,Set<String> employeeIds,)async{

    try{
      final response = await _dioClient.dio.post(
      '/employee/createGroup/$groupName/$employeeIds/0',
          options: Options(
              headers: {
                'Authorization' : 'Bearer $jwtToken',
              }
          )
      );
      if(response.statusCode == 200){

      }else{
        throw Exception('Failed data to get');
      }
    }catch(e){
      logger.e('Error occurred $e');
      throw Exception('Error Occurred $e');
    }
  }

  Future<void> updateGroupName(String jwtToken, String groupName, String employeeIds, int groupId) async {

    // Convert Set<String> to List<String> before sending in the request body


    Map<String, dynamic> requestBody = {
      'groupId': groupId.toString(), // Ensure groupId is passed as a string
      'groupName': groupName,
      'memberList': employeeIds, // Pass the employee list (converted from Set)
    };

    try {
      final response = await _dioClient.dio.post(
        '/employee/group/update',
        options: Options(
          headers: {
            'Authorization': 'Bearer $jwtToken',
          },
        ),
        data: requestBody,
      );

      if (response.statusCode == 200) {
        // Handle success here
      } else {
        throw Exception('Failed to update group');
      }
    } catch (e) {
      logger.e('Error occurred $e');
      throw Exception('Error occurred $e');
    }
  }


  }

