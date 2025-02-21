

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:myfirstproject/auth/api_service/dio_client.dart';

class ApiAddTask {

  final DioClient _dioClient;
  ApiAddTask(this._dioClient);

  final logger=Logger();

  Future<void> addTask(String jwtToken,String taskOwner, String subject, String dueDate, String taskStatus,String taskPriority,String taskRemainder,String leadOfAccountType, String leadOfAccountId,String description)async{

    Map<String,dynamic> data={
      'taskOwner': taskOwner,
      'subject': subject,
      'duedate': dueDate,
      'status': taskStatus,
      'priority': taskPriority,
      'reminderDate': taskRemainder,
      'leadIdOrAccountId': leadOfAccountId,
      'leadOrAccountType': leadOfAccountType,
      'description': description,
    };

    var response= await _dioClient.dio.
    post('/employee/addtask',
      options: Options(
        headers: {
          'Authorization' : 'Bearer $jwtToken'
        }
      ),data: data
    );
    if(response.statusCode==200){
      print("Data successfully send ${response.data}");
    }else{
      print('Failed to Data Send ${response.data}');
    }
  }

  Future<void> updateTask(String jwtToken,String taskOwner, String subject,String status, String reminderDate,String priority,String leadOrAccountType,String leadOrAccountId,String id,String dueDate,String description)async{

    Map<String, dynamic> data={
      'taskOwner': taskOwner,
      'subject': subject,
      'duedate': dueDate,
      'id' :id,
      'status': status,
      'priority': priority,
      'reminderDate': reminderDate,
      'leadIdOrAccountId': leadOrAccountId,
      'leadOrAccountType': leadOrAccountType,
      'description': description,
    };

    var response= await _dioClient.dio.
    put('/employee/taskupdate',
      options: Options(
          headers: {
            'Authorization' : 'Bearer $jwtToken'
          }
      ),data: data
    );

    if(response.statusCode == 200){

        print('Data successfully updated ${response.data}');

    }else{
      print('Error occurred ${response.data}');
    }

  }

  Future<void> addLeadLink(String jwtToken, int taskId, String label,String linkDescription,String url)async {
    Map<String ,dynamic> data={
      'taskId': taskId,
      'label' : label,
      'linkDescription' :linkDescription,
      'url' : url
    };

    var response= await _dioClient.dio.post(
      '/employee/addlink',
      options: Options(
        headers: {
          'Authorization' : 'Bearer $jwtToken'
        }
      ),data: data
    );

    if(response.statusCode == 200){
      print("leadLink successfully Added");
    }else{
      print('Failed to add leadLink ');
    }
  }

  Future<Map<String, dynamic>> addLeadNotes({
    required String jwtToken,
    File? file,
    required Map<String, dynamic> dto,
  }) async {
    try {
      MultipartFile? filePart;
      if (file != null) {
        filePart = await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        );
      }
      String dtoJson = jsonEncode(dto);
      FormData formData = FormData.fromMap({
        'dto': dtoJson,
        if (filePart != null) 'file': filePart,
      });

      final response = await _dioClient.dio.post(
        '/employee/addnote',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $jwtToken',
          },
          contentType: 'multipart/form-data',
        ),
      );

      // Check the response status and return data
      if (response.statusCode == 200) {
        return Map<String, dynamic>.from(response.data);
      } else {
        throw Exception(
            'Failed to add Notes. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle errors
      throw Exception('Error during add Notes: $e');
    }
  }

}