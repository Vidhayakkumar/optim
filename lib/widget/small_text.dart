
import 'package:flutter/cupertino.dart';

import '../config/dimensions.dart';

class SmallText extends StatelessWidget{
  Color? color;
  final String text;
  double size;
  FontWeight? fontWeight;
  double height;
  SmallText({
    super.key,
    this.color = const Color(0xffffffff),
    required this.text,
    this.size=0,
    this.fontWeight,
    this.height=1.2
  });

  @override
  Widget build(BuildContext context){
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontSize: size == 0 ? Dimensions.font13:size,
          fontWeight: fontWeight,
          height: height,
      ),
    );
  }
}