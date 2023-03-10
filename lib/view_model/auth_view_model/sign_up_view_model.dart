// ignore_for_file: avoid_print

import 'package:TennixWorldXI/view_model/user_view_model/user_prefrence_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import '../../model_new/user_model.dart';
import '../../repo/auth_repo/signup_repo.dart';
import '../../utils/toast.dart';

class SignUpViewModel with ChangeNotifier {
  bool _signuploading = false;

  bool? success;
  String? message;
  String? token;

  bool get signuploading => _signuploading;

  setLoading(bool value) {
    _signuploading = value;
    notifyListeners();
  }

  final _myrepo = SignupRepository();

  Future<void> signUpApi({dynamic data, BuildContext? context}) async {
    final userPrefernces = Provider.of<UserViewModel>(context!, listen: false);

    setLoading(true);
    _myrepo
        .signUpApi(
      data,
    )
        .then((value) {
      {
        setLoading(false);

        if (kDebugMode) {
          print(value.toString());
        }
        setLoading(false);

        if (value.success == true) {
          CustomToast.showToast(message: value.message.toString());

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
          CustomToast.showToast(message: value.message.toString());
          setLoading(false);
        }
      }
    }).onError((error, stackTrace) {
      {
        setLoading(false);
        CustomToast.showToast(message: error.toString());
        if (kDebugMode) {
          print(error.toString());
        }
      }
    });
  }
}
