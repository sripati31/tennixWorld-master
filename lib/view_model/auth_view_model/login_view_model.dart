// ignore_for_file: avoid_print

import 'package:TennixWorldXI/repo/auth_repo/login_repo.dart';
import 'package:TennixWorldXI/utils/toast.dart';
import 'package:TennixWorldXI/utils/toasts_message.dart';
import 'package:TennixWorldXI/view_model/user_view_model/user_prefrence_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model_new/user_model.dart';
import '../../modules/home/tabScreen.dart';
import '../../repo/auth_repo/signup_repo.dart';

class LoginViewModel with ChangeNotifier {
  bool _signuploading = false;

  bool? success;
  String? message;
  String? token;

  bool get signuploading => _signuploading;

  setLoading(bool value) {
    _signuploading = value;
    notifyListeners();
  }

  final _myrepo = LoginRepository();

  Future<void> loginApi({dynamic data, required BuildContext context}) async {
    final userPrefernces = Provider.of<UserViewModel>(context, listen: false);

    setLoading(true);
    _myrepo
        .loginApi(
      data,
    )
        .then((value) {
      {
        setLoading(false);

        if (kDebugMode) {
          print(value['Newtoken'].toString());
        }
        setLoading(false);
        print(value['message'].toString());

        if (value[success] == true) {
          // Utils.toastMessage(message: value['message'].toString());
          // var data = value['user'];
          CustomToast.showToast(message: value['message'].toString());
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => TabScreen(),
              ));
          userPrefernces.saveUser(
            UserModel(
              token: value.token.toString(),
            ),
          );
          // Navigator.pushNamedAndRemoveUntil(
          //   context,
          //   ScreenRoutes.bottomNavbar,
          //   (route) => false,
          // );
        } else {
          //   Utils.toastMessage(message: value.message);
          setLoading(false);
        }
      }
    }).onError((error, stackTrace) {
      {
        setLoading(false);
        //  Utils.toastMessage(message: error.toString());
        if (kDebugMode) {
          print(error.toString());
        }
      }
    });
  }
}
