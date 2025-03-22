
import 'package:flutter/cupertino.dart';

import '../config/dimensions.dart';

class CustomHorizontalWiseText extends StatelessWidget{
  Color? color1;
  Color? color2;
  final String text2;
  final String text1;
  double font1;
  double font2;
  FontWeight? fontWeight1;
  FontWeight? fontWeight2;
  double height;
  CustomHorizontalWiseText({
    super.key,
    required this.text1,
    required this.text2,
    this.font1=0,
    this.font2=0,
    this.color1,
    this.color2,
    this.fontWeight1,
    this.fontWeight2,
    this.height=1.2
  });

  @override
  Widget build(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text1,
          style: TextStyle(
            color: color1,
            fontSize: font1 == 0 ? Dimensions.font13:font1,
            fontWeight: fontWeight1,
            height: height,
          ),
        ),
        Text(
          text2,
          style: TextStyle(
            color: color2,
            fontSize: font1 == 0 ? Dimensions.font13:font1,
            fontWeight: fontWeight2,
            height: height,
          ),
        ),
      ],
    );
  }
}