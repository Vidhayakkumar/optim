import 'package:flutter/material.dart';
import 'package:myfirstproject/auth/product/api_add_data.dart';
import 'package:myfirstproject/auth/api_service/dio_client.dart';
import 'package:myfirstproject/product/product_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';

class EditScreen extends StatefulWidget {
  final Map<String, dynamic> product;
  final Future<void> Function() onUpdate;

  const EditScreen({super.key, required this.product, required this.onUpdate});

  @override
  State<EditScreen> createState() => EditScreenState();
}

class EditScreenState extends State<EditScreen> {

  String? jwtToken;


  final ApiAddData _apiAddData = ApiAddData(DioClient());
  TextEditingController productNameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController unitPriceController = TextEditingController();
  TextEditingController productCodeController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController hsnController = TextEditingController();
  TextEditingController productIdController = TextEditingController();
  TextEditingController employeeIdController = TextEditingController();

  @override
  void initState() {
    super.initState();

    productNameController = TextEditingController(text: widget.product['productName'].toString());
    quantityController = TextEditingController(text: widget.product['quantity'].toString());
    unitPriceController =TextEditingController(text: widget.product['unitPrice'].toString());
    productCodeController =TextEditingController(text: widget.product['productCode'].toString());
    hsnController =TextEditingController(text: widget.product['hsn'].toString());
    productDescriptionController = TextEditingController(text: widget.product['productDescription'].toString());
    productIdController =TextEditingController(text: widget.product['productId'].toString());
    employeeIdController =TextEditingController(text: widget.product['employeeId'].toString());

    _loadJwtToken();

  }


  Future<void> _loadJwtToken()async{
    try{
      SharedPreferences prefs =await SharedPreferences.getInstance();
      jwtToken = prefs.getString('jwtToken');
    }catch(e){}
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return Scaffold(
        body: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 35.0),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 50,
                          child: Card(
                              child: Center(
                                  child: customText(
                                      'Quick Create', " : EditProduct"))),
                        ),
                        const SizedBox(height: 20),
                        customTextFiled("Product name", productNameController),
                        const SizedBox(height: 20),
                        customTextFiled("Quantity", quantityController),
                        const SizedBox(height: 20),
                        customTextFiled("Product Code", productCodeController),
                        const SizedBox(height: 20),
                        customTextFiled("HSN/SAC code", hsnController),
                        const SizedBox(height: 20),
                        customTextFiled("Product Description",productDescriptionController),
                        const SizedBox(height: 20),
                        customTextFiled("Unite Price", unitPriceController),
                        const SizedBox(height: 20),
                        const SizedBox(width: 10,),
                        SizedBox(width: mq.width * 0.66, height: 50,
                            child: ElevatedButton(
                              onPressed: () async {
                                var productName = productNameController.text;
                                var quantity = quantityController.text;
                                var unitPrice = unitPriceController.text;
                                var productCode = productCodeController.text;
                                var hsn = hsnController.text;
                                var productDescription = productDescriptionController.text;
                                var employeeId = employeeIdController.text;
                                var productId = productIdController.text;

                                int pId = int.parse(productId);
                                int eId = int.parse(employeeId);
                                double unit = double.parse(unitPrice);

                                await _apiAddData.userUpdateData(
                                    jwtToken!,
                                    productName,
                                    productDescription,
                                    productCode,
                                    hsn,
                                    quantity,
                                    unit,
                                    pId,
                                    eId);

                                widget.onUpdate;

                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromRGBO(13, 80, 175, 1.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(11))),
                              child: const Text(
                                "Submit",
                                style: TextStyle(color: Colors.white),
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}

Widget customTextFiled(String label1, TextEditingController controller) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
        label: Text(label1),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xff027DC3)),
            borderRadius: BorderRadius.circular(11)),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xffD9D9D9)),
            borderRadius: BorderRadius.circular(11))),
  );
}
