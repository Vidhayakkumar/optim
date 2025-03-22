import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'loginscreen.dart';
import '../../config/dimensions.dart';
import 'screen2.dart';

class OnBoardingScreen1 extends StatefulWidget {
  const OnBoardingScreen1({super.key});

  @override
  State<OnBoardingScreen1> createState() => OnBoardingScreen1State();
}

class OnBoardingScreen1State extends State<OnBoardingScreen1> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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
                    SvgPicture.asset("assets/images/Vector.svg",),
                    Positioned(
                      top: Dimensions.height10,
                      right: Dimensions.width20,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const LoginScreen()));
                          },
                          child: const Text("SKIP")),
                    ),
                    Positioned(
                      left: Dimensions.width10,
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
                  "  Grow Your Business",
                  style: TextStyle(
                      fontSize: Dimensions.font20,
                      color: const Color.fromRGBO(2, 125, 195, 1)),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/onfirst.png",
                    ),
                    Text(
                      "   Elevate Your Sale Game,",
                      style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontSize: Dimensions.font20),
                    )
                  ],
                ),
                SizedBox(height: Dimensions.height15),
                Container(
                  padding: EdgeInsets.only(left: Dimensions.width15),
                  child: customText(),
                ),
                SizedBox(
                  height: Dimensions.height40,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SizedBox(
                      width: Dimensions.width340,
                      height: Dimensions.height50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const OnBoardingScreen2()));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(13, 80, 175, 1.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(11))),
                        child: const Text(
                          "NEXT",
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                ),
                SizedBox(height: Dimensions.height20),
                Image.asset("assets/images/dev.png")
              ],
            )));
  }

  Widget customText() {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: "Grow Your ",
          style: TextStyle(
            color: Colors.black,
            fontSize: Dimensions.font17,
          )),
      TextSpan(
          text: "SALES OPTIM",
          style: TextStyle(
              fontSize: Dimensions.font17,
              color: const Color.fromRGBO(13, 80, 175, 1.0))),
      TextSpan(
          text: " Manager\nLeads Contacts & Opportunities\nWith ",
          style: TextStyle(
              color: Colors.black, height: 1.3, fontSize: Dimensions.font17)),
      TextSpan(
          text: "SALES OPTIM",
          style: TextStyle(
              fontSize: Dimensions.font17,
              color: const Color.fromRGBO(13, 80, 175, 1.0)))
    ]));
  }
}
