import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfirstproject/config/colors.dart';


import '../auth/loginscreen.dart';
import 'screen1.dart';


class Onboarding_2 extends StatefulWidget {

  @override
  State<Onboarding_2> createState() => _Onboarding_2State();
}

class _Onboarding_2State extends State<Onboarding_2> {
  final PageController _pageController = PageController();

  int _currentPage = 0;

  // List of items for the PageView
  final List<Widget> _pages = [
    Screen1(),
    Onboarding_2()
  ];

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
                  child: ElevatedButton(onPressed: () {

                    Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_)=>LoginScreen()));

                  }, child: Text("SKIP")),


                ),

                const Positioned(
                  left: 20,
                  top: 133,
                  child: Text("An Ideal Platform To",
                    style: TextStyle(
                      fontSize: 20,


                    ),),
                ),

              ],

            ),
            const Text("   Grow Your Business",
              style: TextStyle(
                  fontSize: 20,
                  color: textColor
              ),),
            Image.asset("assets/images/onsecond.jpg"),

            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                  width: 340,
                  height: 50,
                  child: ElevatedButton(onPressed: () {
                    
                    Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_)=>LoginScreen())
                    );
                    
                  }, child: Text("START FOR FREE",
                    style: TextStyle(
                        color: Colors.white
                    ),),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(
                            13, 80, 175, 1.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(11)
                        )
                    ),
                  )),
            ),
            SizedBox(height: 50,),
            Image.asset("assets/images/dev.png")
          ],
        ),
      ),
    );
  }
}