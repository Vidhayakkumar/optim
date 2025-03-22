import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myfirstproject/home/marketing/marketing_home_screen.dart';
import 'package:myfirstproject/widget/big_text.dart';
import 'package:myfirstproject/widget/custom_search_bar.dart';
import 'package:myfirstproject/widget/small_text.dart';

import '../../config/dimensions.dart';
import '../../widget/custom_text_over_line.dart';


class ElectronicsScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=> _ElectronicsScreenState();
}

class _ElectronicsScreenState extends State<ElectronicsScreen>{

  TextEditingController searchController = TextEditingController();

  var _currentIndex = 0;

 final List<String> images=[
   'assets/fashion/boat1.png',
   'assets/fashion/boat2.png',
   'assets/fashion/boat3.png',
   'assets/fashion/boat4.png',
  ];

  @override
  Widget build(BuildContext context){
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
      body:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                      IconButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: ((_)=>const MarketingHomeScreen())));
                      }, icon: const Icon(Icons.arrow_back,color: Colors.white,)),
                      CustomSearchBar(
                          width: Dimensions.width310,
                          height: Dimensions.height45,
                          controller: searchController,
                          prefixIcon: Icons.search,
                          suffixIcon: Icons.mic_none,
                          hint: 'Search in electronics'),

                    ],
                  ),
                )
              ],
            ),
          ),

          SizedBox(height: Dimensions.height15,),

          /// second container
          Container(
            color: Color(0xffFCCECE),
            width: double.infinity,
            height: Dimensions.height160,
            child: Stack(
              children: [
                Image.asset('assets/fashion/boat.png'),
                Positioned(
                    left: Dimensions.width180,
                    top: Dimensions.height30,
                    child: customText()),
                Positioned(
                    left: Dimensions.width200,
                    top: Dimensions.height120,
                    child: Container(
                      height: Dimensions.height40,
                      decoration: BoxDecoration(
                        color:Color(0xffF0CAFE),
                        borderRadius: BorderRadius.circular(Dimensions.radius30)
                      ),
                      
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(left: Dimensions.width10,right: Dimensions.width10),
                          child: BigText(
                            text: 'UP TO 80% OFF',
                          ),
                        ),
                      ),
                    )
                )
              ],
            ),
          ),

          SizedBox(height: Dimensions.height20,),

          Padding(
            padding: EdgeInsets.only(left: Dimensions.height15),
            child: BigText(text: "Deal's you can't miss",color: Color(0xff0C0A0A),),
          ),

          Expanded(
            child: GridView.builder(
                shrinkWrap: true,
                itemCount: 4,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: Dimensions.height10,
                  childAspectRatio: .85
                ),
                itemBuilder: (context,  index){
                  return Padding(
                    padding: EdgeInsets.only(left: Dimensions.width10,right: Dimensions.width10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(Dimensions.radius15),
                        boxShadow: [
                          BoxShadow(color: Colors.grey.shade300,blurRadius: 5)
                        ]
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            images[index],
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: Dimensions.height140,
                          ),
                          ///
                          Container(
                            height: Dimensions.height25,
                            width: double.infinity,
                            color: Color(0xffC6F0FE),
                            child: Center(
                              child: SmallText(
                                text: 'boat Airdopes Atom 81',
                                color: Colors.black,
                              ),
                            ),
                          ),

                          ///
                          SizedBox(height: Dimensions.height5),
                          CustomTextOverLine(
                              firstText: '₹4,490',
                              secondText: '₹699'
                          ),
                          SizedBox(height: Dimensions.height5),
                          SmallText(
                              text: 'Upto 50H Playtime',
                            color: Colors.black,
                          ),
                          SizedBox(height: Dimensions.height5),
                          SmallText(
                              text: '13MM Drives',
                            color: Colors.black,
                          )
                        ],
                      ),
                    ),
                  );
                }
            ),
          )

        ],
      ),
    );
  }

  Widget customText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("boat",
            style: TextStyle(
              color: Color(0xff0C0A0A),
              fontWeight: FontWeight.bold,
              fontSize: Dimensions.font20,
            )),
        SizedBox(height: Dimensions.height5),
        Text("Enjoy Unbeatable\nDiscounts on boat Audio",
            style: TextStyle(
              fontSize: Dimensions.font17,
              color: Color(0xff0C0A0A),

            )),
      ],
    );
  }
}