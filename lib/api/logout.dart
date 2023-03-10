import 'package:flutter/material.dart';
import 'package:TennixWorldXI/constant/global.dart';
import 'package:TennixWorldXI/constant/routes.dart';
import 'package:TennixWorldXI/constant/sharedPreferences.dart';
import 'package:TennixWorldXI/models/userData.dart';
import 'package:TennixWorldXI/modules/login/loginScreen.dart';
import 'package:TennixWorldXI/utils/dialogs.dart';

class LogOut {
  void logout(BuildContext context) async {
    try {
      Utils.userToken = null;
      await MySharedPreferences().clearSharedPreferences();
    } on Exception {
      Dialogs.showDialogWithOneButton(
        context,
        "Error",
        "please! try again.", onButtonPress: () {  },
      );
    }
  }

  Future backSplashScreen(BuildContext context) async {
    try {
      Utils.userToken = '';
      loginUserData = UserData();
      await MySharedPreferences().clearSharedPreferences();
      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.LOGIN, (Route<dynamic> route) => false);
    } on Exception {
      Dialogs.showDialogWithOneButton(
        context,
        "Error",
        "please! try again.", onButtonPress: () {  },
      );
    }
  }
}




