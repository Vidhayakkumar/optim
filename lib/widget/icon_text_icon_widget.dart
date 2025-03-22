import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myfirstproject/widget/small_text.dart';

class IconTextIconWidget extends StatelessWidget {
  final IconData? firstIcon;
  final String text;
  final double leftPadding;
  final Color? firstImageColor;
  final Color? secondImageColor;
  final double? width;
  final double? height;
  final double svgImageHeight1;
  final double svgImageHeight2;
  final String secondImage;
  final String firstImage;
  final IconData? secondIcon;
  final Color? textColor;
  final double textSize;
  final double? iconSizeFirst;
  final double? iconSizeSecond;

  const IconTextIconWidget({
    super.key,
    this.firstIcon,
    required this.text,
    this.secondIcon,
    this.secondImage = '',
    this.firstImage = '',
    this.textColor,
    this.leftPadding=0,
    this.firstImageColor,
    this.secondImageColor,
    this.width,
    this.height,
    this.svgImageHeight1 = 0,
    this.svgImageHeight2 = 0,
    this.textSize = 0,
    this.iconSizeFirst,
    this.iconSizeSecond,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding:  EdgeInsets.only(left: firstImage == ''?0:leftPadding ),
            child: Row(
              children: [

                firstImage == ''
                ?IconButton(
                  onPressed: () {},
                  icon: Icon(firstIcon),
                  color: firstImageColor,
                  iconSize: iconSizeFirst,
                ):SvgPicture.asset(firstImage,height: svgImageHeight1,),
                SizedBox(width: width,),
                SmallText(
                  text: text,
                  color: textColor,
                  size: textSize,
                ),
              ],
            ),
          ),

          // Corrected ternary operator
          secondImage == ''
              ? IconButton(
            onPressed: () {},
            icon: Icon(secondIcon),
            color: secondImageColor,
            iconSize: iconSizeSecond,
          )
              : SvgPicture.asset(
            secondImage,
            height: svgImageHeight2,
          ),
        ],
      ),
    );
  }
}