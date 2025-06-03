import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sushi_store/pages/cart_page.dart';
import 'package:sushi_store/pages/device_info.dart';
import 'package:sushi_store/pages/models/shop.dart';

import 'pages/food_details_page.dart';
import 'pages/intro_page.dart';
import 'pages/menu_page.dart';

void main() {
  runApp(
   ChangeNotifierProvider(create: (context) => Shop(), 
   child: const MyApp(),
   )
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const IntroPage(),
      routes: {
        '/intropage': (context) => const IntroPage(),
        '/menupage': (context) => const MenuPage(),
        '/deviceInfoDetails': (context) => DeviceInfoSettings(),
        '/cartPage': (context) => const CartPage(),
        // '/fooddetails': (context) => const FoodDetailsPage(),
      },
    );
  }
}