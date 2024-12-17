import 'package:flutter/material.dart';
import 'package:myfirstproject/onboarding/DotsIndicator.dart';
import 'package:myfirstproject/page/Product_Screen.dart';






late Size mq;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        title: 'Flutter Demo',
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff027DC3)),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home:ProductScreen()
    );
  }
}

