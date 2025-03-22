import 'package:flutter/material.dart';
import 'package:myfirstproject/config/dimensions.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final double width;
  final double? height;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String hint;
  final double radius;

  CustomSearchBar(
      {super.key,
      required this.width,
      this.height =40,
      required this.controller,
      this.suffixIcon,
      this.prefixIcon,
      this.radius = 0,
      required this.hint});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
              radius == 0 ? Dimensions.radius10 : radius)),
      child: TextField(
          controller: controller,
          style:
              TextStyle(color: Color(0xff5F5C5C), fontWeight: FontWeight.bold),
          decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Color(0xff5F5C5C)),
              suffixIcon: Icon(
                suffixIcon,
                color: Color(0xff666666),
              ),
              prefixIcon: Icon(
                prefixIcon,
                color: Color(0xff8CACFF),
              ),
              border: InputBorder.none)),
    );
  }
}
