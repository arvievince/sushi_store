import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sushi_store/pages/activation_key_generator.dart';
import 'package:sushi_store/pages/cart_page.dart';
import 'package:sushi_store/pages/device_info.dart';
import 'package:sushi_store/pages/models/shop.dart';
import 'package:sushi_store/themeColors.dart';
import 'pages/intro_page.dart';
import 'pages/menu_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Shop(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Splash(),
      routes: {
        '/intropage': (context) => const IntroPage(),
        '/menupage': (context) => const MenuPage(),
        '/deviceInfoDetails': (context) => DeviceInfoSettings(),
        '/cartPage': (context) => const CartPage(),
        '/activationKeyGenerator': (context) =>
            const ActivationKeyGeneratorPage(),
        // '/fooddetails': (context) => const FoodDetailsPage(),
      },
    );
  }
}

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const IntroPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 800),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SushiTheme.emerald,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: 1.0,
              duration: const Duration(seconds: 2),
              curve: Curves.easeIn,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(
                  'lib/images/KwikPOSv2.png',
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
