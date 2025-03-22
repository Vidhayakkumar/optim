import 'package:flutter/cupertino.dart';
import '../config/dimensions.dart';

class CustomTextWrap extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  final FontWeight? fontWeight;
  final double height;

  CustomTextWrap({
    super.key,
    this.color = const Color(0xff000000),
    required this.text,
    this.size = 0,
    this.fontWeight = FontWeight.normal,
    this.height = 1.2,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      softWrap: true,
      maxLines: 2, // Limit to 2 lines
      overflow: TextOverflow.ellipsis, // Handle overflow with ellipsis
      style: TextStyle(
        color: color,
        fontSize: size == 0 ? Dimensions.font13 : size,
        fontWeight: fontWeight,
        height: height,
      ),
    );
  }
}