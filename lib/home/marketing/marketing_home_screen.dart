import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myfirstproject/home/marketing/add_to_cart.dart';
import 'package:myfirstproject/home/marketing/beauty_screen.dart';
import 'package:myfirstproject/home/marketing/electronics_screen.dart';
import 'package:myfirstproject/home/marketing/fashion_screen.dart';
import 'package:myfirstproject/home/marketing/mobile_screen.dart';
import 'package:myfirstproject/home/marketing/my_account_screen.dart';
import 'package:myfirstproject/widget/big_text.dart';
import 'package:myfirstproject/widget/custom_search_bar.dart';
import 'package:myfirstproject/widget/custom_text_over_line.dart';
import 'package:myfirstproject/widget/icon_and_text_vertical.dart';
import 'package:myfirstproject/widget/small_text.dart';
import 'package:myfirstproject/widget/text_and_Icon.dart';

import '../../config/dimensions.dart';

class MarketingHomeScreen extends StatefulWidget {
  const MarketingHomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MarketingHomeScreenState();
}

class _MarketingHomeScreenState extends State<MarketingHomeScreen> {
  TextEditingController searchController = TextEditingController();

  var _currentIndex = 0;

  final List<Map<String, dynamic>> images = [
    {'image': 'assets/images/phone.png', 'name': 'mobiles'},
    {'image': 'assets/images/fashion.png', 'name': 'Fashions'},
    {'image': 'assets/images/electronic.png', 'name': 'Electronics'},
    {'image': 'assets/images/beauty.png', 'name': 'Beauty'}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xff8CACFF),
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 4) {
            Navigator.push(context, MaterialPageRoute(builder: ((_) => MyAccountScreen())));
          }
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: '',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: ColorFiltered(
              colorFilter: _currentIndex == 2
                  ? ColorFilter.mode(Color(0xff8CACFF), BlendMode.srcIn)
                  : ColorFilter.mode(Color(0xff5F5C5C), BlendMode.srcIn),
              child: SvgPicture.asset('assets/images/bxs_offer.svg'),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: ColorFiltered(
              colorFilter: _currentIndex == 3
                  ? ColorFilter.mode(Color(0xff8CACFF), BlendMode.srcIn)
                  : ColorFilter.mode(Color(0xff5F5C5C), BlendMode.srcIn),
              child: SvgPicture.asset('assets/images/shopping.svg'),
            ),
            label: '',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.perm_identity_outlined),
            label: '',
          ),
        ],
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
      body: Column(
        children: [
          // Fixed Search Bar
          Container(
            width: double.infinity,
            height: Dimensions.height130,
            color: const Color(0xff8CACFF),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: Dimensions.height70,
                      left: Dimensions.width20,
                      right: Dimensions.width20),
                  child: CustomSearchBar(
                    width: Dimensions.width350,
                    height: Dimensions.height45,
                    controller: searchController,
                    prefixIcon: Icons.search,
                    suffixIcon: Icons.mic_none,
                    hint: 'Search for brands and products',
                  ),
                ),
              ],
            ),
          ),

          // Scrollable Content
          Expanded(
            child: Column(
              children: [
                SizedBox(height: Dimensions.height15),

                /// Second container
                Container(
                  color: const Color(0xff3E5C88),
                  width: double.infinity,
                  height: Dimensions.height180,
                  child: Stack(
                    children: [
                      Image.asset('assets/images/watch.png'),
                      Positioned(
                        left: Dimensions.width200,
                        top: Dimensions.height20,
                        child: customText(),
                      ),
                      Positioned(
                        left: Dimensions.width220,
                        top: Dimensions.height110,
                        child: TextAndIcon(
                          width: Dimensions.width125,
                          height: Dimensions.height40,
                          iconSize: Dimensions.iconSize15,
                          color: const Color(0xff883E5C),
                          icon: Icons.arrow_forward_ios_outlined,
                          text: 'Explore Now',
                          iconColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                /// Horizontal ListView
                Container(
                  height: Dimensions.height120, // Fixed height for the horizontal list
                  child: ListView.builder(
                    itemCount: images.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          if (index == 0) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((_) => const MobileScreen())));
                          } else if (index == 1) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((_) => FashionScreen())));
                          } else if (index == 2) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((_) => ElectronicsScreen())));
                          } else if (index == 3) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((_) => const BeautyScreen())));
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, top: 10, right: 10),
                          child: IconAndTextVertical(
                            text: images[index]['name'],
                            image: images[index]['image'],
                            textColor: Color(0xff161111),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(left: Dimensions.width10, top: Dimensions.height20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BigText(
                        text: 'More product',
                        size: Dimensions.font17,
                      ),
                      TextAndIcon(
                        icon: Icons.arrow_forward_ios_outlined,
                        text: 'View All',
                        iconSize: Dimensions.iconSize15,
                        textColor: const Color(0xff8CACFF),
                        iconColor: const Color(0xff8CACFF),
                      ),
                    ],
                  ),
                ),

                /// Product GridView
                Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                   // physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: Dimensions.height8,
                      mainAxisSpacing: Dimensions.height8,
                      childAspectRatio: .9,
                    ),
                    itemCount: 15,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: ((_) => AddToCart())));
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              left: Dimensions.width10, right: Dimensions.width10),
                          child: Card(
                            elevation: 3,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white38,
                                borderRadius: BorderRadius.circular(Dimensions.radius10),
                              ),
                              height: Dimensions.height210,
                              width: Dimensions.width170,
                              child: Column(
                                children: [
                                  Container(
                                    height: Dimensions.height125,
                                    width: Dimensions.width170,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(Dimensions.radius10),
                                      color: const Color(0xFF046970),
                                      image: const DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage('assets/images/earbud.png')),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: Dimensions.width10, top: Dimensions.height10),
                                    child: Column(
                                      children: [
                                        SmallText(
                                          text: 'boat Rockerz 550 Bluetooth Wireless',
                                          color: const Color(0xff0C0A0A),
                                          size: Dimensions.font14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        SizedBox(height: Dimensions.height10),
                                        CustomTextOverLine(
                                          firstText: '₹4,999',
                                          secondText: '₹ 2,249',
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget customText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Starting ₹999",
          style: TextStyle(
            color: Colors.white,
            fontSize: Dimensions.font17,
          ),
        ),
        SizedBox(height: Dimensions.height5),
        Text(
          "Bestselling\nsmartwatches",
          style: TextStyle(
            fontSize: Dimensions.font17,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}