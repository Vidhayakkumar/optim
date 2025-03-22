
import 'package:flutter/material.dart';
import 'package:myfirstproject/config/dimensions.dart';
import 'package:myfirstproject/widget/custom_outline_button.dart';
import 'package:myfirstproject/widget/custom_search_bar.dart';
import 'package:myfirstproject/widget/icon_and_text_elevated_button.dart';

import '../../widget/big_text.dart';
import '../../widget/custom_text_over_line.dart';
import '../../widget/custom_text_wrap.dart';
import '../../widget/small_text.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: SmallText(
          text: 'Order History',
          size: Dimensions.font20,
          color: Colors.white,
        ),
        backgroundColor: Color(0xff8CACFF),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back, color: Colors.white)),
      ),
      body: Container(
        margin: EdgeInsets.only(
            left: Dimensions.width10,
            right: Dimensions.width10,
            top: Dimensions.height40),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius15),
                  border: Border.all(
                    color: Color(0xffADADAD),
                  )),
              child: CustomSearchBar(
                width: double.infinity,
                height: Dimensions.height45,
                radius: Dimensions.radius15,
                prefixIcon: Icons.search,
                suffixIcon: Icons.mic_none,
                controller: searchController,
                hint: 'Search by product',
              ),
            ),
            SizedBox(
              height: Dimensions.height50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomOutlineButton(
                  text: 'View Product',
                  width: Dimensions.width125 + Dimensions.width5,
                  height: Dimensions.height40,
                  radius: Dimensions.radius15,
                  outlineColor: Color(0xff8CACFF),
                  textColor: Color(0xff8CACFF),
                )
              ],
            ),
            SizedBox(
              height: Dimensions.height20,
            ),
            Container(
              height: Dimensions.height140 + Dimensions.height10,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
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
            SizedBox(
              height: Dimensions.height10,
            ),
            BigText(
              text: '03 May 2024 at 12:14Pm',
              size: Dimensions.font18,
            ),
            SizedBox(
              height: Dimensions.height20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomOutlineButton(
                  text: 'Cancelled',
                  width: Dimensions.width125 + Dimensions.width5,
                  height: Dimensions.height40,
                  radius: Dimensions.radius15,
                  textColor: Color(0xff8CACFF),
                  outlineColor: Color(0xff8CACFF),
                ),
                IconAndTextElevatedButton(
                  text: 'Reorder',
                  width: Dimensions.width125 + Dimensions.width5,
                  height: Dimensions.height40,
                  radius: Dimensions.radius15,
                  textSize: Dimensions.font17,
                  color: Color(0xff8CACFF),
                  icon: Icons.replay,
                )
              ],
            )
          ],
        ),
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
