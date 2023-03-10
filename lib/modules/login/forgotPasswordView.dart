import 'package:TennixWorldXI/GetxController/UserController.dart';
import 'package:TennixWorldXI/modules/login/otpTimer.dart';
import 'package:flutter/material.dart';
import 'package:TennixWorldXI/constant/constants.dart';
import 'package:get/get.dart';

import '../../constant/themes.dart';

class ForgotPasswordView extends StatefulWidget {
  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  var forgotController = Get.put(UserController());
  FocusNode phoneFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();
  bool sendBtnClick = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Forgot Password',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: AppConstant.SIZE_TITLE20,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            color: AllCoustomTheme.getThemeData().backgroundColor,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 8, bottom: 4, right: 16),
        child: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, bottom: 5),
                        child: Center(
                          child: TextFormField(
                            onTap: () {
                              Future.delayed(const Duration(milliseconds: 100)).then((value) {
                                setState(() {});
                              });
                            },
                            controller: forgotController.phone,
                            focusNode: phoneFocusNode,
                            textAlignVertical: TextAlignVertical.center,
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              hintText: "Phone Number",
                              fillColor: Colors.black,
                              border: InputBorder.none,
                              prefixText: phoneFocusNode.hasFocus || forgotController.phone.text.isNotEmpty ? "+91 " : '',
                              prefixStyle: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: AppConstant.SIZE_TITLE16,
                                color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                              ),
                            ),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: AppConstant.SIZE_TITLE16,
                              color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Phone number can not be empty';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(right: 14, left: 14, bottom: 14),
                child: GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      // if (sendBtnClick) {
                      //   sendBtnClick = false;
                      // } else {
                      //   sendBtnClick = true;
                      // }
                      // setState(() {});
                      forgotController.forgotPassword();
                    }
                  },
                  child: Container(
                    height: 50,
                    decoration: new BoxDecoration(
                      color: AllCoustomTheme.getThemeData().primaryColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                        child: Text(
                      'Send OTP',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: AppConstant.SIZE_TITLE18,
                        fontWeight: FontWeight.bold,
                        color: AllCoustomTheme.getThemeData().backgroundColor,
                      ),
                    )),
                  ),
                )),
            sendBtnClick ? OtpTimerView() : SizedBox(),
          ],
        ),
      ),
    );
  }
}
