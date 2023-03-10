import 'package:TennixWorldXI/model_new/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel with ChangeNotifier {
  Future<bool> saveUser(UserModel user) async {
    if (kDebugMode) {
      print('Enter in saving sp');
      print('Value Token ${user.token}');
    }
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('token', user.token.toString());
    sp.setString('userName', user.userName.toString());
    sp.setString('userName', user.userEmail.toString());

    print('sp savedddddd ${user.token.toString()}');

    notifyListeners();
    return true;
  }

  Future<UserModel> getUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? token = sp.getString('token');

    return UserModel(
      token: token.toString(),
    );
  }

  Future<bool> remove() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('token');

    if (kDebugMode) {
      print('token removed');
    }
    return true;
  }
}
