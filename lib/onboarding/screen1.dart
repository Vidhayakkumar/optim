import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../auth/api_service/loginscreen.dart';
import '../main.dart';
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
    mq = MediaQuery.of(context).size;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: ListView(
          children: [
            Stack(
              children: [
                SvgPicture.asset("assets/images/Vector.svg",
                    height: mq.height * 0.2),
                Positioned(
                  top: 10,
                  right: 20,
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
                  left: mq.width * 0.03,
                  top: mq.height * 0.17,
                  child: const Text(
                    "An Ideal Platform To",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            const Text(
              "  Grow Your Business",
              style: TextStyle(
                  fontSize: 20, color: Color.fromRGBO(2, 125, 195, 1)),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/onfirst.png",
                ),
                const Text(
                  "   Elevate Your Sale Game,",
                  style: TextStyle(fontStyle: FontStyle.normal, fontSize: 20),
                )
              ],
            ),
            SizedBox(
              height: mq.height * 0.01,
            ),
            Container(
              padding: const EdgeInsets.only(left: 15),
              child: customText(),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: mq.height * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                  width: 340,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => OnBoardingScreen2()));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(13, 80, 175, 1.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(11))),
                    child: const Text(
                      "NEXT",
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            ),
            SizedBox(
              height: mq.height * 0.03,
            ),
            Image.asset("assets/images/dev.png")
          ],
        )));
  }

  Widget customText() {
    return RichText(
        text: const TextSpan(children: [
      TextSpan(
          text: "Grow Your ",
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
          )),
      TextSpan(
          text: "SALES OPTIM",
          style:
              TextStyle(fontSize: 17, color: Color.fromRGBO(13, 80, 175, 1.0))),
      TextSpan(
          text: " Manager\nLeads Contacts & Opportunities\nWith ",
          style: TextStyle(color: Colors.black, fontSize: 17)),
      TextSpan(
          text: "SALES OPTIM",
          style:
              TextStyle(fontSize: 17, color: Color.fromRGBO(13, 80, 175, 1.0)))
    ]));
  }
}
