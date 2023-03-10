// ignore_for_file: unnecessary_null_comparison

import 'dart:async';
import 'dart:convert';
import 'package:TennixWorldXI/constant/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:TennixWorldXI/constant/global.dart';
import 'package:TennixWorldXI/models/userData.dart';

class MySharedPreferences {
  Future clearSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    return;
  }

  Future<String?> getUserTokenString() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(AppConstant.userToken) == null) {
      await prefs.setString(AppConstant.userToken, '');
    }
    return prefs.getString(AppConstant.userToken);
  }

  Future<UserData?> getUserData() async {
    UserData ?userData;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(AppConstant.userData) == null) {
      await prefs.setString(AppConstant.userData, '');
    }
    var userDataTxt = prefs.getString(AppConstant.userData);
    if (userDataTxt != '') {
      userData = UserData.fromJson(jsonDecode(userDataTxt!));
      return userData;
    } else {
      return userData;
    }
  }

  Future setUserDataString(UserData userData) async {
    if (userData != null) {
      final usertxt = jsonEncode(userData);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(AppConstant.userData, usertxt);
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(AppConstant.userData, '');
    }
  }
}
