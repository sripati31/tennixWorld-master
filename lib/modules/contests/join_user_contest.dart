import 'package:TennixWorldXI/GetxController/teamController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../constant/constants.dart';
import '../../constant/themes.dart';
import 'contestsScreen.dart';

class JoinUserContest extends StatefulWidget {
  const JoinUserContest({super.key});

  @override
  State<JoinUserContest> createState() => _JoinUserContestState();
}

class _JoinUserContestState extends State<JoinUserContest> {
  var teamController = Get.find<TeamController>();
  @override
  void initState() {
    teamController.getAllUserTeams();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AllCoustomTheme.getThemeData().primaryColor,
            AllCoustomTheme.getThemeData().primaryColor,
            Colors.white,
            Colors.white,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Stack(
        children: <Widget>[
          SafeArea(
            child: Scaffold(
              backgroundColor: AllCoustomTheme.getThemeData().backgroundColor,
              body: ModalProgressHUD(
                inAsyncCall: false,
                color: Colors.transparent,
                progressIndicator: CircularProgressIndicator(
                  strokeWidth: 2.0,
                ),
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          color: AllCoustomTheme.getThemeData().primaryColor,
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: AppBar().preferredSize.height,
                                child: Row(
                                  children: <Widget>[
                                    Material(
                                      color: Colors.transparent,
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
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          'Join Contest',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: AppConstant.SIZE_TITLE22,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: AppBar().preferredSize.height,
                                    )
                                  ],
                                ),
                              ),
                              MatchHadder(
                                titel: "BYJU's jharkhand T20",
                                country1Name: "${teamController.team1Name}",
                                country2Name: "${teamController.team2Name}",
                                country1Flag: 'https://dream11.tennisworldxi.com/storage/app/${teamController.team1Flag}',
                                country2Flag: 'https://dream11.tennisworldxi.com/storage/app/${teamController.team2Flag}',
                                price: "₹2 Lakhs",
                                time: '',
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                GetBuilder<TeamController>(
                                    builder: (con) => Expanded(
                                        child: ListView.builder(
                                            itemCount: con.userTeams.length,
                                            itemBuilder: (context, index) {
                                              return Card(
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      height: 150,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.only(
                                                            topLeft: Radius.circular(13),
                                                            topRight: Radius.circular(13),
                                                          ),
                                                          image: DecorationImage(image: AssetImage(AppConstant.cricketGround), fit: BoxFit.cover)),
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  'Team ${con.userTeams[index].team_no}',
                                                                  style: TextStyle(
                                                                    fontFamily: 'Poppins',
                                                                    fontWeight: FontWeight.bold,
                                                                    fontSize: AppConstant.SIZE_TITLE14,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 6,
                                                          ),
                                                          Row(
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                            children: [
                                                              Column(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  Text(
                                                                    '${teamController.team1ShortName}',
                                                                    style: TextStyle(
                                                                      fontFamily: 'Poppins',
                                                                      fontWeight: FontWeight.bold,
                                                                      color: Colors.white,
                                                                      fontSize: AppConstant.SIZE_TITLE14,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 8,
                                                                  ),
                                                                  Text(
                                                                    '4',
                                                                    style: TextStyle(
                                                                      fontFamily: 'Poppins',
                                                                      fontWeight: FontWeight.bold,
                                                                      color: Colors.white,
                                                                      fontSize: AppConstant.SIZE_TITLE14,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Column(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  Text(
                                                                    '${teamController.team2ShortName}',
                                                                    style: TextStyle(
                                                                      fontFamily: 'Poppins',
                                                                      fontWeight: FontWeight.bold,
                                                                      color: Colors.white,
                                                                      fontSize: AppConstant.SIZE_TITLE14,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 8,
                                                                  ),
                                                                  Text(
                                                                    '4',
                                                                    style: TextStyle(
                                                                      fontFamily: 'Poppins',
                                                                      fontWeight: FontWeight.bold,
                                                                      color: Colors.white,
                                                                      fontSize: AppConstant.SIZE_TITLE14,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Stack(
                                                                children: [
                                                                  Column(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: [
                                                                      ClipOval(
                                                                          child: Image.network(
                                                                        'https://dream11.tennisworldxi.com/storage/app/${con.userTeams[index].captain_pic}',
                                                                        width: 60,
                                                                        height: 60,
                                                                        fit: BoxFit.cover,
                                                                      )),
                                                                      Container(
                                                                        decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(7)),
                                                                        child: Padding(
                                                                          padding: const EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8),
                                                                          child: Text(
                                                                            '${con.userTeams[index].captain_name}',
                                                                            style: TextStyle(
                                                                              fontFamily: 'Poppins',
                                                                              color: Colors.white,
                                                                              fontSize: AppConstant.SIZE_TITLE12,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  CircleAvatar(
                                                                    radius: 12,
                                                                    backgroundColor: Colors.white,
                                                                    child: CircleAvatar(
                                                                      backgroundColor: Colors.grey[300],
                                                                      radius: 13,
                                                                      child: Text(
                                                                        'C',
                                                                        style: TextStyle(
                                                                          fontFamily: 'Poppins',
                                                                          color: Colors.white,
                                                                          fontSize: AppConstant.SIZE_TITLE12,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              Stack(
                                                                children: [
                                                                  Column(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: [
                                                                      ClipOval(
                                                                          child: Image.network(
                                                                        'https://dream11.tennisworldxi.com/storage/app/${con.userTeams[index].vice_captain_pic}',
                                                                        width: 60,
                                                                        height: 60,
                                                                        fit: BoxFit.cover,
                                                                      )),
                                                                      Container(
                                                                        decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(7)),
                                                                        child: Padding(
                                                                          padding: const EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8),
                                                                          child: Text(
                                                                            '${con.userTeams[index].vice_captain_name}',
                                                                            style: TextStyle(
                                                                              fontFamily: 'Poppins',
                                                                              color: Colors.white,
                                                                              fontSize: AppConstant.SIZE_TITLE12,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  CircleAvatar(
                                                                    radius: 12,
                                                                    backgroundColor: Colors.white,
                                                                    child: CircleAvatar(
                                                                      backgroundColor: Colors.grey[300],
                                                                      radius: 13,
                                                                      child: Text(
                                                                        'VC',
                                                                        style: TextStyle(
                                                                          fontFamily: 'Poppins',
                                                                          color: Colors.white,
                                                                          fontSize: AppConstant.SIZE_TITLE12,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            'Wk',
                                                            style: TextStyle(
                                                              fontFamily: 'Poppins',
                                                              fontWeight: FontWeight.bold,
                                                              color: AllCoustomTheme.getTextThemeColors(),
                                                              fontSize: AppConstant.SIZE_TITLE12,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 8,
                                                          ),
                                                          Text(
                                                            '${con.userTeams[index].wkeeper}',
                                                            style: TextStyle(
                                                              fontFamily: 'Poppins',
                                                              fontWeight: FontWeight.bold,
                                                              color: AllCoustomTheme.getTextThemeColors(),
                                                              fontSize: AppConstant.SIZE_TITLE12,
                                                            ),
                                                          ),
                                                          // Expanded(child: SizedBox()),
                                                          Text(
                                                            'BAT',
                                                            style: TextStyle(
                                                              fontFamily: 'Poppins',
                                                              fontWeight: FontWeight.bold,
                                                              color: AllCoustomTheme.getTextThemeColors(),
                                                              fontSize: AppConstant.SIZE_TITLE12,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 8,
                                                          ),
                                                          Text(
                                                            '${con.userTeams[index].batters}',
                                                            style: TextStyle(
                                                              fontFamily: 'Poppins',
                                                              fontWeight: FontWeight.bold,
                                                              color: AllCoustomTheme.getTextThemeColors(),
                                                              fontSize: AppConstant.SIZE_TITLE12,
                                                            ),
                                                          ),
                                                          // Expanded(child: SizedBox()),
                                                          Text(
                                                            'AR',
                                                            style: TextStyle(
                                                              fontFamily: 'Poppins',
                                                              fontWeight: FontWeight.bold,
                                                              color: AllCoustomTheme.getTextThemeColors(),
                                                              fontSize: AppConstant.SIZE_TITLE12,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 8,
                                                          ),
                                                          Text(
                                                            '${con.userTeams[index].allRounders}',
                                                            style: TextStyle(
                                                              fontFamily: 'Poppins',
                                                              fontWeight: FontWeight.bold,
                                                              color: AllCoustomTheme.getTextThemeColors(),
                                                              fontSize: AppConstant.SIZE_TITLE12,
                                                            ),
                                                          ),
                                                          // Expanded(child: SizedBox()),
                                                          Text(
                                                            'BOWEL',
                                                            style: TextStyle(
                                                              fontFamily: 'Poppins',
                                                              fontWeight: FontWeight.bold,
                                                              color: AllCoustomTheme.getTextThemeColors(),
                                                              fontSize: AppConstant.SIZE_TITLE12,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 8,
                                                          ),
                                                          Text(
                                                            '${con.userTeams[index].bowlers}',
                                                            style: TextStyle(
                                                              fontFamily: 'Poppins',
                                                              fontWeight: FontWeight.bold,
                                                              color: AllCoustomTheme.getTextThemeColors(),
                                                              fontSize: AppConstant.SIZE_TITLE12,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 8,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                            children: [
                                                              Radio(
                                                                  value: index,
                                                                  groupValue: con.group_val,
                                                                  onChanged: (va) {
                                                                    con.group_val = va;
                                                                    con.team_id = con.userTeams[index].team_id;
                                                                    con.update();
                                                                  }),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }))),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton.extended(
                backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
                onPressed: () {},
                label: Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
