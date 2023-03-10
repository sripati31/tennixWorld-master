import 'package:TennixWorldXI/GetxController/VerificationController.dart';
import 'package:TennixWorldXI/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:TennixWorldXI/constant/constants.dart';
import 'package:TennixWorldXI/constant/themes.dart';
import 'package:TennixWorldXI/models/bankinfoResponce.dart';

class EmailVerificationScreen extends StatefulWidget {
  @override
  _EmailVerificationScreenState createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isProsses = false;
  bool isFirstTime = true;
  bool isRejected = false;
  bool approved = false;
  var pancardDetail = PancardDetail();
  var controller = Get.put(VerificationController(), permanent: true);
  var noController = new TextEditingController();
  var emailController = new TextEditingController();

  @override
  void initState() {
    getPancardData();
    super.initState();
  }

  void getPancardData() async {
    setState(() {
      isProsses = true;
      noController.text = '9876543210';
      emailController.text = 'enric@gmail.com';
    });

    setState(() {
      isFirstTime = false;
      isProsses = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            Colors.white,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: AllCoustomTheme.getThemeData().backgroundColor,
          body: ModalProgressHUD(
            inAsyncCall: isProsses,
            color: Colors.transparent,
            progressIndicator: CircularProgressIndicator(
              strokeWidth: 2.0,
            ),
            child: isFirstTime
                ? SizedBox()
                : Column(
                    children: [
                      Expanded(
                        child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: <Widget>[
                            isRejected
                                ? Positioned(
                                    top: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      padding: EdgeInsets.only(top: 8, left: 32, right: 32),
                                      child: Text(
                                        isRejected ? 'Your Pan Card Verification Has been Rejected' : '',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontFamily: 'Poppins', color: Colors.green),
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                            Column(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    child: expandData(),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (controller.phone.text.isEmpty && controller.email.text.isEmpty) {
                            CustomToast.showToast(message: 'Please enter email or mobile number');
                          } else {
                            controller.emailPhoneVerification();
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.only(top: 38, left: 16, right: 16, bottom: 8),
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: new BoxDecoration(
                              color: AllCoustomTheme.getThemeData().primaryColor,
                              borderRadius: new BorderRadius.circular(4.0),
                              boxShadow: <BoxShadow>[
                                BoxShadow(color: Colors.black.withOpacity(0.5), offset: Offset(0, 1), blurRadius: 5.0),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.check,
                                  color: Colors.white,
                                ),
                                Text(
                                  'Verify',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: AllCoustomTheme.getThemeData().backgroundColor,
                                    fontSize: AppConstant.SIZE_TITLE16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 70,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget expandData() {
    return Container(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: new Container(
                    child: new TextField(
                      controller: controller.phone,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: AppConstant.SIZE_TITLE16,
                        color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                      ),
                      autofocus: false,
                      decoration: new InputDecoration(
                        labelText: 'Mobile No',
                      ),
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      onChanged: (value) {
                        pancardDetail.accountNo = value;
                      },
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: new Container(
                    child: new TextField(
                      controller: controller.email,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: AppConstant.SIZE_TITLE16,
                        color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                      ),
                      autofocus: false,
                      decoration: new InputDecoration(
                        labelText: 'Email',
                      ),
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      onChanged: (value) {
                        pancardDetail.accountPhoto = value;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
