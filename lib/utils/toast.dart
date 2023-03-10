import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomToast{
  static showToast({required String message,bool isShowSingle = true}){
    try{
      if(isShowSingle) Fluttertoast.cancel();
      Fluttertoast.showToast(msg: message,);
    }catch(e){
      debugPrint("Exception in toast: $e");
    }
  }
}