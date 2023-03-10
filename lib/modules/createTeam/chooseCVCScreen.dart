import 'package:TennixWorldXI/GetxController/teamController.dart';
import 'package:TennixWorldXI/modules/createTeam/CreateTeamViews/captain_voice_captain_view.dart';
import 'package:TennixWorldXI/modules/createTeam/CreateTeamViews/player_view_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:TennixWorldXI/bloc/teamSelectionBloc.dart';
import 'package:TennixWorldXI/constant/constants.dart';
import 'package:TennixWorldXI/constant/themes.dart';
import 'package:TennixWorldXI/models/scheduleResponseData.dart';
import 'package:TennixWorldXI/models/squadsResponseData.dart';
import 'package:TennixWorldXI/modules/createTeam/playerProfile.dart';
import 'package:TennixWorldXI/modules/createTeam/teamPreview.dart';
import 'package:TennixWorldXI/models/teamResponseData.dart' as team;
import 'package:TennixWorldXI/modules/myteams/myTeams.dart';
import 'package:TennixWorldXI/utils/avatarImage.dart';
import 'createTeamScreen.dart';

class ChooseCVCScreen extends StatefulWidget {
  final bool? isUpdateTeam;
  final CreateTeamType? createTeamtype;

  const ChooseCVCScreen({
    Key? key,
    this.isUpdateTeam = false,
    this.createTeamtype = CreateTeamType.createTeam,
  }) : super(key: key);

  @override
  _ChooseCVCScreenState createState() => _ChooseCVCScreenState();
}

class _ChooseCVCScreenState extends State<ChooseCVCScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var isLoginProsses = false;
  List<team.TeamData> createdTeamList = <team.TeamData>[];

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
              key: _scaffoldKey,
              backgroundColor: AllCoustomTheme.getThemeData().backgroundColor,
              body: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: <Widget>[
                  Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
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
                                          'Tue, 19 Aug',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 24,
                                            fontWeight: FontWeight.w500,
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
                              Container(
                                child: Center(
                                  child: Text(
                                    'Choose Captain and Vice Captain',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Container(
                                child: Center(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              width: 30,
                                              height: 30,
                                              child: Center(
                                                child: Container(
                                                  width: 24,
                                                  height: 24,
                                                  decoration: BoxDecoration(
                                                    borderRadius: new BorderRadius.circular(30.0),
                                                    border: new Border.all(
                                                      width: 1.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  child: Container(
                                                    padding: EdgeInsets.only(bottom: 2, top: 2),
                                                    child: Center(
                                                      child: Text(
                                                        'C',
                                                        style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: AppConstant.SIZE_TITLE12,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(bottom: 4),
                                              child: Center(
                                                child: Text(
                                                  ' gets 2x points',
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color: Colors.white,
                                                    fontSize: AppConstant.SIZE_TITLE14,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              width: 30,
                                              height: 30,
                                              child: Center(
                                                child: Container(
                                                  width: 24,
                                                  height: 24,
                                                  decoration: BoxDecoration(
                                                    borderRadius: new BorderRadius.circular(30.0),
                                                    border: new Border.all(
                                                      width: 1.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  child: Container(
                                                    padding: EdgeInsets.only(bottom: 4, top: 1),
                                                    child: Center(
                                                      child: Text(
                                                        'vc',
                                                        style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: AppConstant.SIZE_TITLE14,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(bottom: 4),
                                              child: Center(
                                                child: Text(
                                                  ' gets 1.5x points',
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color: Colors.white,
                                                    fontSize: AppConstant.SIZE_TITLE14,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ModalProgressHUD(
                            color: Colors.transparent,
                            inAsyncCall: isLoginProsses,
                            progressIndicator: CircularProgressIndicator(
                              strokeWidth: 2.0,
                            ),
                            child: GetBuilder<TeamController>(builder: (controller) {
                              return ListView.builder(
                                  padding: EdgeInsets.only(bottom: 100),
                                  physics: BouncingScrollPhysics(),
                                  itemCount: (controller.selectedPlayers.length) + 1,
                                  itemBuilder: (context, index) => index == 0 ? header() : CaptainVoiceCaptainItem(player: controller.selectedPlayers[index - 1], playerIndex: index));
                            }),
                          ),
                        )
                      ],
                    ),
                  ),
                  GetBuilder<TeamController>(builder: (cont) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 60),
                      child: Container(
                        height: 60,
                        padding: EdgeInsets.only(left: 50, right: 50, bottom: 20),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                decoration: new BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: new BorderRadius.circular(4.0),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(color: AllCoustomTheme.getThemeData().primaryColor.withOpacity(0.5), offset: Offset(0, 1), blurRadius: 5.0),
                                  ],
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: new BorderRadius.circular(4.0),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => TeamPreviewScreen(),
                                          fullscreenDialog: true,
                                        ),
                                      );
                                    },
                                    child: Center(
                                      child: Text(
                                        'PREVIEW',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.bold,
                                          color: AllCoustomTheme.getThemeData().primaryColor,
                                          fontSize: AppConstant.SIZE_TITLE12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Expanded(
                              child: Opacity(
                                opacity: cont.captainID != 0 && cont.voiceCaptain != 0 ? 1.0 : 0.2,
                                child: Container(
                                  decoration: new BoxDecoration(
                                    color: AllCoustomTheme.getThemeData().primaryColor,
                                    borderRadius: new BorderRadius.circular(4.0),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(color: Colors.black.withOpacity(0.5), offset: Offset(0, 1), blurRadius: 5.0),
                                    ],
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: new BorderRadius.circular(4.0),
                                      onTap: () async {
                                        if (cont.captainID != 0 && cont.voiceCaptain != 0) {
                                          await cont.createTeam();
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => MyTeamsScreen(),
                                            ),
                                          );
                                        }
                                      },
                                      child: Center(
                                        child: Text(
                                          'SAVE TEAM',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: AppConstant.SIZE_TITLE12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget header() {
    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03, right: MediaQuery.of(context).size.width * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'Type↓'.toUpperCase(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                  ),
                  Text(
                    'points'.toUpperCase(),
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    '% c by'.toUpperCase(),
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  Text(
                    '% vc by'.toUpperCase(),
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        Divider(
          height: 2,
          color: Colors.black,
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }
}
