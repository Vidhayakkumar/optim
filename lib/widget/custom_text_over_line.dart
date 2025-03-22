

import 'package:flutter/cupertino.dart';

import '../config/dimensions.dart';

class CustomTextOverLine extends StatelessWidget{
  Color? color;
  final String firstText;
  final String secondText;
  double size;
  double height;
  CustomTextOverLine({
    super.key,
    this.color = const Color(0xff635759),
    required this.firstText,
    required this.secondText,
    this.size=0,
    this.height=1.2
  });

  @override
  Widget build(BuildContext context){
    return Row(
     mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          firstText,
          style: TextStyle(
              color: color,
              fontSize: size == 0 ? Dimensions.font13:size,
              fontWeight: FontWeight.w400,
              height: height,
            decoration: TextDecoration.lineThrough
          ),
        ),
        SizedBox(width: Dimensions.width10,),
        Text(
          secondText,
          style: TextStyle(
              color: Color(0xFF0C0A0A),
              fontSize: size == 0 ? Dimensions.font13:size,
              fontWeight: FontWeight.w400,
              height: height,
          ),
        ),
      ],
    );
  }
}