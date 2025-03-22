import 'package:flutter/cupertino.dart';

import '../config/colors.dart';
import '../config/dimensions.dart';

class CustomElevatedButton extends StatelessWidget {
  Color? color;
  double radius;
  String text;
  double width;
  FontWeight? fontWeight;
  double height;
  Color? textColor;
  double textSize;

  CustomElevatedButton(
      {super.key,
      required this.text,
      required this.width,
      required this.height,
      this.fontWeight,
      this.radius=0,
      this.textSize=0,
      this.textColor=const Color(0xFFffffff),
      this.color = AppColors.mainColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius==0? Dimensions.radius10: radius),
        color: color
      ),
      child: Center(
        child: Text(text,style: TextStyle(
          fontSize: textSize ==0 ? Dimensions.font14:textSize,
          color: textColor,
          fontWeight: fontWeight
        ),),
      ),
    );
  }
}
