import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/choose_enter_screen.dart';
import 'main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    check();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Image.asset("assets/images/ic_logo.png", width: 250, height: 100),
        ],
      ),
    );
  }

  void check() async {
    final prefs = await SharedPreferences.getInstance();
    final bool? isAuth = prefs.getBool('IS_AUTH');
    Timer(
        const Duration(seconds: 2),
            () => {
        if ( isAuth != null && isAuth ) {
        Navigator.push(context,
        MaterialPageRoute(builder: (context) => const MainScreen(tabName: 'home',)))
  } else {
    Navigator.push(context,
    MaterialPageRoute(builder: (context) => const ChooseEnterScreen()))
    }}
    );
  }
}
