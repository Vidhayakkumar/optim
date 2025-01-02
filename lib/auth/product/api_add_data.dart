
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:myfirstproject/auth/dio_client.dart';

class ApiAddData{
  final DioClient _dioClient;

  ApiAddData(this._dioClient);

  final logger=Logger();

  Future<void> userAddData(String jwtToken,String  productName, String productDescription,String productCode,String  hsn, String quantity,String unitPrice)async {


    Map<String, dynamic> data = {
      "productName": productName,
      "productDescription": productDescription,
      "productCode": productCode,
      "hsn": hsn,
      "quantity": quantity,
      "unitPrice": unitPrice,

    };
    var response=await _dioClient.dio
        .post('/employee/addProducts',
        options: Options(
          headers: {
            'Authorization': 'Bearer $jwtToken',
          },
        ),
        data: data);

    if(response.statusCode == 200){
      print("Data successfully send ${response.data}");


    }else{
      print("Failed to Data send ${response.statusCode}");

    }


  }

  Future<void> userUpdateData(String jwtToken,String  productName, String productDescription,String productCode,String  hsn, String quantity,double unitPrice,int productId,int employeeId)async {


    Map<String, dynamic> data = {
      "productName": productName,
      "productDescription": productDescription,
      "productCode": productCode,
      "hsn": hsn,
      "quantity": quantity,
      "unitPrice": unitPrice,
      "productId" :productId,
      "employeeId" : employeeId

    };
    var response=await _dioClient.dio
        .put('/employee/updateProduct',
        options: Options(
          headers: {
            'Authorization': 'Bearer $jwtToken',
          },
        ),
        data: data);
    var rData=response.data;
    print(rData);
    if(response.statusCode == 200){
      print("Data successfully Updated ${response.data}");


    }else{
      print("Failed to Data Updated${response.statusCode}");

    }


  }

  Future<void> userDeleteData(String jwtToken, int id)async{
    var response= await _dioClient.dio
        .delete('/employee/deleteProduct/${id}',
      options: Options(
        headers: {
          'Authorization': 'Bearer $jwtToken',
        }
      )
    );

    print(response.data);

    if(response.statusCode == 200){
      print("Data successfully deleted");
    }else{
      print("Data not deleted ");
    }

  }
}