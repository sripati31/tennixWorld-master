import 'package:TennixWorldXI/GetxController/teamController.dart';
import 'package:TennixWorldXI/models/MyModels/player_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constant/constants.dart';
import '../../../constant/themes.dart';

class CaptainVoiceCaptainItem extends StatefulWidget {
  PlayerModel player;
  int playerIndex;
  CaptainVoiceCaptainItem({
    Key? key,
    required this.player,
    required this.playerIndex,
  }) : super(key: key);
  @override
  _CaptainVoiceCaptainItemState createState() => _CaptainVoiceCaptainItemState();
}

class _CaptainVoiceCaptainItemState extends State<CaptainVoiceCaptainItem> {
  var teamContoller = Get.find<TeamController>();
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 1.0,
      child: Container(
        height: 60,
        color: AllCoustomTheme.getThemeData().backgroundColor,
        child: Material(
          color: Colors.transparent,
          child: Column(
            children: <Widget>[
              GetBuilder<TeamController>(builder: (contr) {
                return Expanded(
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 2),
                        child: Container(
                            width: 50,
                            height: 50,
                            child: ClipOval(
                              child: Image.network(
                                'https://dream11.tennisworldxi.com/storage/app/${widget.player.player_pic}',
                                fit: BoxFit.cover,
                              ),
                            )),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  '${widget.player.player_name}',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                                    fontSize: AppConstant.SIZE_TITLE12,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 4),
                                child: Text(
                                  '${widget.player.player_team_name} - ${widget.player.player_role}',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: AllCoustomTheme.getTextThemeColors(),
                                    fontSize: AppConstant.SIZE_TITLE10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Opacity(
                            opacity: contr.isCaptainSelect[widget.playerIndex] ? 1.0 : 0.2,
                            child: InkWell(
                              onTap: () {
                                if (contr.isCaptainSelect[widget.playerIndex]) {
                                  contr.isCaptainSelect[widget.playerIndex] = false;
                                  contr.isVoiceCaptainSelect[widget.playerIndex] = true;
                                  contr.captainID = 0;
                                  for (int i = 0; i < contr.isVoiceCaptainSelect.length; i++) {
                                    contr.isVoiceCaptainSelect[i] = false;
                                  }
                                  for (int i = 0; i < contr.isCaptainSelect.length; i++) {
                                    contr.isCaptainSelect[i] = false;
                                  }
                                } else {
                                  for (int i = 0; i < contr.isCaptainSelect.length; i++) {
                                    contr.isCaptainSelect[i] = false;
                                  }
                                  contr.isCaptainSelect[widget.playerIndex] = true;
                                  contr.captainID = int.parse(widget.player.player_id.toString());
                                  contr.isVoiceCaptainSelect[widget.playerIndex] = false;
                                }
                                contr.update();
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.1,
                                height: MediaQuery.of(context).size.height * 0.05,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey,
                                ),
                                child: Center(
                                  child: Text(
                                    'C',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                                      fontSize: AppConstant.SIZE_TITLE12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            '0.15%',
                            style: TextStyle(fontSize: 10),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 10,
                        child: Text('|'),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Opacity(
                            opacity: contr.isVoiceCaptainSelect[widget.playerIndex] ? 1.0 : 0.2,
                            child: InkWell(
                              onTap: () {
                                if (contr.isVoiceCaptainSelect[widget.playerIndex]) {
                                  contr.isVoiceCaptainSelect[widget.playerIndex] = false;
                                  contr.voiceCaptain = 0;

                                  for (int i = 0; i < contr.isVoiceCaptainSelect.length; i++) {
                                    contr.isVoiceCaptainSelect[i] = false;
                                  }
                                  for (int i = 0; i < contr.isCaptainSelect.length; i++) {
                                    contr.isCaptainSelect[i] = false;
                                  }
                                  contr.isCaptainSelect[widget.playerIndex] = true;
                                } else {
                                  for (int i = 0; i < contr.isVoiceCaptainSelect.length; i++) {
                                    contr.isVoiceCaptainSelect[i] = false;
                                  }
                                  contr.isCaptainSelect[widget.playerIndex] = false;
                                  contr.isVoiceCaptainSelect[widget.playerIndex] = true;
                                  contr.voiceCaptain = int.parse(widget.player.player_id.toString());
                                }
                                contr.update();
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.1,
                                height: MediaQuery.of(context).size.height * 0.05,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey,
                                ),
                                margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.05),
                                child: Center(
                                  child: Text(
                                    'VC',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                                      fontSize: AppConstant.SIZE_TITLE12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.05),
                            child: Text(
                              '0.30%',
                              style: TextStyle(fontSize: 10),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              }),
              Divider(
                height: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
