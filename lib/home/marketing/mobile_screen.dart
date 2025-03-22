import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myfirstproject/home/marketing/marketing_home_screen.dart';
import 'package:myfirstproject/widget/custom_search_bar.dart';
import 'package:myfirstproject/widget/small_text.dart';

import '../../config/dimensions.dart';
import '../../widget/big_text.dart';
import '../../widget/custom_text_over_line.dart';

class MobileScreen extends StatefulWidget{
  const MobileScreen({super.key});


  @override
  State<StatefulWidget> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen>{

  TextEditingController searchController = TextEditingController();
  var _currentIndex=0;


 final List<Map<String,dynamic>> itemList=[
   {'name' : 'OnePlus', 'image':'assets/fashion/onlePlus.png'},
   {'name' : 'Lava' , 'image': 'assets/fashion/lava.png',},
   {'name' : 'Samsung' , 'image' : 'assets/fashion/sumsung.png'},
   {'name' : 'Redmi' , 'image' :  'assets/fashion/Redmi.png',},
   {'name' : 'Vivo' , 'image' : 'assets/fashion/vivo.png',},
   {'name' : 'Poco' , 'image' :'assets/fashion/poco.png',},
   {'name' : 'OnePlus', 'image':'assets/fashion/onlePlus.png'},
   {'name' : 'Lava' , 'image': 'assets/fashion/lava.png',},
   {'name' : 'Samsung' , 'image' : 'assets/fashion/sumsung.png'},
   {'name' : 'Redmi' , 'image' :  'assets/fashion/Redmi.png',},
   {'name' : 'Vivo' , 'image' : 'assets/fashion/vivo.png',},
   {'name' : 'Poco' , 'image' :'assets/fashion/poco.png',}
 ];


  final List<Map<String,dynamic>> products=[
  {'image': 'assets/fashion/ph1.png','model':'Redmi 12 5G','gen':'Snapdragon 4 Gen 2','old':'₹15,999','cur':'₹9,999','car':'AI Dual Camera','bat':'90Hz Display'},
  {'image': 'assets/fashion/ph2.png','model':'OnePlus 12R','gen':'Snapdragon 8 Gen 2','old':'₹39,999','cur':'₹37,999','car':'120Hz Display','bat':'100W Charging'},
   {'image': 'assets/fashion/ph1.png','model':'Redmi 12 5G','gen':'Snapdragon 4 Gen 2','old':'₹15,999','cur':'₹9,999','car':'AI Dual Camera','bat':'90Hz Display'},
   {'image': 'assets/fashion/ph2.png','model':'OnePlus 12R','gen':'Snapdragon 8 Gen 2','old':'₹39,999','cur':'₹37,999','car':'120Hz Display','bat':'100W Charging'},
   {'image': 'assets/fashion/ph1.png','model':'Redmi 12 5G','gen':'Snapdragon 4 Gen 2','old':'₹15,999','cur':'₹9,999','car':'AI Dual Camera','bat':'90Hz Display'},
   {'image': 'assets/fashion/ph2.png','model':'OnePlus 12R','gen':'Snapdragon 8 Gen 2','old':'₹39,999','cur':'₹37,999','car':'120Hz Display','bat':'100W Charging'},
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
     backgroundColor: Colors.white,
       body: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Container(
           width: double.infinity,
           height: Dimensions.height125,
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
                         hint: 'Search in mobiles'),
                   ],
                 ),
               )
             ],
           ),
         ),

         SizedBox(height: Dimensions.height15,),

         /// second container
         Container(
           color: Color(0xffEEE9E2),
           width: double.infinity,
           height: Dimensions.width170,
           child: Stack(
             children: [
               Image.asset('assets/fashion/phone (2).png'),
               Positioned(
                   left: Dimensions.width200,
                   top:  Dimensions.height30,
                   child: customText()),
               Positioned(
                   left: Dimensions.width200,
                   top: Dimensions.height120,
                   child:BigText(
                       text: 'Exciting offers',
                       color: Color(0xff282121),
                   )
               )
             ],
           ),
         ),

         /// Horizontal scroll view
         SizedBox(
           height: Dimensions.height90,
           child: Row(
             children: [
               Expanded(
                 child: ListView.builder(
                   itemCount: itemList.length,
                   scrollDirection: Axis.horizontal,
                   itemBuilder: (BuildContext context, int index) {
                     return Padding(
                       padding: EdgeInsets.only(left: Dimensions.width10,top: Dimensions.height10),
                       child: Column(
                         children: [
                           ClipRect(
                             child: Image.asset(itemList[index]['image'],
                               width: Dimensions.width60,  // Specify width for the image
                               height: Dimensions.height50, // Specify height for the image
                             ),
                           ),
                           SizedBox(height: Dimensions.height5,),
                           SmallText(
                             text: itemList[index]['name'],
                             size: Dimensions.font13,
                             color: Color(0xff000000),
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


         Padding(
           padding: EdgeInsets.only(left: Dimensions.width20,top: Dimensions.height10),
           child: BigText(text: "Deal's you can't miss",color: Color(0xff0C0A0A),),
         ),

         Expanded(
           child: GridView.builder(
               itemCount: 6, 
               shrinkWrap: true,
               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                   mainAxisSpacing: Dimensions.height10,
                   childAspectRatio: .77,
                   crossAxisCount: 2),
               itemBuilder:(context , index){
                 return Padding(
                   padding: EdgeInsets.only(left: Dimensions.width10,right: Dimensions.width10),
                   child: Container(
                     decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.circular(Dimensions.radius15),
                       boxShadow: [BoxShadow(color: Colors.grey.shade300,blurRadius: 5)]
                     ),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Image.asset(products[index]['image']!,
                           width: double.infinity,
                           height:Dimensions.height140,
                           fit: BoxFit.cover,),
                         Container(
                           width: double.infinity,
                           height: Dimensions.height30,
                           color: Color(0xffEFFEC6),
                           child: Center(child: Text(products[index]['gen']!)),
                         ),
                         Padding(
                           padding: EdgeInsets.only(left: Dimensions.width10),
                           child: BigText(text: products[index]['model']!),
                         ),
                         Padding(
                           padding: EdgeInsets.only(left: Dimensions.width10),
                           child: CustomTextOverLine(
                               firstText: products[index]['old']!,
                               secondText: products[index]['cur']!),
                         ),

                         
                         Padding(
                           padding: EdgeInsets.only(left: Dimensions.width5,top: Dimensions.height5,bottom: Dimensions.width5),
                           child: Row(
                             children: [
                               SmallText(
                                   text: products[index]['car']!,
                                 color:  Color(0xff000000),
                                 size: Dimensions.font10,
                               ),
                               SmallText(
                                 text: '|',
                                 color:   Color(0xff8a8586),
                                 size: Dimensions.font10,
                               ),
                               SmallText(
                                 text: products[index]['bat']!,
                                 color:  Color(0xff000000),
                                 size: Dimensions.font10,
                               ),
                             ],
                           ),
                         ),

                         Padding(
                           padding: EdgeInsets.only(left: Dimensions.width5,top: Dimensions.height2),
                           child: Container(
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(Dimensions.radius10),
                               border: Border.all(
                                 color: Color(0xffCAC9C9),

                               )
                             ),
                             child: Padding(
                               padding: EdgeInsets.only(
                                   left: Dimensions.width5,
                                   right:Dimensions.width5,
                                   bottom: Dimensions.height2),
                               child: SmallText(
                                 text: 'Including bank and coupon offer',
                                 color: Color(0xff000000),
                                 size: Dimensions.font8,
                               ),
                             ),
                           ),
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
        Text("iPhone 13",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: Dimensions.font17,
            )),
        SizedBox(height: Dimensions.height5,),
        Text("There’s nothing quite\nlike iphone",
            style: TextStyle(
              fontSize: Dimensions.font17,
              color:Colors.black,

            )),
      ],
    );
  }
}