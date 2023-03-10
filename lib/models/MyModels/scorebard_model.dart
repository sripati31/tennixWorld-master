class LiveScoreboardModel {
  var teamname;
  var playername;
  var catchplayername;
  var bowlername;
  var runs;
  var bowl;
  LiveScoreboardModel({
    required this.bowl,
    required this.bowlername,
    required this.catchplayername,
    required this.playername,
    required this.runs,
    required this.teamname,
  });
}

class ScoreboardTeamModel {
  var team1name;
  var team2name;
  var team1TotalScore;
  var team1TotalWicket;
  var team2TotalScore;
  var team2TotalWicket;
  var team1ExtraScore;
  var team2ExtraScore;
  var team1IsInning;
  var team2IsInning;

  ScoreboardTeamModel({
    required this.team1ExtraScore,
    required this.team1IsInning,
    required this.team1TotalScore,
    required this.team1TotalWicket,
    required this.team1name,
    required this.team2ExtraScore,
    required this.team2IsInning,
    required this.team2TotalScore,
    required this.team2TotalWicket,
    required this.team2name,
  });
}

class ScoreboardPlayersModel {
  var batsman1_name;
  var batsman1_six;
  var batsman1_four;
  var batsman1_runs;
  var batsman1_bowls;

  var batsman2_name;
  var batsman2_six;
  var batsman2_four;
  var batsman2_runs;
  var batsman2_bowls;

  var bolwer_name;
  var bolwer_runs;
  var bolwer_wicket;
  var bolwer_no_balls;
  var bowler_runing_over;
  var bowler_runing_balls;

  ScoreboardPlayersModel({
    required this.batsman1_bowls,
    required this.batsman1_four,
    required this.batsman1_name,
    required this.batsman1_runs,
    required this.batsman1_six,
    required this.batsman2_bowls,
    required this.batsman2_four,
    required this.batsman2_name,
    required this.batsman2_runs,
    required this.batsman2_six,
    required this.bolwer_name,
    required this.bolwer_no_balls,
    required this.bolwer_runs,
    required this.bolwer_wicket,
    required this.bowler_runing_balls,
    required this.bowler_runing_over,
  });
}
