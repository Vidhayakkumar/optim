import 'package:flutter/material.dart';
import 'package:myfirstproject/config/colors.dart';

import 'loginscreen.dart';
import '../../config/dimensions.dart';


class OnBoardingScreen2 extends StatefulWidget {
  const OnBoardingScreen2({super.key});

  @override
  State<OnBoardingScreen2> createState() => _OnBoardingScreen2State();
}

class _OnBoardingScreen2State extends State<OnBoardingScreen2> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            Stack(
              children: [
                Image.asset("assets/images/Vector.png"),
                Positioned(
                  top: Dimensions.height10,
                  right: Dimensions.width20,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => const LoginScreen()));
                      },
                      child: const Text("SKIP")),
                ),
                Positioned(
                  left: Dimensions.width15,
                  top: Dimensions.height140,
                  child: Text(
                    "An Ideal Platform To",
                    style: TextStyle(
                      fontSize: Dimensions.font20,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              "   Grow Your Business",
              style: TextStyle(fontSize: Dimensions.font20, color: AppColors.textColor),
            ),
            Image.asset("assets/images/onsecond.jpg"),
            SizedBox(height: Dimensions.height30,),
            Padding(
              padding:  EdgeInsets.all(Dimensions.height15),
              child: SizedBox(
                  width: Dimensions.width340,
                  height: Dimensions.height50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const LoginScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(13, 80, 175, 1.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(Dimensions.radius10))),
                    child: const Text(
                      "START FOR FREE",
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            ),
            SizedBox(
              height: Dimensions.height30,
            ),
            Image.asset("assets/images/dev.png")
          ],
        ),
      ),
    );
  }
}
