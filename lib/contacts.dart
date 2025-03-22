import 'package:flutter/material.dart';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myfirstproject/call_lag.dart';
import 'package:myfirstproject/widget/big_text.dart';
import 'package:myfirstproject/widget/custom_elevated_button.dart';
import 'package:myfirstproject/widget/custom_outline_button.dart';
import 'package:myfirstproject/widget/simple_icon_and_text.dart';
import 'package:myfirstproject/widget/small_text.dart';

import 'config/colors.dart';
import 'config/dimensions.dart';

class Contacts extends StatefulWidget {
  Contacts({super.key});

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  List<dynamic> names = [
    {'name': 'David k', 'phone': '+91 98765 43210', 'image': 'assets/images/lead_person.svg'},
    {'name': 'Sarah P ', 'phone': '+91 98765 54321', 'image': 'assets/images/lead_person.svg'},
    {'name': 'Michael T', 'phone': '+91 98765 43210', 'image': 'assets/images/lead_person.svg'},
    {'name': 'Emma W.', 'phone': '+91 98765 54321', 'image': 'assets/images/lead_person.svg'},
    {'name': 'David k', 'phone': '+91 98765 43210', 'image': 'assets/images/lead_person.svg'},
    {'name': 'Sarah P ', 'phone': '+91 98765 43210', 'image': 'assets/images/lead_person.svg'},
    {'name': 'Michael T', 'phone': '+91 98765 54321', 'image': 'assets/images/lead_person.svg'},
    {'name': 'Emma W.', 'phone': '+91 98765 43210', 'image': 'assets/images/lead_person.svg'},
    {'name': 'David k', 'phone': '+91 98765 54321', 'image': 'assets/images/lead_person.svg'},
    {'name': 'Sarah P ', 'phone': '+91 98765 43210', 'image': 'assets/images/lead_person.svg'},
    {'name': 'Michael T', 'phone': '+91 98765 43210', 'image': 'assets/images/lead_person.svg'},
    {'name': 'Emma W.', 'phone': '+91 98765 43210', 'image': 'assets/images/lead_person.svg'},
  ];

  // List to store check status for each item
  List<bool> isCheckList = List.generate(12, (index) => false);

  // List to store selected items
  List<dynamic> selectedItems = [];

  // Method to handle checkbox tap
  void onCheckboxTap(int index) {
    setState(() {
      isCheckList[index] = !isCheckList[index]; // Toggle checkbox state

      // If checked, move the item to the selected items list
      if (isCheckList[index]) {
        selectedItems.add(names[index]); // Add to selected list
      } else {
        selectedItems.remove(names[index]); // Remove from selected list
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Dimensions.height45),
        child: GradientAppBar(
          gradient: const LinearGradient(
              colors: [AppColors.blueBgColor, AppColors.mainColor]),
          leading: Icon(Icons.arrow_back_outlined),
          title: SmallText(
            text: 'Add New Lead',
            size: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          actions: [
            Icon(Icons.filter_list_outlined),
            SizedBox(width: 10),
            Icon(Icons.more_vert),
            SizedBox(width: 20)
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Call log and contacts buttons
            Container(
              margin: EdgeInsets.symmetric(horizontal: Dimensions.width15, vertical: Dimensions.height10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: ((_)=>CallLog())));
                    },
                    child: CustomOutlineButton(
                      text: 'Call Log',
                      width: Dimensions.width150,
                      height: Dimensions.height40,
                      textFont: Dimensions.font17,
                      fontWeight: FontWeight.bold,
                      textColor: Color(0xFF1E47A7),
                      outlineColor: Color(0xFFC1C1C1),
                    ),
                  ),
                  CustomElevatedButton(
                    text: 'Contacts',
                    width: Dimensions.width150,
                    height: Dimensions.height40,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
        
            // Horizontal ListView for the contacts
            if (selectedItems.isNotEmpty)
              Container(
                height: Dimensions.height60,
                margin: EdgeInsets.symmetric(horizontal: Dimensions.width15, vertical: Dimensions.height10),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: selectedItems.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(right: Dimensions.width10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(selectedItems[index]['image'], color: Color(0xFF1242D2)),
                          BigText(
                            text: selectedItems[index]['name'],
                            color: Colors.black,
                            maxLine: 1,
                            size: 10,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
        
            // Divider
            Divider(color: Color(0xFF1242D2)),
        
            // Vertical ListView for the contacts
            ListView.builder(
              shrinkWrap: true,
              itemCount: names.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    // Container for the row and conditional color
                    Container(
                      height: Dimensions.height50,
                      child: ListTile(
                        leading: SizedBox(
                          width: Dimensions.width60 + Dimensions.width10,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () => onCheckboxTap(index), // Handle checkbox tap
                                child: SvgPicture.asset(
                                  isCheckList[index] ? 'assets/images/add_box.svg' : 'assets/images/box.svg',
                                  width: Dimensions.width20,
                                ),
                              ),
                              SizedBox(width: Dimensions.width10),
                              SvgPicture.asset('assets/images/lead_person.svg')
                            ],
                          ),
                        ),
                        title: SmallText(
                          text: names[index]['name'],
                          size: Dimensions.font15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        subtitle: SimpleIconAndText(
                          icon: Icons.call,
                          text: names[index]['phone'],
                          iconSize: Dimensions.font15,
                          textColor: Color(0xff919191),
                          iconColor: Color(0xff919191),
                        ),
                        trailing: Column(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: Color(0xFF1242D2),
                            ),
                            SmallText(
                              text: '2d ago',
                              color: Color(0xFf919191),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 2),
                    Divider(color: Color(0xFFC1C1C1))
                  ],
                );
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: Dimensions.height15, top: Dimensions.height5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomElevatedButton(
              text: 'Add',
              width: Dimensions.width25 * 4,
              radius: Dimensions.radius5,
              height: Dimensions.height30 + Dimensions.height5,
            ),
          ],
        ),
      ),
    );
  }
}