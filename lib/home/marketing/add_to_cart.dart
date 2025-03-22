import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myfirstproject/config/dimensions.dart';
import 'package:myfirstproject/home/marketing/my_cart_screen.dart';
import 'package:myfirstproject/widget/big_text.dart';
import 'package:myfirstproject/widget/custom_text_over_line.dart';
import 'package:myfirstproject/widget/custom_text_wrap.dart';
import 'package:myfirstproject/widget/icon_and_text.dart';
import 'package:myfirstproject/widget/icon_and_text_elevated_button.dart';
import 'package:myfirstproject/widget/icon_and_text_outline_button.dart';
import 'package:myfirstproject/widget/small_text.dart';

class AddToCart extends StatefulWidget {
  const AddToCart({super.key});

  @override
  State<StatefulWidget> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  int originalQuantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff29658F),
      body: Column(
        children: [
          Container(
            height: Dimensions.height30 + Dimensions.height5,
            width: double.infinity,
            color: Color(0xfff8CACFF),
          ),
          Container(
            width: double.infinity,
            height: Dimensions.height375,
            color: Color(0xff29658F),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      top: Dimensions.height20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: Dimensions.height40,
                        width: Dimensions.height40,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius50)),
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Color(0xff8CACFF),
                            )),
                      ),
                      Container(
                        height: Dimensions.height40,
                        width: Dimensions.height40,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius50)),
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.share,
                              color: Color(0xff8CACFF),
                            )),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Image.asset(
                  'assets/images/mouse.png',
                  fit: BoxFit.cover,
                )),
              ],
            ),
          ),
          Container(
            height: Dimensions.height420 + Dimensions.height15 + Dimensions.height2,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.radius20),
                    topLeft: Radius.circular(Dimensions.radius20))),
            child: Padding(
              padding: EdgeInsets.only(
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  top: Dimensions.height20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomTextWrap(
                          text: 'Logitech B 170 Wireless Mouse',
                          size: Dimensions.font25,
                        ),
                      ),
                      IconAndText(
                          color: Color(0xffFFFFFF),
                          icon: Icons.star,
                          text: '4.9',
                          offSetRadius: 5,
                          blurRadius: 5,
                          textColor: Colors.black,
                          iconSize: Dimensions.iconSize15,
                          iconColor: Color(0xffFCC21B))
                    ],
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  Row(
                    children: [
                      CustomTextOverLine(
                        firstText: '₹620',
                        secondText: '₹560',
                        size: Dimensions.radius20,
                      ),
                      SizedBox(
                        width: Dimensions.width10,
                      ),
                      BigText(
                        text: '25% off',
                        color: Color(0xff8CACFF),
                        size: Dimensions.radius20,
                      )
                    ],
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  SmallText(
                    text: 'Select Qty',
                    color: Colors.black,
                    size: Dimensions.radius20,
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  Container(
                    width: Dimensions.width80 + Dimensions.width30,
                    height: Dimensions.height40,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffECECEC)),
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius10)),
                    child: Padding(
                      padding: EdgeInsets.only(left: Dimensions.width10),
                      child: Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                if (originalQuantity != 0) {
                                  setState(() {
                                    originalQuantity--;
                                  });
                                }
                              },
                              child: SvgPicture.asset(
                                  'assets/images/minus_circle.svg')),
                          SizedBox(
                            width: Dimensions.width10,
                          ),
                          Expanded(
                            child: BigText(
                              text: originalQuantity.toString(),
                              color: Colors.black,
                              size: Dimensions.font17,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  if (originalQuantity < 10) {
                                    originalQuantity++;
                                  }
                                });
                              },
                              icon: const Icon(
                                Icons.add_circle_outlined,
                                color: Color(0xff8CACFF),
                              ))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  customRichText(),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  customRichText1(),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  SmallText(
                    text: 'Delivery to pune 411008 - Updated location',
                    color: Color(0xff8CACFF),
                    size: Dimensions.font14,
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap:(){
                          Navigator.push(context, MaterialPageRoute(builder: ((_)=>MyCartScreen())));
                        },
                        child: IconAndTextElevatedButton(
                          text: 'Buy Now',
                          width: Dimensions.width150,
                          height: Dimensions.height40,
                          icon: Icons.shopping_basket_outlined,
                          color: Color(0xff8CACFF),
                        ),
                      ),
                      IconAndTextOutlineButton(
                        width: Dimensions.width150,
                        height: Dimensions.height40,
                        icon: Icons.add_shopping_cart_outlined,
                        text: 'Add to Cart',
                        textColor: Color(0xff8CACFF),
                        outlineColor: Color(0xff8CACFF),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget customRichText() {
    return RichText(
        text: const TextSpan(children: [
      TextSpan(
          text: 'FREE delivery ',
          style:
              TextStyle(color: Color(0xff8CACFF), fontWeight: FontWeight.bold)),
      TextSpan(
          text: 'Tuesday, 7 May on your first order.\n',
          style:
              TextStyle(color: Color(0xff000000), fontWeight: FontWeight.bold)),
      TextSpan(
          text: 'Details',
          style:
              TextStyle(color: Color(0xff8CACFF), fontWeight: FontWeight.bold))
    ]));
  }

  Widget customRichText1() {
    return RichText(
        text: const TextSpan(children: [
      TextSpan(
          text: 'Or fasted delivery ',
          style:
              TextStyle(color: Color(0xff000000), fontWeight: FontWeight.bold)),
      TextSpan(
          text: 'Today ',
          style:
              TextStyle(color: Color(0xff8CACFF), fontWeight: FontWeight.bold)),
      TextSpan(
          text: 'Order within ',
          style:
              TextStyle(color: Color(0xff000000), fontWeight: FontWeight.bold)),
      TextSpan(
          text: '1 hr 55 mins \n',
          style:
              TextStyle(color: Color(0xff69FF51), fontWeight: FontWeight.bold)),
      TextSpan(
          text: 'Details. ',
          style:
              TextStyle(color: Color(0xff8CACFF), fontWeight: FontWeight.bold)),
    ]));
  }
}
