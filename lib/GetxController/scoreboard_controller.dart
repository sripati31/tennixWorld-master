import 'package:TennixWorldXI/modules/ScoreBoard/score_board.dart';
import 'package:TennixWorldXI/utils/toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../models/MyModels/scorebard_model.dart';

class ScoreboardController extends GetxController {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  int loginStatus = 0;
  ScoreboardTeamModel? scoreboardTeam;
  ScoreboardPlayersModel? scoreboardPlayers;
  var batsman1_id;
  var batsman2_id;
  var bowler_id;
  getAllScoreboardData() async {
    try {
      var formData = {
        'id': 8,
      };
      var response = await Dio().post('https://dream11.tennisworldxi.com/api/score/get/data', queryParameters: formData);
      if (response.statusCode == 200) {
        var isLogin = response.data['score']['board_login_status'];
        loginStatus = isLogin;
        update();
        // print('scoreboard Data ${response.data['score']['batsman1']}');
        scoreboardTeam = response.data['team1']['is_inning'] == 'bating'
            ? ScoreboardTeamModel(
                team1ExtraScore: response.data['team1']['total_extras'],
                team1IsInning: response.data['team1']['is_inning'],
                team1TotalScore: response.data['team1']['total_scores'],
                team1TotalWicket: response.data['team1']['total_wicket'],
                team1name: response.data['team1']['name'],
                team2ExtraScore: response.data['team2']['total_extras'],
                team2IsInning: response.data['team2']['is_inning'],
                team2TotalScore: response.data['team2']['total_scores'],
                team2TotalWicket: response.data['team2']['total_wicket'],
                team2name: response.data['team2']['name'],
              )
            : ScoreboardTeamModel(
                team1ExtraScore: response.data['team2']['total_extras'],
                team1IsInning: response.data['team2']['is_inning'],
                team1TotalScore: response.data['team2']['total_scores'],
                team1TotalWicket: response.data['team2']['total_wicket'],
                team1name: response.data['team2']['name'],
                team2ExtraScore: response.data['team1']['total_extras'],
                team2IsInning: response.data['team1']['is_inning'],
                team2TotalScore: response.data['team1']['total_scores'],
                team2TotalWicket: response.data['team1']['total_wicket'],
                team2name: response.data['team1']['name'],
              );
        update();
        scoreboardPlayers = ScoreboardPlayersModel(
          batsman1_bowls: response.data['score']['batsman1']['total_balls'],
          batsman1_four: response.data['score']['batsman1']['fours'],
          batsman1_name: response.data['score']['batsman1']['player_name'],
          batsman1_runs: response.data['score']['batsman1']['total_runs'],
          batsman1_six: response.data['score']['batsman1']['sixes'],
          batsman2_bowls: response.data['score']['batsman2']['total_balls'],
          batsman2_four: response.data['score']['batsman2']['fours'],
          batsman2_name: response.data['score']['batsman2']['player_name'],
          batsman2_runs: response.data['score']['batsman2']['total_runs'],
          batsman2_six: response.data['score']['batsman2']['sixes'],
          bolwer_name: response.data['score']['boller']['player_name'],
          bolwer_no_balls: response.data['score']['boller']['no_balls'],
          bolwer_runs: response.data['score']['boller']['run_given_by_overs'],
          bolwer_wicket: response.data['score']['boller']['total_wicket'],
          bowler_runing_balls: response.data['score']['running_over_balls'],
          bowler_runing_over: response.data['score']['running_over'],
        );
        batsman1_id = response.data['score']['running_bastman1'];
        batsman2_id = response.data['score']['running_bastman2'];
        bowler_id = response.data['score']['runnig_bolwer_name'];
        update();
      }
    } catch (e) {
      print('error $e');
      CustomToast.showToast(message: 'Something went wrong!');
    }
  }

  scoreboardLogin() async {
    var formData = {
      'user_name': username.text,
      'password': password.text,
    };
    var response = await Dio().post('https://dream11.tennisworldxi.com/api/score/login', queryParameters: formData);
    if (response.statusCode == 200) {}
  }

  updateScoreboard(int runs) async {
    var formData = {
      'score_id': 8,
      'running_bastman1': batsman1_id,
      'running_bastman2': batsman2_id,
      'bollwer_id': bowler_id,
      'run_by_ball': runs,
      'ball': 1,
    };
    var response = await Dio().post('https://dream11.tennisworldxi.com/api/score/update/data', queryParameters: formData);
    if (response.statusCode == 200) {
      getAllScoreboardData();
    }
  }

  wideBallCalling() async {
    var formData = {
      'score_id': 8,
      'bollwer_id': bowler_id,
    };
    print('wide');
    var response = await Dio().post('https://dream11.tennisworldxi.com/api/score/wide-ball-run', queryParameters: formData);
    if (response.statusCode == 200) {
      getAllScoreboardData();
    }
  }

  noBallCalling() async {
    var formData = {
      'score_id': 8,
      'bollwer_id': bowler_id,
    };
    var response = await Dio().post('https://dream11.tennisworldxi.com/api/score/no-ball-run', queryParameters: formData);
    if (response.statusCode == 200) {
      getAllScoreboardData();
    }
  }

  outPlayerCalling() async {
    var formData = {"bowller_id": bowler_id, "player_id1": batsman1_id, "player_id2": batsman2_id, "type": 2};
    var response = await Dio().post('https://dream11.tennisworldxi.com/api/score/out-player', queryParameters: formData);
    if (response.statusCode == 200) {
      getAllScoreboardData();
    }
  }
}
