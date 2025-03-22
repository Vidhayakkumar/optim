import 'package:flutter/cupertino.dart';

import '../config/dimensions.dart';

class BigText extends StatelessWidget {
  Color? color;
  int? maxLine;
  final String text;
  double size;
  double? height;
  TextOverflow overflow;

  BigText(
      {super.key,
        this.color = const Color(0xFF161111),
        required this.text,
        this.size = 0,
        this.maxLine=0,
        this.height,
        this.overflow = TextOverflow.ellipsis});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      maxLines: maxLine ==0?3:maxLine,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: color,
        height: height,
        fontSize: size == 0 ? Dimensions.font20 : size,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
