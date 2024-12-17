
import 'package:flutter/material.dart';

import '../main.dart';
import 'Product_Screen.dart';

class UpdateScreen extends StatelessWidget{
  const UpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                          customTextFiled("Product name"),
                          const SizedBox(height: 20),
                          customTextFiled("Quantity"),
                          const SizedBox(height: 20),
                          customTextFiled("Product Code",),
                          const SizedBox(height: 20),
                          customTextFiled("HSN/SAC code", ),
                          const SizedBox(height: 20),
                          customTextFiled("Product Description", ),
                          const SizedBox(height: 20),
                          customTextFiled("Unite Price"),
                          const SizedBox(height: 20),

                          Row(
                            children: [

                              OutlinedButton(onPressed: (){}, child: const Text("Close"),style:
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

                                  child: ElevatedButton(onPressed: (){}, child:  Text("Submit",style: TextStyle(
                                      color: Colors.white
                                  ),),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromRGBO(
                                            13, 80, 175, 1.0),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(11)
                                        )
                                    ),
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

  Widget customTextFiled(String label1,){
    return TextField(
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
