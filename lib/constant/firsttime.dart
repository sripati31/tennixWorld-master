import 'package:TennixWorldXI/constant/global.dart';
import 'package:TennixWorldXI/constant/sharedPreferences.dart';

class FirstTime {
  static getValues() async {
    Utils.userToken = (await MySharedPreferences().getUserTokenString())!;
    Utils.userData = await MySharedPreferences().getUserData();
  }
}
