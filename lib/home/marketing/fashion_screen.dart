import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myfirstproject/home/marketing/marketing_home_screen.dart';
import 'package:myfirstproject/widget/big_text.dart';
import 'package:myfirstproject/widget/custom_search_bar.dart';
import 'package:myfirstproject/widget/small_text.dart';

import '../../config/dimensions.dart';
import '../../widget/text_and_Icon.dart';

class FashionScreen extends StatefulWidget{
  @override
  State<FashionScreen> createState()=> _FashionScreenState();
}

class _FashionScreenState extends State<FashionScreen>{

  TextEditingController searchController = TextEditingController();
  var _currentIndex = 0;

  List<String> images =[
    'assets/fashion/Ellipse 261.png',
    'assets/fashion/Ellipse 262.png',
    'assets/fashion/Ellipse 263.png',
    'assets/fashion/Ellipse 264.png',
    'assets/fashion/Ellipse 265.png',
    'assets/fashion/Ellipse 261.png',
    'assets/fashion/Ellipse 262.png',
    'assets/fashion/Ellipse 263.png',
    'assets/fashion/Ellipse 264.png',
    'assets/fashion/Ellipse 265.png',
    'assets/fashion/Ellipse 261.png',
    'assets/fashion/Ellipse 262.png',
    'assets/fashion/Ellipse 263.png',
    'assets/fashion/Ellipse 264.png',
    'assets/fashion/Ellipse 265.png',

  ];
  
  List<String> fashions=[
    'assets/fashion/fash1.png',
    'assets/fashion/fash2.png',
    'assets/fashion/fash3.png',
    'assets/fashion/fash4.png',
    'assets/fashion/fash5.png',
    'assets/fashion/fash6.png',
    'assets/fashion/fash1.png',
    'assets/fashion/fash2.png',
    'assets/fashion/fash3.png',
    'assets/fashion/fash4.png',
    'assets/fashion/fash5.png',
    'assets/fashion/fash6.png',
    'assets/fashion/fash1.png',
    'assets/fashion/fash2.png',
    'assets/fashion/fash3.png',
    'assets/fashion/fash4.png',
    'assets/fashion/fash5.png',
    'assets/fashion/fash6.png',
       
  ];
  final List<Map<String, String>> clothingItems = [
    {'title': 'Tops & Tees', 'price': 'Under ₹499', 'image': 'assets/fashion/fash1.png'},
    {'title': 'Tops & Tees', 'price': 'Under ₹499', 'image':  'assets/fashion/fash2.png'},
    {'title': 'Kurtas', 'price': 'Under ₹399', 'image':  'assets/fashion/fash3.png'},
    {'title': 'Sportswear', 'price': 'Starting ₹499', 'image':  'assets/fashion/fash4.png'},
    {'title': 'Dresses & Jumps', 'price': 'Under ₹499', 'image':  'assets/fashion/fash5.png'},
    {'title': 'Sarees', 'price': 'Under ₹399', 'image':  'assets/fashion/fash6.png'},
    {'title': 'Tops & Tees', 'price': 'Under ₹499', 'image': 'assets/fashion/fash1.png'},
    {'title': 'Tops & Tees', 'price': 'Under ₹499', 'image':  'assets/fashion/fash2.png'},
    {'title': 'Kurtas', 'price': 'Under ₹399', 'image':  'assets/fashion/fash3.png'},
    {'title': 'Sportswear', 'price': 'Starting ₹499', 'image':  'assets/fashion/fash4.png'},
    {'title': 'Dresses & Jumps', 'price': 'Under ₹499', 'image':  'assets/fashion/fash5.png'},
    {'title': 'Sarees', 'price': 'Under ₹399', 'image':  'assets/fashion/fash6.png'},
  ];


