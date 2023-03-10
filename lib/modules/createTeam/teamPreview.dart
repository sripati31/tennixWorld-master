// ignore_for_file: unnecessary_null_comparison

import 'package:TennixWorldXI/GetxController/teamController.dart';
import 'package:TennixWorldXI/models/MyModels/player_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:TennixWorldXI/api/apiProvider.dart';
import 'package:TennixWorldXI/bloc/teamSelectionBloc.dart';
import 'package:TennixWorldXI/bloc/teamTapBloc.dart';
import 'package:TennixWorldXI/constant/constants.dart';
import 'package:TennixWorldXI/constant/themes.dart';
import 'package:TennixWorldXI/models/scheduleResponseData.dart';
import 'package:TennixWorldXI/models/squadsResponseData.dart';
import 'package:TennixWorldXI/modules/createTeam/playerProfile.dart';
import 'package:TennixWorldXI/utils/avatarImage.dart';
import 'package:TennixWorldXI/models/teamResponseData.dart' as team;
import 'createTeamScreen.dart';

enum CreateTeamPreviewType { regular, created }

class TeamPreviewScreen extends StatefulWidget {
  @override
  _TeamPreviewScreenState createState() => _TeamPreviewScreenState();
}

class _TeamPreviewScreenState extends State<TeamPreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black,
        child: GetBuilder<TeamController>(
          builder: ((controller) {
            return Stack(
              children: <Widget>[
                SafeArea(
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    body: ModalProgressHUD(
                      inAsyncCall: false,
                      color: Colors.transparent,
                      progressIndicator: CircularProgressIndicator(
                        strokeWidth: 2.0,
                      ),
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: <Widget>[
                          Opacity(
                            opacity: 0.4,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: Image.asset(
                                AppConstant.cricketGround,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  height: 8,
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(bottom: 8, top: 4),
                                      child: Text(
                                        'WICKET - KEEPER',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Colors.white,
                                          fontSize: AppConstant.SIZE_TITLE12,
                                        ),
                                      ),
                                    ),
                                    getTypeList(controller.select_wicketKiperList),
                                  ],
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(bottom: 8, top: 4),
                                      child: Text(
                                        'BATSMEN',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Colors.white,
                                          fontSize: AppConstant.SIZE_TITLE12,
                                        ),
                                      ),
                                    ),
                                    getTypeList(controller.select_batterList),
                                  ],
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(bottom: 8, top: 4),
                                      child: Text(
                                        'ALL-ROUNDERS',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Colors.white,
                                          fontSize: AppConstant.SIZE_TITLE12,
                                        ),
                                      ),
                                    ),
                                    getTypeList(controller.select_allRounderList),
                                  ],
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(bottom: 8, top: 4),
                                      child: Text(
                                        'BOWLERS',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Colors.white,
                                          fontSize: AppConstant.SIZE_TITLE12,
                                        ),
                                      ),
                                    ),
                                    getTypeList(controller.select_bowlerList),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child: Container(
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
                              child: Icon(Icons.close, color: Colors.white),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: AppBar().preferredSize.height - 20,
                              height: AppBar().preferredSize.height,
                              child: Icon(Icons.edit, color: Colors.white),
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              width: AppBar().preferredSize.height - 20,
                              height: AppBar().preferredSize.height,
                              child: Icon(Icons.share, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          }),
        ));
  }

  Widget getTypeList(List<PlayerModel> list) {
    List<Widget> pList = <Widget>[];
    list.forEach((pdata) {
      pList.add(getPlayerView(pdata));
    });

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: pList,
      ),
    );
  }

  Widget getPlayerView(PlayerModel player) {
    final firstname = player.player_name;
    var teamController = Get.find<TeamController>();
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: (MediaQuery.of(context).size.width > 360 ? 8 : 4), right: (MediaQuery.of(context).size.width > 360 ? 8 : 4)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              InkWell(
                onTap: () {},
                child: Container(
                    width: (MediaQuery.of(context).size.width > 360 ? 45 : 40),
                    height: (MediaQuery.of(context).size.width > 360 ? 45 : 40),
                    child: Image.network('https://dream11.tennisworldxi.com/storage/app/${player.player_pic}')),
              ),
              Container(
                padding: EdgeInsets.only(left: 6, top: 2, bottom: 2, right: 6),
                decoration: new BoxDecoration(
                  color: AllCoustomTheme.getThemeData().primaryColor,
                  borderRadius: new BorderRadius.circular(4.0),
                  boxShadow: <BoxShadow>[
                    BoxShadow(color: Colors.black.withOpacity(0.5), offset: Offset(0, 1), blurRadius: 5.0),
                  ],
                ),
                child: Center(
                  child: Text(
                    player.player_name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize: (MediaQuery.of(context).size.width > 360 ? AppConstant.SIZE_TITLE10 : 8),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(4),
                child: Center(
                  child: Text(
                    '${player.player_credit}  Cr',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize: AppConstant.SIZE_TITLE10,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: player.player_id == teamController.captainID
              ? Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: new BorderRadius.circular(32.0),
                    border: new Border.all(
                      width: 1.0,
                      color: AllCoustomTheme.getThemeData().primaryColor,
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.only(bottom: 2),
                    child: Center(
                      child: Text(
                        'C',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: AllCoustomTheme.getThemeData().primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: AppConstant.SIZE_TITLE10,
                        ),
                      ),
                    ),
                  ),
                )
              : player.player_id == teamController.voiceCaptain
                  ? Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: new BorderRadius.circular(32.0),
                        border: new Border.all(
                          width: 1.0,
                          color: AllCoustomTheme.getThemeData().primaryColor,
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.only(bottom: 4),
                        child: Center(
                          child: Text(
                            'vc',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: AllCoustomTheme.getThemeData().primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
        )
      ],
    );
  }
}
