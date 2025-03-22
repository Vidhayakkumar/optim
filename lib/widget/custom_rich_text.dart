import 'package:flutter/cupertino.dart';
import 'package:myfirstproject/config/dimensions.dart';

class CustomRichText extends StatelessWidget{

  String text1;
  String text2;
  Color? color1;
  Color? color2;
  double? font1;
  double? font2;


   CustomRichText({
     super.key,
     required this.text1,
     required this.text2,
     this.color1,
     this.color2,
     this.font1,
     this.font2
   });

  @override
  Widget build(BuildContext context) {
    return Container(
      height:Dimensions.height45,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color(0xffF9DEA9),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(Dimensions.radius15)
            ,bottomRight: Radius.circular(Dimensions.radius15))
      ),

      child:Column(
        children: [
          Text(text1,style: TextStyle(
            color: color1,
            fontSize: font1
          ),),
          Text(
            text2,
            textAlign: TextAlign.center,
            style: TextStyle(
            color: color2,
            fontSize: font2,
          ),)
        ],
      )
    );
  }

}