import 'dart:convert';

class PlayerModel {
  var player_id;
  var player_name;
  var player_pic;
  var player_role;
  var player_team_name;
  var player_credit;
  var match_id;

  PlayerModel({
    required this.match_id,
    required this.player_credit,
    required this.player_id,
    required this.player_name,
    required this.player_pic,
    required this.player_role,
    required this.player_team_name,
  });

  factory PlayerModel.fromJson({required Map<String, dynamic> json}) {
    return PlayerModel(
      match_id: json['match_id'],
      player_credit: json['credit_point'],
      player_id: json['player_id'],
      player_name: json['player_name'],
      player_pic: json['player_image'],
      player_role: json['player_role'],
      player_team_name: json['player_team_name'],
    );
  }
}