  @override
  Widget build(BuildContext context){
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
          selectedItemColor: Color(0xff8CACFF),
          currentIndex: _currentIndex,
          onTap: (index){
          setState(() {
            _currentIndex=index;
          });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
              label: ''
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.category_rounded),
              label: ''
            ),
            BottomNavigationBarItem(
                icon: ColorFiltered(
                    colorFilter: _currentIndex == 2
                    ?ColorFilter.mode(Color(0xff8CACFF), BlendMode.srcIn)
                    :ColorFilter.mode(Color(0xff5F5C5C), BlendMode.srcIn),
                  child: SvgPicture.asset('assets/images/bxs_offer.svg'),
                ),
              label: ''
            ),
            BottomNavigationBarItem(
                icon: ColorFiltered(
                    colorFilter: _currentIndex == 3
                        ?ColorFilter.mode(Color(0xff8CACFF), BlendMode.srcIn)
                        :ColorFilter.mode(Color(0xff5F5C5C), BlendMode.srcIn),
                  child: SvgPicture.asset('assets/images/shopping.svg'),
                ),
              label: ''
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.perm_identity_outlined),
                label: ''
            ),
          ],
        showUnselectedLabels: false,
        showSelectedLabels: false,
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// search here
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
                      IconButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: ((_)=>MarketingHomeScreen())));
                      }, icon: const Icon(Icons.arrow_back,color: Colors.white,)),
                      CustomSearchBar(
                          width: Dimensions.width310,
                          height: Dimensions.height45,
                          controller: searchController,
                          prefixIcon: Icons.search,
                          suffixIcon: Icons.mic_none,
                          hint: 'Search in fashions'),

                    ],
                  ),
                )
              ],
            ),
          ),

          SizedBox(height: Dimensions.height15,),

          /// second container
          Container(
            color: Color(0xffFDB25A),
            width: double.infinity,
            height: Dimensions.width170,
            child: Stack(
              children: [
                Image.asset('assets/fashion/fashion1.png'),
                Positioned(
                    left: Dimensions.width200,
                    top: Dimensions.height30,
                    child: customText()),
                Positioned(
                    left: Dimensions.width220,
                    top: Dimensions.height110,
                    child: TextAndIcon(
                        width: Dimensions.width125,
                        height: Dimensions.height40,
                        iconSize: Dimensions.iconSize15,
                        color: Color(0xff0C0A0A),
                        icon: Icons.arrow_forward_ios_outlined,
                        text: 'SIGN IN NOW',
                        iconColor: Colors.white)
                )
              ],
            ),
          ),

          /// Horizontal scroll view
          SizedBox(
            height: Dimensions.height80,
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: images.length,
                    scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index){
                        return Padding(
                          padding: EdgeInsets.only(left: Dimensions.width15,top: Dimensions.height5),
                          child: ClipRect(
                            child: Image.asset(images[index],width: Dimensions.width50,),
                          ),
                        );
                  }
                  ),
                ),
              ],
            ),
          ),
          
          Padding(
            padding: EdgeInsets.only(left: Dimensions.width15,),
            child: BigText(text: "Women's Clothing"),
          ),

          SizedBox(height: Dimensions.height10,),

          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(Dimensions.height8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: Dimensions.height8,
                mainAxisSpacing: Dimensions.height8,
                childAspectRatio: 0.63,
              ),
              itemCount: clothingItems.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimensions.radius15),
                    boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 5)],
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                          clothingItems[index]['image']!,
                          width : double.infinity,
                          height: Dimensions.height140,
                          fit: BoxFit.cover),
                      Column(
                        children: [
                          Container(
                              height: Dimensions.height30,
                              width : double.infinity,
                              color:Color(0xffF8C9F9),
                              child: Center(
                                  child: Text(clothingItems[index]['title']!,
                                    style: TextStyle(color:Color(0xff0C0A0A),
                                      fontWeight: FontWeight.bold,
                                      fontSize: Dimensions.font13,),))),
                          Text(clothingItems[index]['price']!,
                              style: TextStyle(color:
                              Color(0xff0C0A0A),
                                fontSize: Dimensions.font14,)),
                        ],
                      ),
                    ],
                  ),
                );
              },
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
        Text("Get Up To",
            style: TextStyle(
              color: Color(0xff0C0A0A),
              fontSize: Dimensions.font17,
            )),
        SizedBox(height: Dimensions.height5,),
        Text("20% CASHBACK",
            style: TextStyle(
              fontSize: Dimensions.font17,
              color: Color(0xff0C0A0A),

            )),
      ],
    );
  }
}