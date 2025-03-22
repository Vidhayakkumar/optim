import 'package:flutter/material.dart';
import 'package:myfirstproject/auth/product/api_add_data.dart';
import 'package:myfirstproject/auth/api_service/dio_client.dart';
import 'package:myfirstproject/home/product/product_page.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../config/dimensions.dart';
import '../../main.dart';

class UpdateProduct extends StatefulWidget {
  final Map<String, dynamic> product;
  final Future<void> Function() onUpdate;

  const UpdateProduct(
      {super.key, required this.product, required this.onUpdate});

  @override
  State<UpdateProduct> createState() => UpdateProductState();
}

class UpdateProductState extends State<UpdateProduct> {
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

    productNameController =
        TextEditingController(text: widget.product['productName'].toString());
    quantityController =
        TextEditingController(text: widget.product['quantity'].toString());
    unitPriceController =
        TextEditingController(text: widget.product['unitPrice'].toString());
    productCodeController =
        TextEditingController(text: widget.product['productCode'].toString());
    hsnController =
        TextEditingController(text: widget.product['hsn'].toString());
    productDescriptionController = TextEditingController(
        text: widget.product['productDescription'].toString());
    productIdController =
        TextEditingController(text: widget.product['productId'].toString());
    employeeIdController =
        TextEditingController(text: widget.product['employeeId'].toString());

    _loadJwtToken();
  }

  Future<void> _loadJwtToken() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      jwtToken = prefs.getString('jwtToken');
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: Dimensions.height50),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.all(Dimensions.height20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: Dimensions.height50,
                                child: Card(
                                    color: Colors.white,
                                    child: Center(
                                        child: customText(
                                            'Quick Create', " : EditProduct"))),
                              ),
                              SizedBox(height: Dimensions.height20),
                              customTextFiled(
                                  "Product name", productNameController),
                              SizedBox(height: Dimensions.height20),
                              customTextFiled("Quantity", quantityController),
                              SizedBox(height: Dimensions.height20),
                              customTextFiled(
                                  "Product Code", productIdController),
                              SizedBox(height: Dimensions.height20),
                              customTextFiled("HSN/SAC code", hsnController),
                              SizedBox(height: Dimensions.height20),
                              customTextFiled("Product Description",
                                  productDescriptionController),
                              SizedBox(height: Dimensions.height20),
                              customTextFiled(
                                  "Unite Price", unitPriceController),
                              SizedBox(height: Dimensions.height20),
                              SizedBox(
                                  width: Dimensions.width260,
                                  height: Dimensions.height45,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      var productName =
                                          productNameController.text;
                                      var quantity = quantityController.text;
                                      var unitPrice = unitPriceController.text;
                                      var productCode =
                                          productCodeController.text;
                                      var hsn = hsnController.text;
                                      var productDescription =
                                          productDescriptionController.text;
                                      var employeeId =
                                          employeeIdController.text;
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
                                        backgroundColor: const Color.fromRGBO(
                                            13, 80, 175, 1.0),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radius10))),
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
          ),
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
            borderRadius: BorderRadius.circular(Dimensions.radius10)),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xffD9D9D9)),
            borderRadius: BorderRadius.circular(Dimensions.radius10))),
  );
}
