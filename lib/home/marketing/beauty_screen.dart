import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myfirstproject/widget/custom_rich_text.dart';
import 'package:myfirstproject/widget/custom_search_bar.dart';
import 'package:myfirstproject/widget/text_and_Icon.dart';

import '../../config/dimensions.dart';
import '../../widget/big_text.dart';
import '../../widget/custom_textField.dart';
import 'marketing_home_screen.dart';

class BeautyScreen extends StatefulWidget {
  const BeautyScreen({super.key});

  @override
  State<StatefulWidget> createState() => _BeautyScreenState();
}

class _BeautyScreenState extends State<BeautyScreen> {
  TextEditingController searchController = TextEditingController();

  var _currentIndex = 0;

  final List<Map<String, dynamic>> itemList = [
    {'image': 'assets/fashion/beauty1.png', 'name': 'Skincare'},
    {'image': 'assets/fashion/beauty2.png', 'name': 'Haircare'},
    {'image': 'assets/fashion/beauty3.png', 'name': 'Luxury Beauty'},
    {'image': 'assets/fashion/beauty4.png', 'name': 'Makeup'},
    {'image': 'assets/fashion/beauty5.png', 'name': 'Men’s Grooming'},
    {'image': 'assets/fashion/beauty5.png', 'name': 'Women’sGrooming Device'},
    {'image': 'assets/fashion/beauty1.png', 'name': 'Skincare'},
    {'image': 'assets/fashion/beauty2.png', 'name': 'Haircare'},
    {'image': 'assets/fashion/beauty3.png', 'name': 'Luxury Beauty'},
    {'image': 'assets/fashion/beauty4.png', 'name': 'Makeup'},
    {'image': 'assets/fashion/beauty5.png', 'name': 'Men’s Grooming'},
    {'image': 'assets/fashion/beauty5.png', 'name': 'Women’sGrooming Device'}
  ];

  final List<Map<String, dynamic>> products = [
    {
      'image': 'assets/fashion/dove1.png',
      'fast': 'Conditioner',
      'second': 'Starting ₹99'
    },
    {
      'image': 'assets/fashion/dove2.png',
      'fast': 'Shampoos',
      'second': 'Starting ₹99'
    },
    {
      'image': 'assets/fashion/dove1.png',
      'fast': 'Conditioner',
      'second': 'Starting ₹99'
    },
    {
      'image': 'assets/fashion/dove2.png',
      'fast': 'Shampoos',
      'second': 'Starting ₹99'
    },
    {
      'image': 'assets/fashion/dove1.png',
      'fast': 'Conditioner',
      'second': 'Starting ₹99'
    },
    {
      'image': 'assets/fashion/dove2.png',
      'fast': 'Shampoos',
      'second': 'Starting ₹99'
    },
    {
      'image': 'assets/fashion/dove1.png',
      'fast': 'Conditioner',
      'second': 'Starting ₹99'
    },
    {
      'image': 'assets/fashion/dove2.png',
      'fast': 'Shampoos',
      'second': 'Starting ₹99'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xff8CACFF),
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index){
          setState(() {
            _currentIndex=index;
          });
        },
        items: [
          const BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: ''
          ),
          const BottomNavigationBarItem(
              icon: Icon(Icons.category_rounded),
              label: ''
          ),
          BottomNavigationBarItem(
              icon: ColorFiltered(
                colorFilter: _currentIndex ==2
                    ? const ColorFilter.mode(Color(0xff8CACFF), BlendMode.srcIn)
                    : const ColorFilter.mode(Color(0xff5F5C5C), BlendMode.srcIn),
                child: SvgPicture.asset('assets/images/bxs_offer.svg'),
              ),
              label: ''
          ),
          BottomNavigationBarItem(
              icon: ColorFiltered(
                colorFilter: _currentIndex == 3
                    ?const ColorFilter.mode(Color(0xff8CACFf), BlendMode.srcIn)
                    :const ColorFilter.mode(Color(0xff5F5C5C), BlendMode.srcIn),
                child:  SvgPicture.asset('assets/images/shopping.svg'),
              ),
              label: ''
          ),
          const BottomNavigationBarItem(
              icon: Icon(Icons.perm_identity_outlined),
              label: ''
          )
        ],
        showUnselectedLabels: false,
        showSelectedLabels: false,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: Dimensions.height120,
            color: Color(0xfff8CACFF),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: Dimensions.height60,
                      left: Dimensions.width10,
                      right: Dimensions.width10),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((_) =>
                                        const MarketingHomeScreen())));
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          )),
                      CustomSearchBar(
                          width: Dimensions.width310,
                          height: Dimensions.height45,
                          controller: searchController,
                          prefixIcon: Icons.search,
                          suffixIcon: Icons.mic_none,
                          hint: 'Search in beauty'),
                    ],
                  ),
                )
              ],
            ),
          ),

          SizedBox(
            height: Dimensions.height15,
          ),

          /// second container
          Container(
            color: Color(0xff5A97AA),
            width: double.infinity,
            height: Dimensions.height165,
            child: Stack(
              children: [
                Image.asset('assets/fashion/beauty.png'),
                Positioned(
                    left: Dimensions.width200,
                    top: Dimensions.height40,
                    child: customText()),
                Positioned(
                    left: Dimensions.width220,
                    top: Dimensions.height100,
                    child: BigText(
                      text: 'Up To 20% Off',
                      color: Color(0xffFFB800),
                      size: Dimensions.font18,
                    ))
              ],
            ),
          ),

          /// Horizontal scroll view
          SizedBox(
            height: Dimensions.height125,
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: itemList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(
                            left: Dimensions.width10, top: Dimensions.width10),
                        child: Column(
                          children: [
                            ClipRect(
                              child: Image.asset(
                                itemList[index]['image'],
                                width: Dimensions.width60,
                                // Specify width for the image
                                height: Dimensions
                                    .height50, // Specify height for the image
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.height5,
                            ),
                            SizedBox(
                              width: Dimensions.width60,
                              child: BigText(
                                text: itemList[index]['name'],
                                size: Dimensions.font13,
                                height: 1,
                                color: Color(0xff000000),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          ///
          Padding(
            padding: EdgeInsets.only(
                left: Dimensions.width20, right: Dimensions.width20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BigText(text: "HAIRCARE"),
                TextAndIcon(
                    icon: Icons.arrow_forward_ios_outlined,
                    text: 'View all',
                    textColor: Color(0xff8CACFF),
                    iconSize: Dimensions.iconSize15,
                    iconColor: Color(0xff8CACFF))
              ],
            ),
          ),

          ///
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: Dimensions.height10,
                  childAspectRatio: .839),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    left: Dimensions.width10,
                    right: Dimensions.width10,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.grey.shade300, blurRadius: 5)
                      ],
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          products[index]['image'],
                          width: double.infinity,
                          height: Dimensions.height195,
                          fit: BoxFit.cover,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: CustomRichText(
                            text1: products[index]['fast'],
                            color2: Colors.black,
                            color1: Colors.black,
                            text2: products[index]['second'],
                            font1: Dimensions.font13,
                            font2: Dimensions.font15,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget customText() {
    return Column(
      children: [
        Container(
          width: Dimensions.width180,
          child: Center(
            child: Text("BUY 2 OR MORE, GET EXTRA",
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: Dimensions.font17,
                )),
          ),
        ),
      ],
    );
  }
}
