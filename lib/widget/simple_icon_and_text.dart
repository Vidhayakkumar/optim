import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfirstproject/widget/small_text.dart';

import '../config/dimensions.dart';

class SimpleIconAndText extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final String text;
  final Color? textColor;
  final Color iconColor;
  final double iconSize;

  SimpleIconAndText(
      {super.key,
        this.color,
        this.textColor = const Color(0xffFFFFFF),
        required this.icon,
        this.iconSize =0,
        required this.text,
        required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
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
    );
  }
}
