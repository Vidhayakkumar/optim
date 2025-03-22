import 'package:flutter/material.dart';
import 'package:myfirstproject/auth/product/api_add_data.dart';
import 'package:myfirstproject/auth/api_service/dio_client.dart';
import 'package:myfirstproject/widget/custom_elevated_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../config/colors.dart';
import '../../config/dimensions.dart';
import '../../main.dart';
import '../../widget/custom_outline_button.dart';
import 'product_page.dart';

class AddProduct extends StatefulWidget {
  final Future<void> Function() onUpdate;

  const AddProduct({super.key, required this.onUpdate});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String? jwtToken;

  final ApiAddData _apiAddData = ApiAddData(DioClient());

  TextEditingController productNameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController unitPriceController = TextEditingController();
  TextEditingController productCodeController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController hsnController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadJwtToken();
  }

  Future<void> _loadJwtToken() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      jwtToken = prefs.getString('jwtToken');
    } catch (e) {
      throw Exception('Error occurred');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Container(
          margin: EdgeInsets.only(top: Dimensions.height30),
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding:  EdgeInsets.all(Dimensions.height18),
                  child: Column(
                    children: [
                      SizedBox(
                        height: Dimensions.height50,
                        child: Card(
                            child: Center(
                                child: customText(
                                    'Quick Create', " : Product Name"))),
                      ),
                      SizedBox(height: Dimensions.height20),
                      customTextFiled("Product name", productNameController),
                      SizedBox(height: Dimensions.height20),
                      customTextFiled("Quantity", quantityController),
                      SizedBox(height: Dimensions.height20),
                      customTextFiled("Product Code", productCodeController),
                      SizedBox(height: Dimensions.height20),
                      customTextFiled("HSN/SAC code", hsnController),
                      SizedBox(height: Dimensions.height20),
                      customTextFiled("Product Description", productDescriptionController),
                      SizedBox(height: Dimensions.height20),
                      customTextFiled("Unite Price", unitPriceController),
                      SizedBox(height: Dimensions.height20),
                      Row(
                        children: [

                          GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: CustomOutlineButton(
                              text: 'Close',
                              width: Dimensions.width80,
                              height: Dimensions.height40,
                              textColor: AppColors.outlineButtonTextColor,
                            ),
                          ),
                          SizedBox(width: Dimensions.width10),

                          /// Submit Button
                          GestureDetector(
                            onTap: () async {
                              var productName = productNameController.text.toString();
                              var quantity = quantityController.text.toString();
                              var unitPrice = unitPriceController.text.toString();
                              var productCode = productCodeController.text.toString();
                              var productDescription = productDescriptionController.text.toString();
                              var hsn = hsnController.text.toString();

                              await _apiAddData.userAddData(
                                  jwtToken!,
                                  productName,
                                  productDescription,
                                  productCode,
                                  hsn,
                                  quantity,
                                  unitPrice);

                              widget.onUpdate;
                              Navigator.pop(context);
                            },
                              child: CustomElevatedButton(text: 'Submit', width: Dimensions.width260, height: Dimensions.height40,textSize: Dimensions.font17,))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ));
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
}
