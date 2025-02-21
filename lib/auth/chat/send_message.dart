import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:myfirstproject/auth/api_service/dio_client.dart';

class ApiSendMessage {
  final DioClient _dioClient;

  ApiSendMessage(this._dioClient);

  var logger = Logger();

  Future<void> sendMessage(
      String jwtToken, String message, int recipientId, int senderId) async {
    Map<String, dynamic> requestBody = {
      'content': message.toString(),
      'recipient': recipientId.toString(),
      'sender': senderId.toString()
    };

    try {
      final response = await _dioClient.dio.post('/employee/sendMessage',
          options: Options(headers: {'Authorization': 'Bearer $jwtToken'}),
          data: requestBody);
      if (response.statusCode == 200) {
        print("Message successfully send");
      } else {
        throw Exception('Error Occurred ');
      }
    } catch (e) {
      logger.e("Error Occurred $e");
      throw Exception('Error Occurred $e');
    }
  }

  Future<void> sendGroupMessage(String jwtToken, String content,
      String senderName, String senderId, int groupId, String timeStamp) async {
    Map<String, dynamic> requestBody = {
      'content': content,
      'senderName': senderName,
      'senderId': senderId,
      'groupId': groupId,
      'timestamp': timeStamp
    };

    try {
      final response = await _dioClient.dio.post('/employee/sendGroupMessage',
          options: Options(headers: {'Authorization': 'Bearer $jwtToken'}),
          data: requestBody);

      if(response.statusCode == 200){
        print("Message successfully send");
      }
    } catch (e) {
      logger.e('Error Occurred $e');
      throw Exception('Error Occurred $e');
    }
  }
}
