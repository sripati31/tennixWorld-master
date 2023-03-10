import 'package:TennixWorldXI/utils/toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  int userId = 0;
  TextEditingController phone = TextEditingController();
  forgotPassword() async {
    try {
      print(phone.text);
      var response = await Dio().post('https://dream11.tennisworldxi.com/api/password/forgot', queryParameters: {
        'phone': '3125706922',
      });
      if (response.statusCode == 200) {
        CustomToast.showToast(message: response.data['data']['message']);
      }
    } catch (e) {
      CustomToast.showToast(message: 'something went wrong!');
    }
  }
}
