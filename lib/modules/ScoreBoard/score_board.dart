import 'package:TennixWorldXI/GetxController/scoreboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../constant/themes.dart';

class ScoreBoard extends StatefulWidget {
  const ScoreBoard({super.key});

  @override
  State<ScoreBoard> createState() => _ScoreBoardState();
}

class _ScoreBoardState extends State<ScoreBoard> {
  ScoreboardController controller = Get.put(ScoreboardController());

  //batters
  int batter1Run = 0;
  int batter2Run = 0;
  int batter1Ball = 0;
  int batter2Ball = 0;
  int batter1Fours = 0;
  int batter2Fours = 0;
  int batter1Six = 0;
  int batter2Six = 0;
  //bowler
  int over = 0;
  int bowlerBalls = 0;
  int bowlerRun = 0;
  int overM = 0;
  int bowlerWicket = 0;
  int bowlerNoBall = 0;
  //team
  int teamScore = 0;
  int teamLossWicket = 0;
  bool strikPlayer1 = true;
  bool strikPlayer2 = false;
  //extra
  int extraRuns = 0;
  //for undo purpose
  int undoBatter1Run = 0;
  int undoBatter2Run = 0;
  int undoBatter1Ball = 0;
  int undoBatter2Ball = 0;
  int undoBatter1Fours = 0;
  int undoBatter2Fours = 0;
  int undoBatter1Six = 0;
  int undoBatter2Six = 0;
  int undoOver = 0;
  int undoBowlerBalls = 0;
  int undoBowlerRun = 0;
  int undoOverM = 0;
  int undoBowlerWicket = 0;
  int undoBowlerNoBall = 0;
  int undoTeamScore = 0;
  int undoTeamLossWicket = 0;
  int undoExtraRuns = 0;
  bool undoStrickPlayer1 = false;
  bool undoStrickPlayer2 = false;
  //check user last state
  int lastState = 1; //1 for player1

  void pressNumberButtonByUser(int btnValue) {
    int n = btnValue;

    if (bowlerBalls < 6) {
      undoBowlerBalls = bowlerBalls;
      bowlerBalls++;
      undoOver = over;
    } else if (bowlerBalls == 6) {
      over++;
      undoBowlerBalls = bowlerBalls;
      bowlerBalls = 0;
    }
    if (strikPlayer1) {
      undoBatter1Ball = batter1Ball;
      undoBatter1Fours = batter1Fours;
      undoBatter1Run = batter1Run;
      undoBatter1Six = batter1Six;
      undoTeamLossWicket = teamLossWicket;
      undoTeamScore = teamScore;
      undoBowlerRun = bowlerRun;
      ////
      batter1Ball++;
      batter1Run += n;
      teamScore += n;
      bowlerRun += n;

      lastState = 1;

      strikPlayer2 = false;
      strikPlayer1 = true;
      if (n == 0) {
        undoStrickPlayer1 = strikPlayer1;
        undoStrickPlayer2 = strikPlayer2;

        ///
        strikPlayer1 = true;
        strikPlayer2 = false;
        if (bowlerBalls == 5 && bowlerRun == 0) {
          overM++;
        }
      } else if (n == 1) {
        undoStrickPlayer1 = strikPlayer1;
        undoStrickPlayer2 = strikPlayer2;

        ///
        strikPlayer1 = false;
        strikPlayer2 = true;
      } else if (n == 3) {
        undoStrickPlayer1 = strikPlayer1;
        undoStrickPlayer2 = strikPlayer2;

        //
        strikPlayer1 = false;
        strikPlayer2 = true;
      } else if (n == 4) {
        batter1Fours++;
      } else if (n == 5) {
        undoStrickPlayer1 = strikPlayer1;
        undoStrickPlayer2 = strikPlayer2;

        //
        strikPlayer1 = false;
        strikPlayer2 = true;
      } else if (n == 6) {
        batter1Six++;
      }
    } else {
      undoBatter2Ball = batter2Ball;
      undoBatter2Fours = batter2Fours;
      undoBatter2Run = batter2Run;
      undoBatter2Six = batter2Six;
      undoTeamLossWicket = teamLossWicket;
      undoTeamScore = teamScore;
      undoBowlerRun = bowlerRun;

      ///
      lastState = 2;

      batter2Ball++;
      batter2Run += n;
      teamScore += n;
      bowlerRun += n;

      if (n == 0) {
        undoStrickPlayer1 = strikPlayer1;
        undoStrickPlayer2 = strikPlayer2;

        ///
        strikPlayer1 = true;
        strikPlayer2 = false;
        if (bowlerBalls == 6 && bowlerBalls == 0) {
          overM++;
        }
      } else if (n == 1) {
        undoStrickPlayer1 = strikPlayer1;
        undoStrickPlayer2 = strikPlayer2;

        //
        strikPlayer2 = false;
        strikPlayer1 = true;
      } else if (n == 3) {
        undoStrickPlayer1 = strikPlayer1;
        undoStrickPlayer2 = strikPlayer2;

        //
        strikPlayer2 = false;
        strikPlayer1 = true;
      } else if (n == 4) {
        batter2Fours++;
      } else if (n == 5) {
        undoStrickPlayer1 = strikPlayer1;
        undoStrickPlayer2 = strikPlayer2;

        //
        strikPlayer2 = false;
        strikPlayer1 = true;
      } else if (n == 6) {
        batter2Six++;
      }
    }
    setState(() {});
    controller.updateScoreboard(btnValue);
  }

