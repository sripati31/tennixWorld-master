import 'dart:convert';

class TeamModel {
  var team_id;
  var team_no;
  var wkeeper;
  var batters;
  var allRounders;
  var bowlers;
  var match_id;
  var captain_name;
  var vice_captain_name;
  var captain_pic;
  var vice_captain_pic;
  var team1_count;
  var team2_count;

  TeamModel({
    required this.match_id,
    required this.bowlers,
    required this.team_id,
    required this.team_no,
    required this.wkeeper,
    required this.batters,
    required this.allRounders,
    required this.vice_captain_pic,
    required this.captain_name,
    required this.captain_pic,
    required this.vice_captain_name,
    required this.team1_count,
    required this.team2_count,
  });

  factory TeamModel.fromJson({required Map<String, dynamic> json}) {
    return TeamModel(
      match_id: json['match_id'],
      bowlers: json['credit_point'],
      team_id: json['team_id'],
      team_no: json['team_no'],
      wkeeper: json['player_image'],
      batters: json['batters'],
      allRounders: json['allRounders'],
      captain_name: json['captainName'],
      captain_pic: json['captainImage'],
      vice_captain_name: json['vice_captainName'],
      vice_captain_pic: json['vice_captainImage'],
      team1_count: json['team1_count'],
      team2_count: json['team2_count'],
    );
  }
}
