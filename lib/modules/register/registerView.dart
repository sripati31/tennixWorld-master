// ignore_for_file: unnecessary_null_comparison

import 'dart:io';
import 'package:TennixWorldXI/utils/phone_number.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:libphonenumber/libphonenumber.dart';
import 'package:provider/provider.dart';
import '../../../utils/toast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:TennixWorldXI/constant/constants.dart';
import 'package:TennixWorldXI/constant/themes.dart';
import 'package:TennixWorldXI/models/cityResponseData.dart';
import 'package:TennixWorldXI/models/countryResponseData.dart';
import 'package:TennixWorldXI/models/stateResponseData.dart';
import 'package:TennixWorldXI/modules/home/tabScreen.dart';
import 'package:TennixWorldXI/modules/login/continuebutton.dart';
import 'package:TennixWorldXI/modules/login/loginScreen.dart';

import '../../api/Api_Handler/api_call_Structure.dart';
import '../../api/Api_Handler/api_constants.dart';
import '../../api/Api_Handler/api_error_response.dart';
import '../../validator/validator.dart';
import '../../view_model/auth_view_model/sign_up_view_model.dart';
import '../CustomImagePicker/camera.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({
    Key? key,
  }) : super(key: key);
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  bool agree = false;
  var countryList = <CountryList>[];
  var stateList = <StateList>[];
  var cityList = <CityList>[];

  String imageUrl = '';
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  // TextEditingController referCodeController =  TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  FocusNode userNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();
  // var dobFocusNode = FocusNode();
  // var stateFocusNode = FocusNode();
  // var cityFocusNode = FocusNode();
  // var referFocusNode = FocusNode();
  // var date = DateTime.now();
  var isRegisterButtonPress = false;
  CountryList selectedCountry = CountryList();
  StateList selectedState = StateList();

  CityList selectedCity = CityList();

  String countryCode = "";
  File? _image;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    selectedState = StateList(name: 'Select your state');
    stateList.insert(0, selectedState);
    selectedCity = CityList(name: 'Select your city');
    cityList.insert(0, selectedCity);
    super.initState();
  }

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isRegisterButtonPress,
      color: Colors.transparent,
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 0, top: 50),
            child: Container(
              padding: EdgeInsets.only(bottom: 0),
              decoration: BoxDecoration(
                color: AllCoustomTheme.getThemeData().backgroundColor,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 50,
                          ),
                          Card(
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 12, bottom: 5),
                              child: Center(
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  controller: userNameController,
                                  focusNode: userNameFocusNode,
                                  decoration: InputDecoration(
                                    hintText: "User Name",
                                    fillColor: Colors.black,
                                    border: InputBorder.none,
                                  ),
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: AppConstant.SIZE_TITLE16,
                                    color: AllCoustomTheme
                                        .getBlackAndWhiteThemeColors(),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'User name can not be empty';
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
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 12, bottom: 5),
                              child: Center(
                                child: TextFormField(
                                  controller: emailController,
                                  focusNode: emailFocusNode,
                                  validator: _validateEmail,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    hintText: "Email",
                                    fillColor: Colors.black,
                                    border: InputBorder.none,
                                  ),
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: AppConstant.SIZE_TITLE16,
                                    color: AllCoustomTheme
                                        .getBlackAndWhiteThemeColors(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Card(
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 12, bottom: 5),
                              child: Center(
                                child: TextFormField(
                                  controller: phoneController,
                                  focusNode: phoneFocusNode,
                                  textAlignVertical: TextAlignVertical.center,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    hintText: "Phone Number",
                                    fillColor: Colors.black,
                                    border: InputBorder.none,
                                    prefixText: phoneFocusNode.hasFocus ||
                                            phoneController.text.isNotEmpty
                                        ? "+91 "
                                        : '',
                                    prefixStyle: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: AppConstant.SIZE_TITLE16,
                                      color: AllCoustomTheme
                                          .getBlackAndWhiteThemeColors(),
                                    ),
                                  ),
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: AppConstant.SIZE_TITLE16,
                                    color: AllCoustomTheme
                                        .getBlackAndWhiteThemeColors(),
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
                            height: 8,
                          ),
                          Container(
                            height: 60,
                            child: Card(
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 12, bottom: 5),
                                child: Center(
                                  child: TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      hintText: "referral code",
                                      fillColor: Colors.black,
                                      border: InputBorder.none,
                                    ),
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: AppConstant.SIZE_TITLE16,
                                      color: AllCoustomTheme
                                          .getBlackAndWhiteThemeColors(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // SizedBox(
                          //   height: 8,
                          // ),
                          // Container(
                          //   height: 60,
                          //   child: Card(
                          //     elevation: 8,
                          //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          //     child: Padding(
                          //       padding: const EdgeInsets.only(left: 12,bottom: 5),
                          //       child: Center(
                          //         child: TextFormField(
                          //           keyboardType: TextInputType.emailAddress,
                          //           decoration: InputDecoration(
                          //             hintText: "Gender",
                          //             fillColor: Colors.black,
                          //             border: InputBorder.none,
                          //           ),
                          //           style: TextStyle(
                          //             fontFamily: 'Poppins',
                          //             fontSize: AppConstant.SIZE_TITLE16,
                          //             color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 8,
                          // ),
                          // Container(
                          //   height: 60,
                          //   child: Card(
                          //     elevation: 8,
                          //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          //     child: Padding(
                          //       padding: const EdgeInsets.only(left: 12,bottom: 5),
                          //       child: Center(
                          //         child: TextFormField(
                          //           decoration: InputDecoration(
                          //             hintText: "Enter State Name",
                          //             fillColor: Colors.black,
                          //             border: InputBorder.none,
                          //           ),
                          //           style: TextStyle(
                          //             fontFamily: 'Poppins',
                          //             fontSize: AppConstant.SIZE_TITLE16,
                          //             color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 8,
                          // ),
                          // Container(
                          //   height: 60,
                          //   child: Card(
                          //     elevation: 8,
                          //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          //     child: Padding(
                          //       padding: const EdgeInsets.only(left: 12,bottom: 5),
                          //       child: Center(
                          //         child: TextFormField(
                          //           decoration: InputDecoration(
                          //             hintText: "Enter City Name",
                          //             fillColor: Colors.black,
                          //             border: InputBorder.none,
                          //           ),
                          //           style: TextStyle(
                          //             fontFamily: 'Poppins',
                          //             fontSize: AppConstant.SIZE_TITLE16,
                          //             color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 8,
                          // ),
                          // Container(
                          //   height: 60,
                          //   child: Card(
                          //     elevation: 8,
                          //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          //     child: Padding(
                          //       padding: const EdgeInsets.only(left: 12,bottom: 5),
                          //       child: Center(
                          //         child: TextFormField(
                          //           decoration: InputDecoration(
                          //             hintText: "Refer Code",
                          //             fillColor: Colors.black,
                          //             border: InputBorder.none,
                          //           ),
                          //           style: TextStyle(
                          //             fontFamily: 'Poppins',
                          //             fontSize: AppConstant.SIZE_TITLE16,
                          //             color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 8,
                          // ),
                          Card(
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 12, bottom: 5),
                              child: Center(
                                child: TextFormField(
                                  controller: passwordController,
                                  obscureText: true,
                                  focusNode: passwordFocusNode,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    fillColor: Colors.black,
                                    border: InputBorder.none,
                                  ),
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: AppConstant.SIZE_TITLE16,
                                    color: AllCoustomTheme
                                        .getBlackAndWhiteThemeColors(),
                                  ),
                                  validator: _validatePassword,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Card(
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 12, bottom: 5),
                              child: Center(
                                child: TextFormField(
                                  controller: confirmPasswordController,
                                  focusNode: confirmPasswordFocusNode,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hintText: "Confirm Password",
                                    fillColor: Colors.black,
                                    border: InputBorder.none,
                                  ),
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: AppConstant.SIZE_TITLE16,
                                    color: AllCoustomTheme
                                        .getBlackAndWhiteThemeColors(),
                                  ),
                                  validator: _validateConfirmPassword,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                        ],
                      ),
                    ),
                    Column(children: [
                      Row(
                        children: [
                          Material(
                            child: Checkbox(
                              value: agree,
                              onChanged: (value) {
                                setState(() {
                                  agree = value ?? false;
                                });
                              },
                            ),
                          ),
                          const Text(
                            'I have read and accept terms and conditions',
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ]),
                    Consumer<SignUpViewModel>(builder: (context, value, child) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            right: 14, left: 14, bottom: 14),
                        child: ContinueButton(
                          name: "Register",
                          callBack: () async {
                            FocusScope.of(context).unfocus();
                            // _submit();

                            if (_image == null &&
                                (loginUserData.image == '' ||
                                    loginUserData.image == null)) {
                              CustomToast.showToast(
                                  message: "Please select an image");
                            } else if (_formKey.currentState!.validate()) {
                              bool isValidNUmber = await isValidPhoneNumber(
                                  phoneNumber: phoneController.text);
                              if (isValidNUmber) {
                                var formData = {
                                  "user_name": userNameController.text.trim(),
                                  "email": emailController.text.trim(),
                                  "phone": phoneController.text.trim(),
                                  "dial_code": '+91',
                                  "password": passwordController.text.trim(),
                                  "password_confirmation":
                                      confirmPasswordController.text.trim(),
                                  "image": _image != null
                                      ? await MultipartFile.fromFile(
                                          _image!.path,
                                          filename: _image == null
                                              ? ""
                                              : _image!.path.split('/').last,
                                        )
                                      : null
                                };
                                value.signUpApi(
                                    data: formData, context: context);
                              } else {
                                CustomToast.showToast(
                                    message:
                                        "Please enter a valid phone number");
                              }
                            }
                          },
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: Stack(
              children: <Widget>[
                Container(
                  height: 96,
                  width: 96,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.black45,
                          offset: Offset(1.1, 1.1),
                          blurRadius: 3.0),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      InkWell(
                        onTap: () async {
                          Map<String, dynamic>? result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (builder) =>
                                      const CustomImagePickerScreen()));
                          debugPrint("pickedImage:-> $result");
                          if (result != null) {
                            setState(() {
                              _image = result['pickedImage'];
                              debugPrint("Picked an Image");
                            });
                          } else {
                            debugPrint("Not Picked any Image");
                          }
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(48.0),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: CircleAvatar(
                                radius: 48,
                                child: _image == null
                                    ? loginUserData.image == '' ||
                                            loginUserData.image == null
                                        ? Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                  AppConstant.playerImage,
                                                ),
                                              ),
                                            ),
                                          )
                                        : CachedNetworkImage(
                                            imageUrl: imageUrl,
                                            placeholder: (context, url) =>
                                                CircularProgressIndicator(
                                              strokeWidth: 2.0,
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                            fit: BoxFit.cover,
                                          )
                                    : Image.file(
                                        _image!,
                                        fit: BoxFit.cover,
                                      ),
                                backgroundColor:
                                    AllCoustomTheme.getThemeData().primaryColor,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  left: 70.0,
                  top: 70.0,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.black54,
                            offset: Offset(1.1, 1.1),
                            blurRadius: 2.0),
                      ],
                    ),
                    height: 20,
                    width: 20,
                    child: CircleAvatar(
                      backgroundColor:
                          AllCoustomTheme.getThemeData().backgroundColor,
                      child: Icon(Icons.edit,
                          size: 14,
                          color: AllCoustomTheme.getThemeData().primaryColor),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  var genderList = ['male', 'female', 'other'];
  var selectedGender = 'male';
  var genderListIndex = 0;

  // validate() async {
  //   if (_image == null &&
  //       (loginUserData.image == '' || loginUserData.image == null)) {
  //     CustomToast.showToast(message: "Please select an image");
  //     return false;
  //   } else if (_formKey.currentState!.validate()) {
  //     bool isValidNUmber =
  //         await isValidPhoneNumber(phoneNumber: phoneController.text);
  //     if (isValidNUmber) {
  //       _registerUser();
  //       return true;
  //     } else {
  //       CustomToast.showToast(message: "Please enter a valid phone number");
  //       return false;
  //     }
  //   }
  //   return true;
  // }

  // Future<void> _registerUser() async {
  //   // API_STRUCTURE apiObject = API_STRUCTURE(
  //   //     context: context,
  //   //     apiName: ApiConstant.registerUser,
  //   //     apiRequestMethod: API_REQUEST_METHOD.POST,
  //   //     isWantSuccessMessage: false,
  //   //     body: FormData.fromMap({
  //   // "user_name": userNameController.text.trim(),
  //   // "email": emailController.text.trim(),
  //   // "phone": phoneController.text.trim(),
  //   // "dial_code": '+91',
  //   // "password": passwordController.text.trim(),
  //   // "password_confirmation": confirmPasswordController.text.trim(),
  //   // "image": _image != null
  //   //     ? await MultipartFile.fromFile(
  //   //         _image!.path,
  //   //         filename: _image == null ? "" : _image!.path.split('/').last,
  //   //       )
  //   //     : null
  //   //     }));
  //   // Map<dynamic, dynamic> apiResponse = await apiObject.requestAPI(isShowLoading: true);
  //   // debugPrint("Register apiResponse:-> $apiResponse");
  //   // if (apiResponse.containsKey(API_RESPONSE.SUCCESS)) {
  //   //   CustomToast.showToast(message: "Registration successful", isShowSingle: false);
  //   //   CustomToast.showToast(message: "Login to continue");
  //   //   Navigator.pop(context);
  //   //   // Navigator.push(
  //   //   //   context,
  //   //   //   MaterialPageRoute(
  //   //   //     builder: (context) => TabScreen(),
  //   //   //   ),
  //   //   // );
  //   //   // Map<String,dynamic> _result = apiResponse[API_RESPONSE.SUCCESS]['data']['result'];
  //   // }
  //   try {
  //     var formData = {
  //       "user_name": userNameController.text.trim(),
  //       "email": emailController.text.trim(),
  //       "phone": phoneController.text.trim(),
  //       "dial_code": '+91',
  //       "password": passwordController.text.trim(),
  //       "password_confirmation": confirmPasswordController.text.trim(),
  //       "image": _image != null
  //           ? await MultipartFile.fromFile(
  //               _image!.path,
  //               filename: _image == null ? "" : _image!.path.split('/').last,
  //             )
  //           : null
  //     };
  //     var response = await Dio().post(
  //         'https://dream11.tennisworldxi.com/api/auth/signup',
  //         queryParameters: formData);
  //     if (response.statusCode == 200) {
  //       CustomToast.showToast(message: response.data['message'][0]);
  //     }
  //   } catch (e) {
  //     print('e');
  //     CustomToast.showToast(message: 'something went wrong!');
  //   }
  // }

  String? _validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'Email can not be empty';
    } else {
      if (!Validators().emailValidator(value)) {
        return 'Email is not valid';
      } else {
        return null;
      }
    }
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

  String? _validateConfirmPassword(String? value) {
    if (value!.isEmpty) {
      return 'Password can not be empty';
    } else {
      if (value.trim() != passwordController.text.trim()) {
        return 'Password does"nt match';
      } else {
        return null;
      }
    }
  }
}
