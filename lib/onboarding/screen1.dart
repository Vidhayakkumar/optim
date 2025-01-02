import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myfirstproject/page/admin_page.dart';
import 'package:myfirstproject/page/employee_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/loginscreen.dart';
import '../main.dart';
import 'screen2.dart';

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => Screen1State();
}

class Screen1State extends State<Screen1> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  static const String KEYlOGIN = '';

  @override
  // List of items for the PageView
  final List<Widget> _pages = [Screen1(), Onboarding_2()];

  @override
  void initState() {
    super.initState();
    // whereToGo();

    // Listen to the PageView controller to update the current page
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.toInt();
      });
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
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (_) => LoginScreen()));
                      },
                      child: Text("SKIP")),
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
            Text(
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
              child: CustomText(),
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
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => Onboarding_2()));
                    },
                    child: Text(
                      "NEXT",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(13, 80, 175, 1.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(11))),
                  )),
            ),
            SizedBox(
              height: mq.height * 0.03,
            ),
            Image.asset("assets/images/dev.png")
          ],
        )));
  }

  void whereToGo() async {
    var sharedPref = await SharedPreferences.getInstance();
    var isLoggedIn = sharedPref.getString(KEYlOGIN);

    if (isLoggedIn == "") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const Screen1()));
    } else if (isLoggedIn == "ROLE_EMP") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => EmployeeScreen()));
    } else if (isLoggedIn == "ROLE_ADMIN") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => AdminPage()));
    } else {
      // Navigator.pushReplacement(context,
      // MaterialPageRoute(builder: (_)=>LoginScreen()));
    }
  }
}

Widget CustomText() {
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
        style: TextStyle(fontSize: 17, color: Color.fromRGBO(13, 80, 175, 1.0)))
  ]));
}
