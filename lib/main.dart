import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:myfirstproject/call_lag.dart';
import 'package:myfirstproject/contacts.dart';
import 'package:myfirstproject/home/chat/chat_home.dart';
import 'package:myfirstproject/home/chat/group_member_info.dart';
import 'package:myfirstproject/home/marketing/add_to_cart.dart';
import 'package:myfirstproject/home/marketing/beauty_screen.dart';
import 'package:myfirstproject/home/marketing/electronics_screen.dart';
import 'package:myfirstproject/home/marketing/fashion_screen.dart';
import 'package:myfirstproject/home/marketing/marketing_home_screen.dart';
import 'package:myfirstproject/home/marketing/mobile_screen.dart';
import 'package:myfirstproject/home/marketing/my_account_screen.dart';
import 'package:myfirstproject/home/marketing/my_cart_screen.dart';
import 'package:myfirstproject/home/marketing/new_address_screen.dart';
import 'package:myfirstproject/home/marketing/order_history_screen.dart';
import 'package:myfirstproject/home/marketing/order_tracking_screen.dart';
import 'package:myfirstproject/home/marketing/payment_screen.dart';
import 'package:myfirstproject/home/onboarding/loginscreen.dart';
import 'package:myfirstproject/home/product/add_product.dart';
import 'package:myfirstproject/home/product/product_page.dart';
import 'package:myfirstproject/home/product/update_product.dart';
import 'package:myfirstproject/home/tasks/tasks_lists.dart';
import 'home/onboarding/DotsIndicator.dart';

late Size mq;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff027DC3)),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: CallLog()
    );
  }
}

