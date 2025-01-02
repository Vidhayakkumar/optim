
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:myfirstproject/auth/dio_client.dart';

class LeadOfAccount{

  final DioClient _dioClient;

  LeadOfAccount(this._dioClient);

  final logger=Logger();

  Future<List<Map<String, dynamic>>>  getLeadOfAccount(String uri, String jwtToken)async {

    try{ var response = await _dioClient.dio.
    get(uri,
        options: Options(
            headers: {
              'Authorization': 'Bearer $jwtToken',
            }
        )
    );

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(response.data);
    } else {
      throw Exception("Failed to get Leads Of Account data");
    }}catch(e){
      logger.e("Error occurred $e ");
      throw Exception("Error occurred $e ");
    }

  }

}