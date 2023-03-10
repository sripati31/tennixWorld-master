import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:TennixWorldXI/constant/routes.dart';
import 'package:TennixWorldXI/constant/themes.dart';

import '../../constant/constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  State createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    _loadNextScreen();
    animationController = new AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animationController.forward();
    super.initState();
  }

  void _loadNextScreen() async {
    await Future.delayed(const Duration(milliseconds: 3000));

    Navigator.pushReplacementNamed(context, Routes.LOGIN);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: AllCoustomTheme.getThemeData().primaryColor,
            ),
            constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height, minWidth: MediaQuery.of(context).size.width),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    AppConstant.AppName.toUpperCase(),
                    style: new TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  ClipOval(
                    child: Image.asset(
                      'assets/cname/logo.jpeg',
                      height: 150,
                    ),
                  ),
                  new SizeTransition(
                    sizeFactor: new CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn),
                    axis: Axis.vertical,
                    child: Container(
                      height: 150.0,
                    ),
                  ),
                  // CircularProgressIndicator(
                  //   strokeWidth: 2.0,
                  //   valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
