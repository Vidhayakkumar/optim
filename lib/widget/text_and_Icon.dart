import 'package:flutter/cupertino.dart';
import 'package:myfirstproject/widget/small_text.dart';

import '../config/dimensions.dart';

class TextAndIcon extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final String text;
  final Color? textColor;
  final Color iconColor;
  final double? width;
  final double? height;
  final double iconSize;
  final double radius;

   TextAndIcon(
      {super.key,
      this.width,
      this.height,
      this.radius=0.0,
      this.color,
      this.textColor=const Color(0xffFFFFFF),
      required this.icon,
      this.iconSize=0,
      required this.text,
      required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius == 0? Dimensions.radius30:radius)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SmallText(text: text,color: textColor,),
          SizedBox(
            width: Dimensions.width5,
          ),
          Icon(
            icon,
            color: iconColor,
            size: iconSize==0?Dimensions.iconSize24:iconSize,
          ),

        ],
      ),
    );
  }
}
