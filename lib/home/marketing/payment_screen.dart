import 'package:flutter/material.dart';
import 'package:myfirstproject/widget/big_text.dart';
import 'package:myfirstproject/widget/custom_elevated_button.dart';
import 'package:myfirstproject/widget/icon_text_icon_widget.dart';
import '../../config/colors.dart';
import '../../config/dimensions.dart';
import '../../widget/small_text.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<StatefulWidget> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: SmallText(
          text: 'Payment',
          size: Dimensions.font20,
          color: Colors.white,
        ),
        backgroundColor: Color(0xff8CACFF),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back, color: Colors.white)),
      ),
      body: Padding(
        padding: EdgeInsets.only(
            left: Dimensions.width10,
            right: Dimensions.width10,
            top: Dimensions.height20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: Dimensions.width20, right: Dimensions.width20),
              child: Row(
                children: [
                  SmallText(
                      text: 'Cart',
                      color: AppColors.mkMainColor,
                      size: Dimensions.font15),
                  SizedBox(width: Dimensions.width5 - Dimensions.width2),
                  const Expanded(
                    child: Divider(
                      thickness: 1.3,
                      color: AppColors.mkMainColor,
                    ),
                  ),
                  SizedBox(width: Dimensions.width5 - Dimensions.width2),
                  SmallText(
                      text: 'Address Details',
                      color: AppColors.mkMainColor,
                      size: Dimensions.font15),
                  SizedBox(width: Dimensions.width5 - Dimensions.width2),
                  const Expanded(
                    child: Divider(
                      thickness: 1.3,
                      color: AppColors.mkMainColor,
                    ),
                  ),
                  SizedBox(width: Dimensions.width5 - Dimensions.width2),
                  SmallText(
                      text: 'Payment',
                      color: AppColors.mkMainColor,
                      size: Dimensions.font15),
                ],
              ),
            ),
            SizedBox(height: Dimensions.height30),
            Padding(
              padding: EdgeInsets.only(left: Dimensions.width15),
              child: BigText(
                text: 'Recommended Payment Options',
                size: Dimensions.font20,
              ),
            ),
            SizedBox(
              height: Dimensions.height10,
            ),
            IconTextIconWidget(
              firstIcon: Icons.circle_outlined,
              text: 'Google Pay',
              secondImage: 'assets/images/google_pay.svg',
              textSize: Dimensions.font17,
              svgImageHeight2: Dimensions.height40,
              height: Dimensions.height40,
            ),
            const Divider(
              color: Color(0xffD4D4D4),
            ),
            IconTextIconWidget(
              firstIcon: Icons.circle_outlined,
              text: 'Cash on Delivery (Cash/UPI)',
              secondImage: 'assets/images/cash.svg',
              textSize: Dimensions.font17,
              svgImageHeight2: Dimensions.height40,
              height: Dimensions.height40,
            ),
            const Divider(
              color: Color(0xffD4D4D4),
            ),
            IconTextIconWidget(
              firstIcon: Icons.circle_outlined,
              text: 'Cash on Delivery (Cash/UPI)',
              secondImage: 'assets/images/phone_pay.svg',
              textSize: Dimensions.font17,
              svgImageHeight2: Dimensions.height40,
              height: Dimensions.height40,
            ),
            const Divider(
              color: Color(0xffD4D4D4),
            ),
            SizedBox(
              height: Dimensions.height20,
            ),
            Padding(
              padding: EdgeInsets.only(left: Dimensions.width15),
              child: BigText(text: 'Other Payment Options'),
            ),
            SizedBox(
              height: Dimensions.height15,
            ),
            IconTextIconWidget(
              firstImage: 'assets/images/cash1.svg',
              text: 'Cash On Delivery (Cash/UPI)',
              svgImageHeight1: Dimensions.height20,
              leftPadding: Dimensions.width10,
              width: Dimensions.width10,
              textSize: Dimensions.font17,
              secondIcon: Icons.keyboard_arrow_down_rounded,
              height: Dimensions.height30,
            ),
            const Divider(
              color: Color(0xffD4D4D4),
            ),
            IconTextIconWidget(
              firstImage: 'assets/images/cash1.svg',
              text: 'UPI',
              svgImageHeight1: Dimensions.height20,
              leftPadding: Dimensions.width10,
              width: Dimensions.width10,
              textSize: Dimensions.font17,
              secondIcon: Icons.keyboard_arrow_down_rounded,
              height: Dimensions.height30,
            ),
            const Divider(
              color: Color(0xffD4D4D4),
            ),
            IconTextIconWidget(
              firstImage: 'assets/images/credit.svg',
              text: 'Credit/Debit Card',
              svgImageHeight1: Dimensions.height15,
              leftPadding: Dimensions.width10,
              width: Dimensions.width10,
              textSize: Dimensions.font17,
              secondIcon: Icons.keyboard_arrow_down_rounded,
              height: Dimensions.height30,
            ),
            const Divider(
              color: Color(0xffD4D4D4),
            ),
            IconTextIconWidget(
              firstImage: 'assets/images/wallet.svg',
              text: 'Wallets',
              svgImageHeight1: Dimensions.height20,
              leftPadding: Dimensions.width10,
              width: Dimensions.width10,
              textSize: Dimensions.font17,
              secondIcon: Icons.keyboard_arrow_down_rounded,
              height: Dimensions.height30,
            ),
            const Divider(
              color: Color(0xffD4D4D4),
            ),
            IconTextIconWidget(
              firstImage: 'assets/images/pay_later.svg',
              text: 'Pay Later',
              svgImageHeight1: Dimensions.height20,
              leftPadding: Dimensions.width10,
              width: Dimensions.width10,
              textSize: Dimensions.font17,
              secondIcon: Icons.keyboard_arrow_down_rounded,
              height: Dimensions.height30,
            ),
            const Divider(
              color: Color(0xffD4D4D4),
            ),
            IconTextIconWidget(
              firstImage: 'assets/images/emi.svg',
              text: 'EMI',
              svgImageHeight1: Dimensions.height20,
              leftPadding: Dimensions.width10,
              width: Dimensions.width10,
              textSize: Dimensions.font17,
              secondIcon: Icons.keyboard_arrow_down_rounded,
              height: Dimensions.height30,
            ),
            const Divider(
              color: Color(0xffD4D4D4),
            ),
            IconTextIconWidget(
              firstIcon: Icons.account_balance,
              firstImageColor: Color(0xff5b595a),
              text: 'Net Banking',
              iconSizeFirst: Dimensions.iconSize20,
              textSize: Dimensions.font17,
              secondIcon: Icons.keyboard_arrow_down_rounded,
              height: Dimensions.height30,
            ),
            const Divider(
              color: Color(0xffD4D4D4),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: Dimensions.width10, right: Dimensions.width10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BigText(text: 'Total ₹560'),
                  CustomElevatedButton(
                    text: 'Pay Now',
                    width: Dimensions.width150,
                    height: Dimensions.height45,
                    radius: Dimensions.radius15,
                    textSize: Dimensions.font17,
                    color: Color(0xff8CACFF),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
