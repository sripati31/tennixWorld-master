import 'package:TennixWorldXI/GetxController/teamController.dart';
import 'package:TennixWorldXI/main.dart';
import 'package:TennixWorldXI/utils/toast.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ContestController extends GetxController {
  TeamController teamController = TeamController();
  int? contest_id;
  int? team_id;
  joinUserContest() async {
    try {
      var formData = {
        'match_id': 14,
        'contest_id': contest_id,
        'team_id': team_id,
        'user_id': userId,
      };
      var response = await Dio().post('https://dream11.tennisworldxi.com/api/contest/userjoin-contest', queryParameters: formData);
      if (response.statusCode == 200) {
        CustomToast.showToast(message: response.data['data']);
      }
    } catch (e) {
      print('error $e');
      CustomToast.showToast(message: e.toString());
    }
  }
}
