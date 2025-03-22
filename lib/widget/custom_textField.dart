import 'package:flutter/material.dart';
import 'package:myfirstproject/config/dimensions.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final double width;
  final Color?  textColor;
  final double height;
  final Color borderColor;
  final String hint;
  final double radius;

  CustomTextField(
      {super.key,
      required this.width,
      this.height = 0,
      required this.controller,
      this.borderColor = const Color(0xFFffffff),
      this.radius = 0,
      this.textColor ,
      required this.hint});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height == 0 ? Dimensions.height45 : height,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(
              radius == 0 ? Dimensions.radius10 : radius)),
      child: Padding(
        padding: EdgeInsets.only(left: Dimensions.width10),
        child: TextField(
            controller: controller,
            style: TextStyle(color: Color(0xff5F5C5C)),
            decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                    color: textColor ==null? Color(0xffAAA9A9):textColor
                ),
                border: InputBorder.none)),
      ),
    );
  }
}
