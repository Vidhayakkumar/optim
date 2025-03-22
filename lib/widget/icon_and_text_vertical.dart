
import 'package:flutter/cupertino.dart';
import 'package:myfirstproject/config/dimensions.dart';
import 'package:myfirstproject/widget/big_text.dart';
import 'package:myfirstproject/widget/small_text.dart';

class IconAndTextVertical extends StatelessWidget{

  final String image;
  final String text;
  final double height;
  final double? iconSize;
  final Color? textColor;

  const IconAndTextVertical({
    super.key,
    this.textColor,
    this.iconSize,
    this.height=0,
    required this.text,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
   return Container(
     height: height ==0?Dimensions.height100:height,
     child: Column(
       mainAxisAlignment: MainAxisAlignment.center,
       children: [
         Image.asset(image,),
         SmallText(text: text,color: textColor,)
       ],
     ),
   );
  }

}