  void pressNonNumberBtns(var val) {
    if (val == 'Wide') {
      undoExtraRuns = extraRuns;
      undoBowlerRun = bowlerRun;
      undoTeamScore = teamScore;
      //
      extraRuns++;
      bowlerRun++;
      teamScore++;
    } else if (val == 'No Ball') {
      undoExtraRuns = extraRuns;
      undoBowlerRun = bowlerRun;
      undoTeamScore = teamScore;
      undoBowlerNoBall = bowlerNoBall;

      ///
      extraRuns++;
      bowlerRun++;
      teamScore++;
      bowlerNoBall++;
    } else if (val == 'Bye') {
      if (bowlerBalls < 6) {
        undoBowlerBalls = bowlerBalls;
        bowlerBalls++;
      } else if (bowlerBalls >= 6) {
        undoOver = over;
        over++;
        bowlerBalls = 0;
      }
      undoExtraRuns = extraRuns;
      undoBowlerRun = bowlerRun;
      undoTeamScore = teamScore;

      ///
      extraRuns++;
      bowlerRun++;
      teamScore++;
    } else if (val == 'Led Bye') {
      if (bowlerBalls < 6) {
        undoBowlerBalls = bowlerBalls;
        bowlerBalls++;
      } else if (bowlerBalls >= 6) {
        undoOver = over;
        over++;
        bowlerBalls = 0;
      }

      undoExtraRuns = extraRuns;
      undoBowlerRun = bowlerRun;
      undoTeamScore = teamScore;

      ///
      extraRuns += 2;
      bowlerRun += 2;
      teamScore += 2;
    } else if (val == 'Wicket') {
      if (bowlerBalls < 6) {
        undoBowlerBalls = bowlerBalls;
        bowlerBalls++;
      } else if (bowlerBalls >= 6) {
        undoOver = over;
        over++;
        bowlerBalls = 0;
      }
      undoBowlerWicket = bowlerWicket;
      undoTeamLossWicket = teamLossWicket;

      ///
      bowlerWicket++;
      teamLossWicket++;
    } else {
      if (lastState == 1) {
        batter1Ball = undoBatter1Ball;
        batter1Run = undoBatter1Run;
        batter1Fours = undoBatter1Fours;
        batter1Six = undoBatter1Six;
      } else {
        batter2Ball = undoBatter2Ball;
        batter2Run = undoBatter2Run;
        batter2Six = undoBatter2Six;
        batter2Fours = undoBatter2Fours;
      }
      //
      print('undo over $undoOver');
      teamScore = undoTeamScore;
      teamLossWicket = undoTeamLossWicket;
      bowlerNoBall = undoBowlerNoBall;
      bowlerBalls = undoBowlerBalls;
      bowlerRun = undoBowlerRun;
      extraRuns = undoExtraRuns;
      over = undoOver;
      bowlerWicket = undoBowlerWicket;
      strikPlayer1 = undoStrickPlayer1;
      strikPlayer2 = undoStrickPlayer2;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff081c3f),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: GetBuilder<ScoreboardController>(
              builder: (controller) {
                return Column(
                  children: [
                    Container(
                      height: AppBar().preferredSize.height,
                      color: Color(0xff081c3f),
                      child: Row(
                        children: <Widget>[
                          Material(
                            color: Color(0xff081c3f),
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: AppBar().preferredSize.height,
                                height: AppBar().preferredSize.height,
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.2,
                              ),
                              Column(
                                children: [
                                  Text(
                                    'tennisworldxi'.toUpperCase(),
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    'Scoreboard'.toUpperCase(),
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Color(0xff081c3f),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/13.png',
                                        width: 50,
                                        height: 30,
                                        fit: BoxFit.fitHeight,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '${controller.scoreboardTeam?.team1name}'.toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '${controller.scoreboardTeam?.team1TotalWicket}/${controller.scoreboardTeam?.team1TotalScore}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/17.png',
                                        width: 50,
                                        height: 30,
                                        fit: BoxFit.fitHeight,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '${controller.scoreboardTeam?.team2name}'.toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '${controller.scoreboardTeam?.team2TotalWicket}/${controller.scoreboardTeam?.team2TotalScore}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 430,
                      child: ListView(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(color: Colors.white),
                                right: BorderSide(color: Colors.white),
                                top: BorderSide(color: Colors.white),
                              ),
                              color: Color(0xff081c3f),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 55,
                                        decoration: BoxDecoration(
                                            border: Border(
                                          bottom: BorderSide(
                                            color: Colors.blue,
                                            width: 4,
                                          ),
                                        )),
                                        child: Center(
                                          child: Text(
                                            '2nd Inning',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 55,
                                        decoration: BoxDecoration(
                                            border: Border(
                                          bottom: BorderSide(
                                            color: Colors.white,
                                            width: 2,
                                          ),
                                        )),
                                        child: Center(
                                          child: Text(
                                            'Ball-by-Ball',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      left: BorderSide(color: Colors.white),
                                      right: BorderSide(color: Colors.white),
                                      bottom: BorderSide(color: Colors.white),
                                    ),
                                    color: Color(0xff081c3f),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: 55,
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'Batters'.toUpperCase(),
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: 55,
                                          child: Center(
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    'R',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.normal,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    'B',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.normal,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    '4s',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.normal,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    '6s',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.normal,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 40,
                                        margin: EdgeInsets.only(right: 30),
                                        decoration: strikPlayer1
                                            ? BoxDecoration(
                                                border: Border.all(
                                                  width: 2,
                                                  color: Colors.white.withOpacity(0.5),
                                                ),
                                                borderRadius: BorderRadius.circular(10),
                                              )
                                            : BoxDecoration(),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 5),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '${controller.scoreboardPlayers?.batsman1_name}',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              strikPlayer1
                                                  ? Icon(
                                                      Icons.subdirectory_arrow_right_outlined,
                                                      color: Colors.white,
                                                    )
                                                  : Text(''),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 55,
                                        child: Center(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  '${controller.scoreboardPlayers?.batsman1_runs}',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.normal,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  '${controller.scoreboardPlayers?.batsman1_bowls}',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.normal,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  '${controller.scoreboardPlayers?.batsman1_four}',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.normal,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  '${controller.scoreboardPlayers?.batsman1_six}',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.normal,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 40,
                                        margin: EdgeInsets.only(right: 30),
                                        decoration: strikPlayer2
                                            ? BoxDecoration(
                                                border: Border.all(
                                                  width: 2,
                                                  color: Colors.white.withOpacity(0.5),
                                                ),
                                                borderRadius: BorderRadius.circular(10),
                                              )
                                            : BoxDecoration(),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 5),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '${controller.scoreboardPlayers?.batsman2_name.toString().split(' ')[0]}',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              strikPlayer2
                                                  ? Icon(
                                                      Icons.subdirectory_arrow_right_outlined,
                                                      color: Colors.white,
                                                    )
                                                  : Text(''),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 55,
                                        child: Center(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  '${controller.scoreboardPlayers?.batsman2_runs}',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.normal,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  '${controller.scoreboardPlayers?.batsman2_bowls}',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.normal,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  '${controller.scoreboardPlayers?.batsman2_four}',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.normal,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  '${controller.scoreboardPlayers?.batsman2_six}',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.normal,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 40,
                                        decoration: BoxDecoration(
                                          // border: Border.all(
                                          //   width: 2,
                                          //   color: Colors.black.withOpacity(0.5),
                                          // ),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 5),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Partnership'.toUpperCase(),
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              // Icon(Icons.subdirectory_arrow_right_outlined),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 55,
                                        child: Center(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  '10',
                                                  // '${controller.scoreboardPlayers?.batsman1_runs + controller.scoreboardPlayers?.batsman2_runs}',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.normal,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  '10',

                                                  // '${controller.scoreboardPlayers?.batsman1_bowls + controller.scoreboardPlayers?.batsman2_bowls}',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.normal,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  '10',

                                                  // '${controller.scoreboardPlayers?.batsman1_four + controller.scoreboardPlayers?.batsman2_four}',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.normal,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  '10',

                                                  // '${controller.scoreboardPlayers?.batsman1_six + controller.scoreboardPlayers?.batsman2_six}',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.normal,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    color: Color(0xff081c3f),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: 55,
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'Bowler'.toUpperCase(),
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: 55,
                                          child: Center(
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    'O',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.normal,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    'R',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.normal,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    'M',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.normal,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    'W',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.normal,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    'N',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.normal,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 40,
                                        margin: EdgeInsets.only(right: 30, left: 10),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 2,
                                            color: Colors.white.withOpacity(0.5),
                                          ),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 5),
                                            child: Row(
                                              children: [
                                                Text(
                                                  '10',
                                                  // "${controller.scoreboardPlayers!.bolwer_name}",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.normal,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 55,
                                        child: Center(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  '${controller.scoreboardPlayers?.bowler_runing_balls}.${controller.scoreboardPlayers?.bowler_runing_over}',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.normal,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  '${controller.scoreboardPlayers?.bolwer_runs}',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.normal,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  '$overM',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.normal,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  '${controller.scoreboardPlayers?.bolwer_wicket}',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.normal,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  '${controller.scoreboardPlayers?.bolwer_no_balls}',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.normal,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    color: Color(0xff081c3f),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: 40,
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'Extra Runs'.toUpperCase(),
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: 40,
                                          child: Center(
                                            child: Row(
                                              children: [
                                                Text(
                                                  '${controller.scoreboardTeam?.team1ExtraScore}',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.normal,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 14),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    pressNumberButtonByUser(0);
                                  },
                                  child: Container(
                                    width: 60,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white, width: 3),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                        child: Text(
                                      '0',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        color: Colors.white,
                                      ),
                                    )),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    pressNumberButtonByUser(1);
                                  },
                                  child: Container(
                                    width: 60,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white, width: 3),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                        child: Text(
                                      '1',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        color: Colors.white,
                                      ),
                                    )),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    pressNumberButtonByUser(2);
                                  },
                                  child: Container(
                                    width: 60,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white, width: 3),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                        child: Text(
                                      '2',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        color: Colors.white,
                                      ),
                                    )),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    pressNumberButtonByUser(3);
                                  },
                                  child: Container(
                                    width: 60,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white, width: 3),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                        child: Text(
                                      '3',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        color: Colors.white,
                                      ),
                                    )),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    pressNonNumberBtns('undo');
                                  },
                                  child: Container(
                                    width: 60,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      border: Border.all(color: Colors.green, width: 3),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                        child: Icon(
                                      Icons.undo,
                                      color: Colors.white,
                                    )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    pressNumberButtonByUser(4);
                                  },
                                  child: Container(
                                    width: 60,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white, width: 3),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                        child: Text(
                                      '4',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        color: Colors.white,
                                      ),
                                    )),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    pressNumberButtonByUser(6);
                                  },
                                  child: Container(
                                    width: 60,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white, width: 3),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                        child: Text(
                                      '6',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        color: Colors.white,
                                      ),
                                    )),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    pressNumberButtonByUser(5);
                                  },
                                  child: Container(
                                    width: 60,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white, width: 3),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                        child: Text(
                                      '5+',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        color: Colors.white,
                                      ),
                                    )),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    width: 60,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white, width: 3),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                        child: Text(
                                      'End\nOver'.toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    )),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  width: 60,
                                  height: 55,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    Get.dialog(WideBallBtnDialog());
                                  },
                                  child: Container(
                                    width: 60,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white, width: 3),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                        child: Text(
                                      'wide'.toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),
                                    )),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    Get.dialog(MyDialog());
                                  },
                                  child: Container(
                                    width: 60,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white, width: 3),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                        child: Text(
                                      'No\nBall'.toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),
                                    )),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    pressNonNumberBtns('Bye');
                                  },
                                  child: Container(
                                    width: 60,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white, width: 3),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                        child: Text(
                                      'bye'.toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),
                                    )),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    pressNonNumberBtns('Led Bye');
                                  },
                                  child: Container(
                                    width: 60,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white, width: 3),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                        child: Text(
                                      'Led\nbye'.toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),
                                    )),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    // pressNonNumberBtns('Wicket');

                                    Get.dialog(MyDialog());
                                  },
                                  child: Container(
                                    width: 60,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      border: Border.all(color: Colors.red, width: 3),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                        child: Text(
                                      'Wicket'.toUpperCase(),
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),
                                    )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                );
              },
            )),
      ),
    );
  }
}

