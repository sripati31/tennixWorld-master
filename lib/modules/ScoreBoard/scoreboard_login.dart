import 'package:TennixWorldXI/constant/global.dart';
import 'package:TennixWorldXI/constant/sharedPreferences.dart';
import 'package:TennixWorldXI/main.dart';
import 'package:TennixWorldXI/models/userData.dart';
import 'package:TennixWorldXI/modules/ScoreBoard/score_board.dart';
import 'package:TennixWorldXI/modules/login/forgotPasswordView.dart';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:TennixWorldXI/constant/constants.dart';
import 'package:TennixWorldXI/constant/themes.dart';
import 'package:TennixWorldXI/validator/validator.dart';
import 'package:get/get.dart';
import '../../api/Api_Handler/api_call_Structure.dart';
import '../../api/Api_Handler/api_constants.dart';
import '../../api/Api_Handler/api_error_response.dart';
import '../../utils/phone_number.dart';
import '../../utils/toast.dart';
import '../home/tabScreen.dart';
import '../login/continuebutton.dart';

class ScoreboardLoginView extends StatefulWidget {
  const ScoreboardLoginView({
    Key? key,
  }) : super(key: key);
  @override
  _ScoreboardLoginViewState createState() => _ScoreboardLoginViewState();
}

class _ScoreboardLoginViewState extends State<ScoreboardLoginView> {
  DateTime date = DateTime.now();
  TextEditingController username = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  var _obscureConfirmText = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    phoneFocusNode.dispose();
    passwordController.dispose();
    username.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  String? _validatePassword(String? value) {
    if (value!.isEmpty) {
      return 'Password can not be empty';
    } else {
      if (!Validators().passwordValidator(value)) {
        return 'Password length should be greater than 6 chars.';
      } else {
        return null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Scoreboard Login',
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
                              controller: username,
                              focusNode: phoneFocusNode,
                              textAlignVertical: TextAlignVertical.center,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                hintText: "Username",
                                fillColor: Colors.black,
                                border: InputBorder.none,
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
                                  return 'Usernmae can not be empty';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
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
                              controller: passwordController,
                              autofocus: false,
                              focusNode: passwordFocusNode,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                              obscureText: _obscureConfirmText,
                              decoration: InputDecoration(
                                hintText: "Password",
                                fillColor: Colors.black,
                                border: InputBorder.none,
                                suffixIcon: GestureDetector(
                                  dragStartBehavior: DragStartBehavior.down,
                                  onTap: () {
                                    setState(() {
                                      _obscureConfirmText = !_obscureConfirmText;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 14),
                                    child: Icon(
                                      _obscureConfirmText ? Icons.visibility_off : Icons.visibility,
                                      semanticLabel: _obscureConfirmText ? 'show password' : 'hide password',
                                    ),
                                  ),
                                ),
                              ),
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: AppConstant.SIZE_TITLE16,
                                color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                              ),
                              onEditingComplete: () {
                                FocusScope.of(context).requestFocus(FocusNode());
                              },
                              validator: _validatePassword,
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
                child: ContinueButton(
                  name: "Login",
                  callBack: () {
                    if (_formKey.currentState!.validate()) {
                      Get.to(ScoreBoard());
                    }
                  },
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(right: 14, left: 14, bottom: 14),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => ForgotPasswordView()));
                    },
                    child: Container(
                      height: 50,
                      decoration: new BoxDecoration(
                        color: AllCoustomTheme.getThemeData().primaryColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                          child: Text(
                        'Forgot Password',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: AppConstant.SIZE_TITLE18,
                          fontWeight: FontWeight.bold,
                          color: AllCoustomTheme.getThemeData().backgroundColor,
                        ),
                      )),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
