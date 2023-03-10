import 'package:flutter/material.dart';
import 'package:TennixWorldXI/bloc/phoneVerificationBloc.dart';
import 'package:TennixWorldXI/models/userData.dart';

class Utils{
  static String ?userToken;
  static UserData ?userData;
  static Color primaryColorString = Color(0xFF3EB489);
  static Color secondaryColorString = Color(0xFF3145f5);
  static PhoneVerificationBloc? phoneVerificationBloc;
  static List<String> colors = ['#4FBE9F', '#32a852', '#e6230e', '#760ee6', '#db0ee6', '#db164e'];
  static int colorsIndex = 0;
}
