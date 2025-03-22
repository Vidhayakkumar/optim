import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myfirstproject/config/dimensions.dart';
import 'package:myfirstproject/home/marketing/order_history_screen.dart';
import 'package:myfirstproject/widget/big_text.dart';
import 'package:myfirstproject/widget/icon_text_icon_widget.dart';

import '../../widget/small_text.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({super.key});

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: SmallText(
          text: 'My Account',
          size: Dimensions.font20,
          color: Colors.white,
        ),
        backgroundColor: Color(0xff8CACFF),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back, color: Colors.white)),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xff8CACFF),
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.category_rounded), label: ''),
          BottomNavigationBarItem(
              icon: ColorFiltered(
                colorFilter: _currentIndex == 2
                    ? ColorFilter.mode(Color(0xff8CACFF), BlendMode.srcIn)
                    : ColorFilter.mode(Color(0xff5F5C5C), BlendMode.srcIn),
                child: SvgPicture.asset('assets/images/bxs_offer.svg'),
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: ColorFiltered(
                colorFilter: _currentIndex == 3
                    ? ColorFilter.mode(Color(0xff8CACFF), BlendMode.srcIn)
                    : ColorFilter.mode(Color(0xff5F5C5C), BlendMode.srcIn),
                child: SvgPicture.asset('assets/images/shopping.svg'),
              ),
              label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
        showUnselectedLabels: false,
        showSelectedLabels: false,
      ),
      body: Padding(
        padding: EdgeInsets.only(
            left: Dimensions.width15, right: Dimensions.width15),
        child: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: Dimensions.height30),
                  child:
                      Center(child: Image.asset('assets/images/myAccount.png')),
                ),
                Positioned(
                  bottom: -Dimensions.height5,
                  left: Dimensions.width200 + Dimensions.width5,
                  child: IconButton(
                    onPressed: () {},
                    icon: Container(
                      height: Dimensions.height40,
                      width: Dimensions.width45 - Dimensions.width5,
                      decoration: BoxDecoration(
                        color: Color(0xffFFFFFF),
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xf9c8c8c).withOpacity(0.4),
                            // Slightly reduced opacity
                            blurRadius:
                                Dimensions.height10 - Dimensions.height2,
                            offset: Offset(0, -1),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.edit_sharp,
                        color: Color(0xff8CACFF),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            BigText(
              text: 'Rohan Suryawanshi',
            ),
            SmallText(
              text: 'Rohan2003@gmail.com',
              color: Color(0xff666666),
            ),

            //

            SizedBox(
              height: Dimensions.height20,
            ),
            Container(
              height: Dimensions.height45,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xf9c8c8c).withOpacity(.2),
                        blurRadius: 1,
                        offset: Offset(1, 1)),
                    BoxShadow(
                        color: Color(0xf9c8c8c).withOpacity(.2),
                        blurRadius: 1,
                        offset: Offset(-1, -1))
                  ]),
              child: IconTextIconWidget(
                firstIcon: Icons.person_outline,
                firstImageColor: Color(0xff8CACFF),
                text: 'Your Profile',
                textSize: Dimensions.font17,
                secondIcon: Icons.keyboard_arrow_right,
                iconSizeSecond: Dimensions.iconSize24,
              ),
            ),

            SizedBox(
              height: Dimensions.height20,
            ),

            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: ((_)=>OrderHistoryScreen())));
              },
              child: Container(
                height: Dimensions.height45,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xf9c8c8c).withOpacity(.2),
                          blurRadius: 1,
                          offset: Offset(1, 1)),
                      BoxShadow(
                          color: Color(0xf9c8c8c).withOpacity(.2),
                          blurRadius: 1,
                          offset: Offset(-1, -1))
                    ]),
                child: IconTextIconWidget(
                  firstImage: 'assets/images/order_history.svg',
                  svgImageHeight1: Dimensions.height20,
                  width: Dimensions.width10,
                  leftPadding: Dimensions.width15,
                  text: 'Order History',
                  textSize: Dimensions.font17,
                  secondIcon: Icons.keyboard_arrow_right,
                  iconSizeSecond: Dimensions.iconSize24,
                ),
              ),
            ),

            SizedBox(
              height: Dimensions.height20,
            ),
            Container(
              height: Dimensions.height45,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xf9c8c8c).withOpacity(.2),
                        blurRadius: 1,
                        offset: Offset(1, 1)),
                    BoxShadow(
                        color: Color(0xf9c8c8c).withOpacity(.2),
                        blurRadius: 1,
                        offset: Offset(-1, -1))
                  ]),
              child: IconTextIconWidget(
                firstIcon: Icons.chat_outlined,
                firstImageColor: Color(0xff8CACFF),
                text: 'Live Chat',
                textSize: Dimensions.font17,
                secondIcon: Icons.keyboard_arrow_right,
                iconSizeSecond: Dimensions.iconSize24,
              ),
            ),

            SizedBox(
              height: Dimensions.height20,
            ),
            Container(
              height: Dimensions.height45,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xf9c8c8c).withOpacity(.2),
                        blurRadius: 1,
                        offset: Offset(1, 1)),
                    BoxShadow(
                        color: Color(0xf9c8c8c).withOpacity(.2),
                        blurRadius: 1,
                        offset: Offset(-1, -1))
                  ]),
              child: IconTextIconWidget(
                firstIcon: Icons.support_agent,
                firstImageColor: Color(0xff8CACFF),
                text: 'Customer Support',
                textSize: Dimensions.font17,
                secondIcon: Icons.keyboard_arrow_right,
                iconSizeSecond: Dimensions.iconSize24,
              ),
            ),

            SizedBox(
              height: Dimensions.height20,
            ),
            Container(
              height: Dimensions.height45,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xf9c8c8c).withOpacity(.2),
                        blurRadius: 1,
                        offset: Offset(1, 1)),
                    BoxShadow(
                        color: Color(0xf9c8c8c).withOpacity(.2),
                        blurRadius: 1,
                        offset: Offset(-1, -1))
                  ]),
              child: IconTextIconWidget(
                firstIcon: Icons.reviews_outlined,
                firstImageColor: Color(0xff8CACFF),
                text: 'Review  & Rating',
                textSize: Dimensions.font17,
                secondIcon: Icons.keyboard_arrow_right,
                iconSizeSecond: Dimensions.iconSize24,
              ),
            ),

            SizedBox(
              height: Dimensions.height20,
            ),
            Container(
              height: Dimensions.height45,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xf9c8c8c).withOpacity(.2),
                        blurRadius: 1,
                        offset: Offset(1, 1)),
                    BoxShadow(
                        color: Color(0xf9c8c8c).withOpacity(.2),
                        blurRadius: 1,
                        offset: Offset(-1, -1))
                  ]),
              child: IconTextIconWidget(
                firstImage: 'assets/images/help_center.svg',
                svgImageHeight1: Dimensions.height20,
                width: Dimensions.width10,
                leftPadding: Dimensions.width15,
                firstImageColor: Color(0xff8CACFF),
                text: 'FAQs& Help Center',
                textSize: Dimensions.font17,
                secondIcon: Icons.keyboard_arrow_right,
                iconSizeSecond: Dimensions.iconSize24,
              ),
            ),

            SizedBox(
              height: Dimensions.height20,
            ),
            Container(
              height: Dimensions.height45,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xf9c8c8c).withOpacity(.2),
                        blurRadius: 1,
                        offset: const Offset(1, 1)),
                    BoxShadow(
                        color: Color(0xf9c8c8c).withOpacity(.2),
                        blurRadius: 1,
                        offset: const Offset(-1, -1))
                  ]),
              child: IconTextIconWidget(
                firstIcon: Icons.logout_outlined,
                firstImageColor: const Color(0xff8CACFF),
                text: 'Log Out',
                textSize: Dimensions.font17,
                secondIcon: Icons.keyboard_arrow_right,
                iconSizeSecond: Dimensions.iconSize24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
