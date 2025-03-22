import 'package:flutter/material.dart';
import 'package:myfirstproject/config/dimensions.dart';
import 'package:myfirstproject/widget/big_text.dart';
import 'package:myfirstproject/widget/custom_elevated_button.dart';
import 'package:myfirstproject/widget/custom_outline_button.dart';
import 'package:myfirstproject/widget/custom_text_wrap.dart';

import '../../widget/small_text.dart';

class OrderTrackingScreen extends StatefulWidget {
  const OrderTrackingScreen({super.key});

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SmallText(
          text: 'Order Tracking',
          size: Dimensions.font20,
          color: Colors.white,
        ),
        backgroundColor: Color(0xff8CACFF),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back, color: Colors.white)),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [

          Image.asset('assets/fashion/map.png',
            fit: BoxFit.cover,
            width: double.infinity,
          ),

          SizedBox(height: Dimensions.height10,),

          SmallText(
            text: 'Delivery Arrival Time',
            size: Dimensions.font15,
            color: Colors.black,
          ),
          
          BigText(
            text: '12:14PM - 12:45PM',
            size: Dimensions.font18,
          ),
          
          ListTile(
            leading: Image.asset('assets/images/myAccount.png',width: Dimensions.height40,),
            title: SmallText(
              text: 'Mohan Jamadar',
              fontWeight: FontWeight.bold,
              color: Colors.black,
              size: Dimensions.font17,
            ),
            subtitle: SmallText(
              text: 'Delivery Man'
              ,color: Color(0xff737171),
            ),

            trailing: Container(
              height: Dimensions.height40,
              width: Dimensions.width80+Dimensions.width10,

              child: Row(
                children: [
                  Container(
                    height: Dimensions.height40,
                    width: Dimensions.width45-Dimensions.width5,
                    decoration: BoxDecoration(
                      color: Color(0xffFFFFFF),
                      borderRadius: BorderRadius.circular(Dimensions.radius50),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xf9c8c8c).withOpacity(0.4), // Slightly reduced opacity
                          blurRadius: 7,
                          offset: Offset(0, -1),
                        ),
                        BoxShadow(
                          color: Color(0xfd3b8b8).withOpacity(0.4), // Slightly reduced opacity
                          blurRadius: 7,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                    child: Icon(Icons.chat_outlined,color: Color(0xff8CACFF),),
                  ),
                  SizedBox(width: Dimensions.width10,),
                  Container(
                    height: Dimensions.height40,
                    width: Dimensions.width45-Dimensions.width5,
                    decoration: BoxDecoration(
                      color: Color(0xffFFFFFF),
                      borderRadius: BorderRadius.circular(Dimensions.radius50),
                      boxShadow: [
                        BoxShadow(
                          color:Color(0xf9c8c8c).withOpacity(0.4), // Slightly reduced opacity
                          blurRadius: 7,
                          offset: Offset(-1, -1),
                        ),
                        BoxShadow(
                          color: Color(0xfd3b8b8).withOpacity(0.4), // Slightly reduced opacity
                          blurRadius: 7,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                    child: Icon(Icons.call,color: Color(0xff8CACFF),),
                  )
                ],
              ),
            )

          )  , 
          
          Padding(
            padding: EdgeInsets.only(left: Dimensions.width10),
            child: ListTile(
              leading: Icon(Icons.check_circle,color: Color(0xff8CACFF),),
              title: SmallText(
                text: 'Order Place',
                fontWeight: FontWeight.bold,
                color: Colors.black,
                size: Dimensions.font17,
              ),
              subtitle: SmallText(
                text: '12:14PM to 12:45PM'
                ,color:Color(0xff737171),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(left: Dimensions.width10),
            child: ListTile(
              leading: Icon(Icons.location_on,color: Color(0xff5BB85D),),
              title: SmallText(
                text: 'Order Delivered',
                fontWeight: FontWeight.bold,
                color: Colors.black,
                size: Dimensions.font17,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SmallText(
                    text: 'Today 12:45PM'
                    ,color: Color(0xff737171),
                  ),
                  CustomTextWrap(
                    text: 'Pune, Kotharud, Dhanukar Colony, Flat No.7',
                    size: Dimensions.font14
                    ,color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: Dimensions.height20,),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomOutlineButton(
                text: 'Order Cancel',
                width: Dimensions.width150,
                height: Dimensions.height40,
                outlineColor: Color(0xff8CACFF),
                textColor: Color(0xff8CACFF),
              ),
              SizedBox(width: Dimensions.height20,),
              CustomElevatedButton(
                text: 'Back Home',
                width: Dimensions.width150,
                height: Dimensions.height40,
                textSize: Dimensions.font17,
                color: Color(0xff8CACFF),
              )
            ],
          )
        ],
      ),
    );
  }
}
