

import 'package:flutter/cupertino.dart';

import '../config/colors.dart';
import '../config/dimensions.dart';

class CustomOutlineButton extends StatelessWidget {
  Color outlineColor;
  String text;
  double width;
  FontWeight? fontWeight;
  double radius;
  double height;
  Color? textColor;
  double? textFont;

   CustomOutlineButton({super.key,
     required this.text,
     required this.width,
     this.outlineColor=AppColors.outlineBorderColor,
     required this.height,
     this.textFont,
     this.textColor,
     this.radius=0,
     this.fontWeight,
   });


  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius == 0? Dimensions.radius10:radius),
        border: Border.all(
          color: outlineColor,
        )
      ),
      child: Center(
        child: Text(text,style: TextStyle(
          color: textColor,
          fontSize: textFont,
          fontWeight: fontWeight
        ),),
      ),
    );
  }

}