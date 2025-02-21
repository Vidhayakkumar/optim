import 'package:flutter/material.dart';
import 'package:myfirstproject/config/colors.dart';

import '../auth/api_service/loginscreen.dart';

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
        body: ListView(
          children: [
            Stack(
              children: [
                Image.asset("assets/images/Vector.png"),
                Positioned(
                  top: 10,
                  right: 20,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => LoginScreen()));
                      },
                      child: Text("SKIP")),
                ),
                const Positioned(
                  left: 20,
                  top: 133,
                  child: Text(
                    "An Ideal Platform To",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            const Text(
              "   Grow Your Business",
              style: TextStyle(fontSize: 20, color: textColor),
            ),
            Image.asset("assets/images/onsecond.jpg"),
            const SizedBox(
              height: 30,
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
                              builder: (_) => const LoginScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(13, 80, 175, 1.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(11))),
                    child: const Text(
                      "START FOR FREE",
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
            ),
            const SizedBox(
              height: 50,
            ),
            Image.asset("assets/images/dev.png")
          ],
        ),
      ),
    );
  }
}
