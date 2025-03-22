import 'package:flutter/material.dart';
import 'package:myfirstproject/config/colors.dart';
import 'package:myfirstproject/home/marketing/new_address_screen.dart';
import 'package:myfirstproject/widget/custom_elevated_button.dart';
import 'package:myfirstproject/widget/custom_horizontal_waise_text.dart';
import 'package:myfirstproject/widget/custom_text_wrap.dart';
import 'package:myfirstproject/widget/small_text.dart';

import '../../config/dimensions.dart';
import '../../widget/big_text.dart';
import '../../widget/custom_text_over_line.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'My Cart',
          style: TextStyle(
            color: Colors.white,
            fontSize: Dimensions.font20,
          ),
        ),
        backgroundColor: Color(0xff8CACFF),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: Dimensions.height40,
              left: Dimensions.width10,
              right: Dimensions.width10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Progress Indicator
                Padding(
                  padding: EdgeInsets.only(
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                  ),
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
                          color: Color(0xff666666),
                        ),
                      ),
                      SizedBox(width: Dimensions.width5 - Dimensions.width2),
                      SmallText(
                        text: 'Address Details',
                        color: Color(0xff666666),
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

                // Product Card
                SizedBox(height: Dimensions.height30),
                Container(
                  height: Dimensions.height140 + Dimensions.height10,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    border: Border.all(
                      color: Color(0xffDFDFDF),
                    ),
                  ),
                  child: Row(
                    children: [
                      // Product Image
                      Image.asset(
                        'assets/images/mouse2.png',
                        fit: BoxFit.cover,
                        height: double.infinity,
                      ),

                      // Product Details
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: Dimensions.width10,
                              top: Dimensions.height20,
                              right: Dimensions.width10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextWrap(
                                text: 'Logitech B 170 Wireless Mouse',
                                size: Dimensions.font17,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff0C0A0A),
                              ),
                              SizedBox(height: Dimensions.height5),
                              Row(
                                children: [
                                  CustomTextOverLine(
                                    firstText: '₹620',
                                    secondText: '₹560',
                                    size: Dimensions.font15,
                                  ),
                                  SizedBox(width: Dimensions.width10),
                                  BigText(
                                    text: '25% off',
                                    color: Color(0xff8CACFF),
                                    size: Dimensions.font15,
                                  ),
                                ],
                              ),
                              SizedBox(height: Dimensions.height5),
                              customRichText(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Coupon implementation
                SizedBox(height: Dimensions.height20),
                BigText(text: 'Add Coupon'),

                // Coupon card
                SizedBox(height: Dimensions.height10),
                Container(
                  height: Dimensions.height50,
                  width: Dimensions.width350 + Dimensions.width30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius10),
                    border: Border.all(
                      color: Color(0xffB2B1B1),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: Dimensions.width10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BigText(
                          text: 'Apply Coupon For Discount',
                          size: Dimensions.font18,
                          color: Color(0xff0C0A0A),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.arrow_forward_ios_rounded),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: Dimensions.height20),

                Padding(
                  padding: EdgeInsets.only(
                    left: Dimensions.width10,
                    right: Dimensions.width10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(
                        text: 'Price Details (1 item)',
                      ),
                      SizedBox(height: Dimensions.height20),
                      CustomHorizontalWiseText(
                        text1: 'Total MRP',
                        font1: Dimensions.font15,
                        fontWeight2: FontWeight.bold,
                        text2: '₹620',
                        font2: Dimensions.font17,
                      ),

                      SizedBox(height: Dimensions.height10),
                      CustomHorizontalWiseText(
                        text1: 'Discount on MRP',
                        font1: Dimensions.font15,
                        text2: '₹560',
                        font2: Dimensions.font17,
                        fontWeight2: FontWeight.bold,
                      ),

                      SizedBox(height: Dimensions.height10),
                      CustomHorizontalWiseText(
                        text1: 'Platform Fee',
                        font1: Dimensions.font15,
                        text2: 'FREE',
                        font2: Dimensions.font17,
                        fontWeight2: FontWeight.bold,
                      ),

                      SizedBox(height: Dimensions.height10),
                      CustomHorizontalWiseText(
                        text1: 'Shipping Fee',
                        font1: Dimensions.font15,
                        text2: 'FREE',
                        font2: Dimensions.font17,
                        fontWeight2: FontWeight.bold,
                      ),

                      // Divider
                      SizedBox(height: Dimensions.height5),
                      const Divider(
                        color: Color(0xff666666),
                      ),

                      CustomHorizontalWiseText(
                        text1: 'Total Amount',
                        font1: Dimensions.font15,
                        text2: '₹560',
                        font2: Dimensions.font17,
                        fontWeight1: FontWeight.bold,
                        fontWeight2: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: Dimensions.width20,
            bottom: Dimensions.height15,
            right: Dimensions.width20,
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: ((_)=>NewAddressScreen())));
              },
              child: CustomElevatedButton(
                text: 'Place Order',
                width: double.infinity,
                height: Dimensions.height45,
                color: Color(0xff8CACFF),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget customRichText() {
    return RichText(
      text: const TextSpan(
        children: [
          TextSpan(
            text: '7 Days ',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: 'return available',
            style: TextStyle(
                color: Color(0xff717070), fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
