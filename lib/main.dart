import 'dart:async';

import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:interintel/animations/router_animation.dart';
import 'package:interintel/config/app_config.dart';
import 'package:interintel/pages/info.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:interintel/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      themeCollection: themeCollection,
      defaultThemeId: AppThemes.light,
      builder: (context, theme) {
        return MaterialApp(
          title: InterIntel.appName,
          debugShowCheckedModeBanner: false,
          theme: theme,
          home: const SplashScreen(),
        );
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    displaySplash();
  }

  displaySplash() async {
    // Here we display the splash screen for 4 seconds then move to the Info Screen
    Timer(const Duration(seconds: 4), () async {
      Fluttertoast.showToast(msg: "Welcome!", backgroundColor: Colors.black38);

      Route route = RouterAnimation().animateToRoute(const InfoScreen());
      Navigator.pushReplacement(context, route);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: size.height * 0.3,
          ),
          AnimatedContainer(
            duration: const Duration(seconds: 1),
            width: size.width * 0.7,
            height: size.height * 0.3,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/logo.png"),
                    fit: BoxFit.fitWidth)),
          ),
          SizedBox(
            width: size.width,
            height: size.height * 0.3,
            child: Center(
              child: DefaultTextStyle(
                style: GoogleFonts.architectsDaughter(
                    color: Colors.grey, fontWeight: FontWeight.bold),
                child: AnimatedTextKit(
                    isRepeatingAnimation: false,
                    animatedTexts: [
                      TyperAnimatedText("Building Innovative Systems"),
                    ]),
              ),
            ),
          )
        ],
      ),
    );
  }
}
