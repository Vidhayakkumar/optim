import 'package:flutter/material.dart';
import 'package:myfirstproject/config/dimensions.dart';
import 'package:myfirstproject/home/marketing/payment_screen.dart';
import 'package:myfirstproject/widget/big_text.dart';
import 'package:myfirstproject/widget/custom_elevated_button.dart';
import 'package:myfirstproject/widget/custom_outline_button.dart';
import 'package:myfirstproject/widget/small_text.dart';

import '../../config/colors.dart';
import '../../widget/custom_textField.dart';

class NewAddressScreen extends StatefulWidget {
  const NewAddressScreen({super.key});

  @override
  State<StatefulWidget> createState() => _NewAddressScreenState();
}

class _NewAddressScreenState extends State<NewAddressScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController pinCodeController =
      TextEditingController(); // Corrected
  TextEditingController addressController = TextEditingController();
  TextEditingController localityController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController districtController = TextEditingController();

  bool checkValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: SmallText(
          text: 'Add New Address',
          size: Dimensions.font20,
          color: Colors.white,
        ),
        backgroundColor: Color(0xff8CACFF),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back, color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              left: Dimensions.width10,
              right: Dimensions.width10,
              top: Dimensions.height40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: Dimensions.width20, right: Dimensions.width20),
                child: Row(
                  children: [
                    SmallText(
                      text: 'Cart',
                      color: AppColors.mkMainColor,
                      size: Dimensions.font15,
                    ),
                    SizedBox(width: Dimensions.width5 - Dimensions.width2),
                    const Expanded(
                      child: Divider(
                        thickness: 1.3,
                        color: AppColors.mkMainColor,
                      ),
                    ),
                    SizedBox(width: Dimensions.width5 - Dimensions.width2),
                    SmallText(
                      text: 'Address Details',
                      color: AppColors.mkMainColor,
                      size: Dimensions.font15,
                    ),
                    SizedBox(width: Dimensions.width5 - Dimensions.width2),
                    const Expanded(
                      child: Divider(
                        thickness: 1.3,
                        color: Color(0xff666666),
                      ),
                    ),
                    SizedBox(width: Dimensions.width5 - Dimensions.width2),
                    SmallText(
                      text: 'Payment',
                      color: Color(0xff666666),
                      size: Dimensions.font15,
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.height20),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.width20),
                child: BigText(text: 'Contact Details'),
              ),
              SizedBox(height: Dimensions.height10),
              CustomTextField(
                  width: double.infinity,
                  controller: nameController,
                  borderColor: Color(0xffAAA9A9),
                  radius: Dimensions.radius10,
                  hint: 'Name'),
              SizedBox(height: Dimensions.height15),
              CustomTextField(
                  width: double.infinity,
                  controller: mobileController,
                  borderColor: Color(0xffAAA9A9),
                  radius: Dimensions.radius10,
                  hint: 'Mobile No'),
              SizedBox(height: Dimensions.height15),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.width20),
                child: BigText(text: 'Address'),
              ),
              SizedBox(height: Dimensions.height15),
              CustomTextField(
                  width: double.infinity,
                  controller: pinCodeController,
                  // Corrected
                  borderColor: Color(0xffAAA9A9),
                  radius: Dimensions.radius10,
                  hint: 'Pin Code'),
              SizedBox(height: Dimensions.height15),
              CustomTextField(
                  width: double.infinity,
                  controller: addressController,
                  // Corrected
                  borderColor: Color(0xffAAA9A9),
                  radius: Dimensions.radius10,
                  hint: 'Address (House No, Building, Street, Area)'),
              SizedBox(height: Dimensions.height15),
              CustomTextField(
                  width: double.infinity,
                  controller: localityController,
                  // Corrected
                  borderColor: Color(0xffAAA9A9),
                  radius: Dimensions.radius10,
                  hint: 'Locality / Town'),
              SizedBox(height: Dimensions.height15),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                        width: double.infinity,
                        controller: cityController,
                        // Corrected
                        borderColor: Color(0xffAAA9A9),
                        radius: Dimensions.radius10,
                        hint: 'City / District'),
                  ),
                  SizedBox(width: Dimensions.width20),
                  Expanded(
                    child: CustomTextField(
                        width: double.infinity,
                        controller: districtController,
                        // Corrected
                        borderColor: Color(0xffAAA9A9),
                        radius: Dimensions.radius10,
                        hint: 'City / District'),
                  ),
                ],
              ),
              SizedBox(height: Dimensions.height15),
              BigText(text: 'Save Address As'),
              SizedBox(height: Dimensions.height10),
              Row(
                children: [
                  CustomOutlineButton(
                    text: 'Home',
                    width: Dimensions.width80 + Dimensions.width10,
                    height: Dimensions.height40,
                    radius: Dimensions.radius20,
                    outlineColor: Color(0xff8CACFF),
                    textColor: Color(0xff8CACFF),
                  ),
                  SizedBox(width: Dimensions.width30),
                  CustomOutlineButton(
                    text: 'Work',
                    width: Dimensions.width80 + Dimensions.width10,
                    height: Dimensions.height40,
                    radius: Dimensions.radius20,
                    textColor: Color(0xff262729),
                    outlineColor: Color(0xff262729),
                  )
                ],
              ),
              SizedBox(height: Dimensions.height20),
              Row(
                children: [
                  Checkbox(
                      value: checkValue,
                      onChanged: (value) {
                        setState(() {
                          checkValue = value!;
                        });
                      }),
                  SmallText(
                    text: 'Make this default address',
                    color: Color(0xff262729),
                    size: Dimensions.font17,
                  )
                ],
              ),
              SizedBox(height: Dimensions.height15),
              Padding(
                padding: EdgeInsets.only(
                    left: Dimensions.width5, right: Dimensions.width5),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: ((_)=>PaymentScreen())));
                  },
                  child: CustomElevatedButton(
                    text: 'Continue',
                    color: Color(0xff8CACFF),
                    width: double.infinity,
                    textSize: Dimensions.font17,
                    height: Dimensions.height45,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
