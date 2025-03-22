

import 'package:flutter/cupertino.dart';

import '../config/colors.dart';
import '../config/dimensions.dart';

class IconAndTextOutlineButton extends StatelessWidget {
  Color outlineColor;
  String text;
  double width;
  IconData icon;
  double radius;
  double height;
  Color? textColor;
  double? textFont;

  IconAndTextOutlineButton({super.key,
    required this.width,
    required this.height,
    required this.icon,
    required this.text,
    this.outlineColor=AppColors.outlineBorderColor,
    this.textFont,
    this.textColor,
    this.radius=0
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon,color: textColor,),

          SizedBox(width: 10,),

          Text(text,style: TextStyle(
              color: textColor,
              fontSize: textFont
          ),),
        ],
      ),
    );
  }

}