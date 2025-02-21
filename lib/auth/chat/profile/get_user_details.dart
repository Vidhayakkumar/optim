
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:myfirstproject/auth/api_service/dio_client.dart';

class GetUserDetails{
  final DioClient _dioClient;
  GetUserDetails(this._dioClient);

  final logger = Logger();

  Future<Map<String, dynamic>> getUserDetailsData(String jwtToken, int id)async{

    try{
      final response = await _dioClient.dio.get(
        '/employee/user/$id',
          options: Options(
              headers: {
                'Authorization' : 'Bearer $jwtToken',
              }
          )
      );
      if(response.statusCode == 200){
        return Map<String, dynamic>.from(response.data);
      }else{
        throw Exception('Error Occurred getting data');
      }
    }catch(e){
      logger.e('Error Occurred $e');
      throw Exception('Error Occurred $e');
    }

  }

}