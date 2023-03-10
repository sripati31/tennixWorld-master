// ignore_for_file: unused_field

import 'dart:io';
import 'package:TennixWorldXI/GetxController/VerificationController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:TennixWorldXI/constant/constants.dart';
import 'package:TennixWorldXI/constant/themes.dart';

import '../CustomImagePicker/camera.dart';

class PancardVerificationScreen extends StatefulWidget {
  @override
  _PancardVerificationScreenState createState() => _PancardVerificationScreenState();
}

class _PancardVerificationScreenState extends State<PancardVerificationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isProsses = false;
  bool isFirstTime = true;
  bool approved = false;
  var controller = Get.put(VerificationController());
  File? _image;
  var date = DateTime.now();

  var panNameController = new TextEditingController();
  var panNoController = new TextEditingController();
  var adharCardController = TextEditingController();
  var adharNameController = TextEditingController();
  int radioBtnGroup = 0;
  bool panCard = false;
  bool adharCard = true;

  @override
  void initState() {
    getPancardData();
    super.initState();
  }

  void getPancardData() async {
    setState(() {
      isProsses = true;
      panNoController.text = 'ABCD123';
      panNameController.text = 'Enric';
      adharCardController.text = 'ABCD';
      adharNameController.text = 'Ensd';
      date = DateFormat('dd/MM/yyyy').parse('30/05/1980');
      approved = true;
    });

    setState(() {
      isFirstTime = false;
      isProsses = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   gradient: LinearGradient(
      //     colors: [
      //       Colors.white,
      //       Colors.white,
      //     ],
      //     begin: Alignment.topCenter,
      //     end: Alignment.bottomCenter,
      //   ),
      // ),
      child: Stack(
        children: <Widget>[
          SafeArea(
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
                    : Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: expandData(),
                                ),
                              )
                            ],
                          ),
                          approved
                              ? Positioned(
                                  bottom: 32,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    padding: EdgeInsets.only(top: 8, left: 32, right: 32),
                                    child: Text(
                                      "Your Pan Card Verification Has been Approved",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontFamily: 'Poppins', color: Colors.green),
                                    ),
                                  ),
                                )
                              : SizedBox()
                        ],
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget expandData() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 1,
                child: RadioListTile(
                    value: 0,
                    groupValue: radioBtnGroup,
                    title: Text(
                      'Adhar Card',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        radioBtnGroup = value!;
                        adharCard = true;
                        panCard = false;
                      });
                    }),
              ),
              Expanded(
                flex: 1,
                child: RadioListTile(
                    value: 1,
                    groupValue: radioBtnGroup,
                    title: Text(
                      'Pan Card',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        radioBtnGroup = value!;
                        adharCard = false;
                        panCard = true;
                      });
                    }),
              ),
            ],
          ),
          Visibility(
            visible: adharCard,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: new Container(
                    child: new TextField(
                      controller: controller.adharcardtitle,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: AppConstant.SIZE_TITLE16,
                        color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                      ),
                      autofocus: false,
                      decoration: new InputDecoration(
                        labelText: 'Adhar card Name'.toUpperCase(),
                      ),
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: new Container(
                    child: new TextField(
                      controller: controller.adharcardNo,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: AppConstant.SIZE_TITLE16,
                        color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                      ),
                      autofocus: false,
                      decoration: new InputDecoration(
                        labelText: 'Adhar card No'.toUpperCase(),
                      ),
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: panCard,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: new Container(
                    child: new TextField(
                      controller: controller.pancardtitle,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: AppConstant.SIZE_TITLE16,
                        color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                      ),
                      autofocus: false,
                      decoration: new InputDecoration(
                        labelText: 'Pan card Name'.toUpperCase(),
                      ),
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: new Container(
                    child: new TextField(
                      controller: controller.pancardNo,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: AppConstant.SIZE_TITLE16,
                        color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                      ),
                      autofocus: false,
                      decoration: new InputDecoration(
                        labelText: 'Pan card No'.toUpperCase(),
                      ),
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              controller.pickFrontPanCardImg();
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
                      Icons.attach_file,
                      color: Colors.white,
                    ),
                    Text(
                      'Upload proof(Font Side)',
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
          GestureDetector(
            onTap: () {
              controller.pickBackPanCardImg();
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
                      Icons.attach_file,
                      color: Colors.white,
                    ),
                    Text(
                      'Upload proof(Back Side)',
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
          GestureDetector(
            onTap: () {
              if (adharCard) {
                controller.adharCardVerification();
              } else {
                controller.pancardVerification();
              }
            },
            child: Padding(
              padding: EdgeInsets.only(top: 40),
              child: Container(
                width: 200,
                height: 50,
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
                      Icons.verified,
                      color: Colors.white,
                    ),
                    Text(
                      'Submit',
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
        ],
      ),
    );
  }

  Future<File?> cropImage(File imageFile) async {
    File? croppedFile = await ImageCropper().cropImage(
      androidUiSettings: AndroidUiSettings(
        toolbarColor: AllCoustomTheme.getThemeData().backgroundColor,
      ),
      aspectRatio: CropAspectRatio(
        ratioX: 1.0,
        ratioY: 1.0,
      ),
      sourcePath: imageFile.path,
      maxWidth: 512,
      maxHeight: 512,
    );
    return croppedFile;
  }

  void showInSnackBar(String value, {bool isGreen = false}) {
    // ignore: deprecated_member_use
    ScaffoldMessenger.of(context).showSnackBar(
      new SnackBar(
        content: new Text(
          value,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: AppConstant.SIZE_TITLE14,
            color: AllCoustomTheme.getReBlackAndWhiteThemeColors(),
          ),
        ),
        backgroundColor: isGreen ? Colors.green : Colors.red,
      ),
    );
  }
}
