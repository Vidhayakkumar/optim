import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:myfirstproject/auth/api_service/dio_client.dart';

import '../../model/group_model.dart';

class ApiChat {
  final DioClient _dioClient;
  ApiChat(this._dioClient);

  final logger=Logger();

  Future<List<Map<String,dynamic>>> getChatEmployeeList(String jwtToken)async{
    try{
      final response = await _dioClient.dio.get(
          '/employee/getEmployeeList',
          options: Options(
              headers: {
                'Authorization' : 'Bearer $jwtToken',
              }
          )
      );
      if(response.statusCode == 200){
       return List<Map<String,dynamic>>.from(response.data);

      }else{
        throw Exception('Failed data to get');
      }
    }catch(e){
      logger.e('Error occurred $e');
      throw Exception('Error Occurred $e');
    }

  }

  Future<List<GroupModel>> getGroupNameList(String jwtToken) async {
    try {
      final response = await _dioClient.dio.get(
        '/employee/getGroupList',
        options: Options(
          headers: {
            'Authorization': 'Bearer $jwtToken',
          },
        ),
      );

      if (response.statusCode == 200) {
        var user = User.fromJson(response.data);
        return user.groupChats;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }

  Future<List<Map<String,dynamic>>> getMessage(String jwtToken,String senderId ,String receiverId)async{
    try{

      final response= await _dioClient.dio.get(
        '/employee/getMessage/$senderId/$receiverId',
        options: Options(
          headers: {
            'Authorization' : 'Bearer $jwtToken'
          }
        )
      );

      if(response.statusCode == 200){
        return List<Map<String,dynamic>>.from(response.data);
      }else{
        throw Exception('Error Occurred Failed to get messages');
      }

    }catch(e){
      logger.e('Error occurred $e');
      throw Exception('Error Occurred $e');
    }
  }

  Future<List<Map<String,dynamic>>>  getGroupMessage(String jwtToken, String groupId)async{
    try{
      final response = await _dioClient.dio.get(
      '/employee/getGroupMessages/$groupId',
        options: Options(
          headers: {
            'Authorization' : 'Bearer $jwtToken'
          }
        )
      );

      if(response.statusCode == 200){
        return List<Map<String,dynamic>>.from(response.data);
      }else{
        throw Exception('Error Occurred');
      }

    }catch(e){
      logger.e('Error Occurred $e');
      throw Exception('Error Occurred $e');
    }
  }

}