
import 'package:flutter/material.dart';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myfirstproject/contacts.dart';
import 'package:myfirstproject/widget/big_text.dart';
import 'package:myfirstproject/widget/custom_elevated_button.dart';
import 'package:myfirstproject/widget/custom_outline_button.dart';
import 'package:myfirstproject/widget/icon_and_text.dart';
import 'package:myfirstproject/widget/simple_icon_and_text.dart';
import 'package:myfirstproject/widget/small_text.dart';

import 'config/colors.dart';
import 'config/dimensions.dart';

class CallLog extends StatefulWidget {
  const CallLog({super.key});

  @override
  State<CallLog> createState() => _CallLogState();
}

class _CallLogState extends State<CallLog> {

  List<dynamic> names = [
    {'name': 'David k', 'phone': '+91 98765 43210'},
    {'name': 'Sarah P ', 'phone': '+91 98765 54321'},
    {'name': 'Michael T', 'phone': '+91 98765 43210'},
    {'name': 'Emma W.', 'phone': '+91 98765 54321'},
    {'name': 'David k', 'phone': '+91 98765 43210'},
    {'name': 'Sarah P ', 'phone': '+91 98765 43210'},
    {'name': 'Michael T', 'phone': '+91 98765 54321'},
    {'name': 'Emma W.', 'phone': '+91 98765 43210'},
    {'name': 'David k', 'phone': '+91 98765 54321'},
    {'name': 'Sarah P ', 'phone': '+91 98765 43210'},
    {'name': 'Michael T', 'phone': '+91 98765 43210'},
    {'name': 'Emma W.', 'phone': '+91 98765 43210'},
  ];

  // List to track the state of checkboxes for each lead
  List<bool> isCheckedList = List.generate(12, (index) => false);

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
      body: Container(
        margin: EdgeInsets.only(top: Dimensions.height20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // call log and contacts
              Container(
                margin: EdgeInsets.only(left: Dimensions.width15, right: Dimensions.width15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomElevatedButton(
                      text: 'Call Log',
                      width: Dimensions.width150,
                      height: Dimensions.height40,
                      fontWeight: FontWeight.bold,
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: ((_)=>Contacts())));
                      },
                      child: CustomOutlineButton(
                        text: 'Contacts',
                        width: Dimensions.width150,
                        height: Dimensions.height40,
                        textFont: Dimensions.font17,
                        fontWeight: FontWeight.bold,
                        textColor: Color(0xFF1E47A7),
                        outlineColor: Color(0xFFC1C1C1),
                      ),
                    ),
                  ],
                ),
              ),

              // divider
              SizedBox(height: Dimensions.height10),
              Divider(color: Color(0xFF1242D2)),

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
                              width: Dimensions.width60+Dimensions.width10,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: Dimensions.width25,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isCheckedList[index] = !isCheckedList[index]; // Toggle checkbox state
                                        });
                                      },
                                      child: SvgPicture.asset(
                                        isCheckedList[index]
                                            ?'assets/images/add_box.svg' // Change icon to add_circle when checked
                                            : 'assets/images/box.svg', // Default checkbox icon
                                        width: Dimensions.width20, // Adjust size as needed
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: Dimensions.width5),
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
                  })
            ],
          ),
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