class MyDialog extends StatefulWidget {
  MyDialog({super.key});

  @override
  State<MyDialog> createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  double opacity = 0.2;
  int runs = 0;
  int extra_runs = 0;
  ScoreboardController controller = Get.put(ScoreboardController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        actions: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          opacity = 1.0;
                        });
                      },
                      child: Text('Run Out'),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          opacity = 1.0;
                        });
                      },
                      child: Text('Stumping'),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          opacity = 0.1;
                          runs = 0;
                          extra_runs = 0;
                        });
                      },
                      child: Text('Catch'),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          opacity = 0.1;
                          runs = 0;
                          extra_runs = 0;
                        });
                      },
                      child: Text('Bold'),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          opacity = 0.1;
                          runs = 0;
                          extra_runs = 0;
                        });
                      },
                      child: Text('Hit Wicket'),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          opacity = 0.1;
                          runs = 0;
                          extra_runs = 0;
                        });
                      },
                      child: Text('Retired Hurt'),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          opacity = 1.0;
                        });
                      },
                      child: Text('Wide'),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          opacity = 1.0;
                        });
                      },
                      child: Text('No Ball'),
                    ),
                  ),
                ],
              ),
              Opacity(
                  opacity: opacity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            if (runs < 6 && opacity == 1.0) {
                              runs++;
                              setState(() {});
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.add,
                                color: AllCoustomTheme.getThemeData().primaryColor,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Player Runs : $runs',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            if (runs > 0 && opacity == 1.0) {
                              runs--;
                              setState(() {});
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.remove,
                                color: Colors.red,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: 10,
              ),
              Opacity(
                  opacity: opacity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            if (extra_runs < 6 && opacity == 1.0) {
                              extra_runs++;
                              setState(() {});
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.add,
                                color: AllCoustomTheme.getThemeData().primaryColor,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Extra Runs : $extra_runs',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            if (extra_runs > 0 && opacity == 1.0) {
                              extra_runs--;
                              setState(() {});
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.remove,
                                color: Colors.red,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text('Submit'),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

///////////

class WideBallBtnDialog extends StatefulWidget {
  WideBallBtnDialog({super.key});

  @override
  State<WideBallBtnDialog> createState() => _WideBallBtnDialogState();
}

class _WideBallBtnDialogState extends State<WideBallBtnDialog> {
  double opacity = 0.2;
  int runs = 0;
  int extra_runs = 0;
  var controller = Get.put(ScoreboardController());
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        actions: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          opacity = 1.0;
                        });
                      },
                      child: Text('Wide'),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          opacity = 1.0;
                        });
                      },
                      child: Text('Bye'),
                    ),
                  ),
                ],
              ),
              Opacity(
                  opacity: opacity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            if (extra_runs < 6 && opacity == 1.0) {
                              extra_runs++;
                              setState(() {});
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.add,
                                color: AllCoustomTheme.getThemeData().primaryColor,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Extra Runs : $extra_runs',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            if (extra_runs > 0 && opacity == 1.0) {
                              extra_runs--;
                              setState(() {});
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.black),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.remove,
                                color: Colors.red,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () {
                        controller.wideBallCalling();
                        Get.back();
                      },
                      child: Text('Submit'),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
