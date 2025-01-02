

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:myfirstproject/auth/dio_client.dart';

class ApiAddTask {

  final DioClient _dioClient;
  ApiAddTask(this._dioClient);

  final logger=Logger();

  Future<void> addTask(String jwtToken,String taskOwner, String subject, String dueDate,
      String taskStatus,String taskPriority,String taskRemainder,String leadOfAccountType,
      String leadOfAccountId,String description)async{

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

}