import 'dart:convert';
import 'dart:io';

import 'package:TennixWorldXI/main.dart';
import 'package:TennixWorldXI/utils/toast.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class VerificationController extends GetxController {
  File? frontSide;
  File? backSide;
  var apiHeader = {
    'Authorization': 'Bearer $userToken',
  };
  var phone = TextEditingController();
  var email = TextEditingController();
  var pancardNo = TextEditingController();
  var pancardtitle = TextEditingController();
  var adharcardNo = TextEditingController();
  var adharcardtitle = TextEditingController();
  pickFrontPanCardImg() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      frontSide = File(result.files.single.path!);
      print('pick ${frontSide}');
      update();
      CustomToast.showToast(message: 'front picture picked');
    } else {
      CustomToast.showToast(message: 'file not picked');
    }
  }

  pickBackPanCardImg() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      backSide = File(result.files.single.path!);
      update();
      CustomToast.showToast(message: 'Back picture picked');
    } else {
      CustomToast.showToast(message: 'file not picked');
    }
  }

  emailPhoneVerification() async {
    try {
      print('verification');
      var formData = {
        'mobile_number': phone.text,
        'email': email.text,
      };
      final response = await http.post(
        Uri.parse('https://dream11.tennisworldxi.com/api/get/mobile_verification'),
        headers: apiHeader,
        body: formData,
      );
      print('response ${jsonDecode(response.body)}');

      if (response.statusCode == 200) {
        CustomToast.showToast(message: jsonDecode(response.body)['message']);
      }
      print('response message ${jsonDecode(response.body)['message']}');
    } catch (e) {
      print('error $e');
    }
  }

  pancardVerification() async {
    try {
      var formData = {
        'pen_card': pancardNo.text,
        'title': pancardtitle.text,
        'user_id': userId,
        'front_pic': frontSide?.path,
        'back_pic': backSide?.path,
      };
      var response = await http.post(
        Uri.parse('https://dream11.tennisworldxi.com/api/get/pan_card'),
        headers: apiHeader,
        body: formData,
      );
      if (response.statusCode == 200) {
        CustomToast.showToast(message: jsonDecode(response.body)['message']);
      }
    } catch (e) {
      print('$e');
    }
  }

  adharCardVerification() async {
    try {
      var formData = {
        'pen_card': adharcardNo.text,
        'title': adharcardtitle.text,
        'user_id': userId.toString(),
        'front_pic': frontSide!.readAsBytesSync().toString(),
        'back_pic': backSide!.readAsBytesSync().toString(),
      };
      print('path ${frontSide?.path}');

      var response = await http.post(
        Uri.parse('https://dream11.tennisworldxi.com/api/get/pan_card'),
        headers: apiHeader,
        body: formData,
      );
      print('respose ${jsonDecode(response.body)}');
      if (response.statusCode == 200) {
        CustomToast.showToast(message: jsonDecode(response.body)['message']);
      }
    } catch (e) {
      print('$e');
    }
  }
}
