import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfirstproject/widget/small_text.dart';

import '../config/dimensions.dart';

class IconAndText extends StatelessWidget {
  final IconData icon;
  final double blurRadius;
  final double offSetRadius;
  final Color? color;
  final String text;
  final Color? textColor;
  final Color iconColor;
  final double? width;
  final double? height;
  final double iconSize;
  final double radius;

  IconAndText(
      {super.key,
      this.width,
      this.height,
      this.radius = 0.0,
      this.color,
      this.blurRadius=0,
      this.offSetRadius=0,
      this.textColor = const Color(0xffFFFFFF),
      required this.icon,
      this.iconSize =0,
      required this.text,
      required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(
              radius == 0 ? Dimensions.radius30 : radius),
          boxShadow: [
            BoxShadow(
          color: const Color(0xfff2f4f6),
          blurRadius: blurRadius,
              offset:  Offset(offSetRadius, 0)
          ),
          ]
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: iconColor,
                size: iconSize == 0 ? Dimensions.iconSize24 : iconSize,
              ),
              SizedBox(
                width: Dimensions.width5,
              ),
              SmallText(
                text: text,
                color: textColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
