import 'package:flutter/cupertino.dart';

import '../config/colors.dart';
import '../config/dimensions.dart';

class IconAndTextElevatedButton extends StatelessWidget {
  Color? color;
  double radius;
  IconData icon;
  String text;
  double width;
  double height;
  Color? textColor;
  double textSize;

  IconAndTextElevatedButton(
      {super.key,
        required this.text,
        required this.width,
        required this.height,
        required this.icon,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon,color: textColor),
          SizedBox(width: 10,),
          Text(text,style: TextStyle(
              fontSize: textSize ==0 ? Dimensions.font14:textSize,
              color: textColor
          ),),
        ],
      ),
    );
  }
}
