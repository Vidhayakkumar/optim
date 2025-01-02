
import 'package:flutter/material.dart';
import 'package:myfirstproject/auth/product/api_add_data.dart';
import 'package:myfirstproject/auth/dio_client.dart';

import '../main.dart';
import 'product_page.dart';

class AddProduct extends StatefulWidget{
  final Future<void> Function() onUpdate;
  const AddProduct({super.key, required this.onUpdate});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {

  String jwtToken ="eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhbGVuQGdtYWlsLmNvbSIsImlhdCI6MTczNTEzNDkxNSwiZXhwIjoxNzM1MzE0OTE1fQ.Y0BhggRkwEyR205-cKYPWDzT1u44t12WYQs38OjAXVEpgdh7XSjf1tkqouYwrpPMkQJMQC4CquWsdVzirDE4Lw";


  final ApiAddData _apiAddData=ApiAddData(DioClient());



  TextEditingController productNameController=TextEditingController();

  TextEditingController quantityController=TextEditingController();

  TextEditingController unitPriceController=TextEditingController();


  TextEditingController productCodeController=TextEditingController();

  TextEditingController productDescriptionController =TextEditingController();

  TextEditingController hsnController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    mq=MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 35.0),
            child: Container(
              width: double.infinity,
              child: Column(
                children: [

                  Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50,
                            child: Card(
                                child: Center(child: customText('Quick Create', " : Product Name"))),
                          ),
                          const SizedBox(height: 20),
                          customTextFiled("Product name",productNameController),
                          const SizedBox(height: 20),
                          customTextFiled("Quantity",quantityController),
                          const SizedBox(height: 20),
                          customTextFiled("Product Code",productCodeController),
                          const SizedBox(height: 20),
                          customTextFiled("HSN/SAC code", hsnController),
                          const SizedBox(height: 20),
                          customTextFiled("Product Description", productDescriptionController),
                          const SizedBox(height: 20),
                          customTextFiled("Unite Price",unitPriceController),
                          const SizedBox(height: 20),

                          Row(
                            children: [

                              OutlinedButton(onPressed: (){
                                Navigator.pop(context);
                              }, child: const Text("Close"),style:
                              OutlinedButton.styleFrom(
                                  overlayColor: Color(0xff027DC3),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)
                                  )
                              )),
                              const SizedBox(width: 10,),

                              SizedBox(
                                  width: mq.width * 0.66,
                                  height: 50,

                                  child: ElevatedButton(onPressed: ()async {

                                    var productName=productNameController.text.toString();

                                    var quantity=quantityController.text.toString();
                                    var unitPrice=unitPriceController.text.toString();

                                    var productCode=productCodeController.text.toString();
                                    var productDescription=productDescriptionController.text.toString();
                                    var hsn=hsnController.text.toString();


                                     await _apiAddData.userAddData(jwtToken,productName, productDescription, productCode, hsn, quantity,  unitPrice);

                                     widget.onUpdate;
                                    Navigator.pop(context);


                                  },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromRGBO(
                                            13, 80, 175, 1.0),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(11)
                                        )
                                    ), child:  const Text("Submit",style: TextStyle(
                                      color: Colors.white
                                  ),),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),

                    ],
                  ),
              ),
            ),

        ],
      )


    );
  }

  Widget customTextFiled(String label1, TextEditingController controller){
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        label: Text(label1),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color:Color(0xff027DC3)
          ),
          borderRadius: BorderRadius.circular(11)
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xffD9D9D9)
          ),
          borderRadius: BorderRadius.circular(11)
        )
      ),
    );
  }
}
