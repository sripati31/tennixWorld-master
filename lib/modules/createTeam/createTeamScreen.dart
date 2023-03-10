import 'package:TennixWorldXI/GetxController/teamController.dart';
import 'package:TennixWorldXI/modules/createTeam/CreateTeamViews/player_view_item.dart';
import 'package:flutter/material.dart';
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
import 'package:TennixWorldXI/modules/createTeam/chooseCVCScreen.dart';
import 'package:TennixWorldXI/modules/createTeam/createTeamProgressbar.dart';
import 'package:TennixWorldXI/modules/createTeam/playerProfile.dart';
import 'package:TennixWorldXI/modules/createTeam/teamPreview.dart';
import 'package:TennixWorldXI/utils/avatarImage.dart';
import 'package:TennixWorldXI/models/teamResponseData.dart' as team;

enum CreateTeamType { createTeam, editTeam, copyTeam }

enum TabTextType { wk, bat, ar, bowl }

enum AnimationType { isRegular, isMinimum, isFull, isSeven, isCredits, atLeast }

TeamSelectionBloc teamSelectionBloc = TeamSelectionBloc(TeamSelectionBlocState.initial());
TeamTapBloc teamTapBloc = TeamTapBloc(TeamTapBlocState.initial());

//CreateTeamScreen Main Class

class CreateTeamScreen extends StatefulWidget {
  final ShedualData? shedualData;
  final CreateTeamType? createTeamtype;
  final team.TeamData? createdTeamData;

  const CreateTeamScreen({Key? key, this.shedualData, this.createTeamtype = CreateTeamType.createTeam, this.createdTeamData}) : super(key: key);
  @override
  _CreateTeamScreenState createState() => _CreateTeamScreenState();
}

class _CreateTeamScreenState extends State<CreateTeamScreen> with SingleTickerProviderStateMixin {
  late TabController tabController;
  var selectedIndex = 0;
  var allPlayerList = <Players>[];
  bool isLoginProsses = false;
  var teamController = Get.put(TeamController(), permanent: true);

  @override
  void initState() {
    teamController.getPlayersData();
    teamSelectionBloc.cleanList();
    teamTapBloc.cleanList();
    tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    tabController.addListener(() {
      setState(() {});
      print(tabController.index);
      selectedIndex = tabController.index;
      print(tabController.indexIsChanging);
    });
    getSquadTeamData();
    super.initState();
  }

  void getSquadTeamData() async {
    setState(() {
      isLoginProsses = true;
    });
    final data = await ApiProvider().getPlayersData();

    if (data != null && data.playerList!.length > 0) {
      allPlayerList.clear();
      allPlayerList = data.playerList!;

      teamSelectionBloc = TeamSelectionBloc(TeamSelectionBlocState.initial());
      teamTapBloc = TeamTapBloc(TeamTapBlocState.initial());
      if (widget.createTeamtype == CreateTeamType.createTeam) {
        teamSelectionBloc.onListChanges(allPlayerList);
      } else if (widget.createTeamtype == CreateTeamType.editTeam && widget.createdTeamData != null) {
        allPlayerList.forEach((p) {
          if (p.title!.toLowerCase() == widget.createdTeamData!.captun!.toLowerCase()) {
            p.isSelcted = true;
            p.isC = true;
          }
          if (p.title!.toLowerCase() == widget.createdTeamData!.wiseCaptun!.toLowerCase()) {
            p.isVC = true;
            p.isSelcted = true;
          }
          if (isMach(p.title!)) {
            p.isSelcted = true;
          }
        });
        teamSelectionBloc.onListChanges(allPlayerList);
      } else if (widget.createTeamtype == CreateTeamType.copyTeam && widget.createdTeamData != null) {
        allPlayerList.forEach((p) {
          if (p.title!.toLowerCase() == widget.createdTeamData!.captun!.toLowerCase()) {
            p.isSelcted = true;
            p.isC = true;
          }
          if (p.title!.toLowerCase() == widget.createdTeamData!.wiseCaptun!.toLowerCase()) {
            p.isVC = true;
            p.isSelcted = true;
          }
          if (isMach(p.title!)) {
            p.isSelcted = true;
          }
        });
        teamSelectionBloc.onListChanges(allPlayerList);
      }
    }
    setState(() {
      isLoginProsses = false;
    });
  }

  bool isMach(String name) {
    bool isMach = false;
    var allplayername = <String>[];
    allplayername.addAll(widget.createdTeamData!.bastman!.split(','));
    allplayername.addAll(widget.createdTeamData!.allRounder!.split(','));
    allplayername.addAll(widget.createdTeamData!.bowler!.split(','));
    allplayername.add(widget.createdTeamData!.wicketKeeper!);
    allplayername.forEach((pName) {
      if (pName == name) {
        isMach = true;
        return;
      }
    });
    return isMach;
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
              body: Stack(
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
                                        '${teamController.current_date}',
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
                              padding: EdgeInsets.all(4),
                              color: AllCoustomTheme.getThemeData().primaryColor,
                              child: Center(
                                child: Text(
                                  'Max 7 players from a team',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontSize: AppConstant.SIZE_TITLE14,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width >= 360 ? 75 : 65,
                                    padding: EdgeInsets.all(4),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            'Players',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              color: Colors.white54,
                                              fontSize: MediaQuery.of(context).size.width >= 360 ? AppConstant.SIZE_TITLE12 : AppConstant.SIZE_TITLE10,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: <Widget>[
                                              GetBuilder<TeamController>(builder: (con) {
                                                return Container(
                                                  child: Text(
                                                    '${con.getSelectedPlayerCount()}',
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white,
                                                      fontSize: MediaQuery.of(context).size.width >= 360 ? AppConstant.SIZE_TITLE20 : AppConstant.SIZE_TITLE18,
                                                    ),
                                                  ),
                                                );
                                              }),
                                              Container(
                                                padding: EdgeInsets.only(bottom: 4),
                                                child: Text(
                                                  ' / 11',
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color: Colors.white54,
                                                    fontSize: MediaQuery.of(context).size.width >= 360 ? AppConstant.SIZE_TITLE12 : AppConstant.SIZE_TITLE10,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Center(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Expanded(
                                              child: Container(
                                                padding: EdgeInsets.only(right: 4),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Container(
                                                      child: BlocBuilder(
                                                        bloc: teamSelectionBloc,
                                                        builder: (context, TeamSelectionBlocState state) {
                                                          return Text(
                                                            '${teamController.team1ShortName}',
                                                            textAlign: TextAlign.start,
                                                            style: TextStyle(
                                                              fontFamily: 'Poppins',
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.white,
                                                              fontSize: MediaQuery.of(context).size.width >= 360 ? AppConstant.SIZE_TITLE18 : AppConstant.SIZE_TITLE16,
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    GetBuilder<TeamController>(builder: (cont) {
                                                      return Container(
                                                        child: Text(
                                                          '${teamController.teamASelecttedPlayer.length}',
                                                          style: TextStyle(
                                                            fontFamily: 'Poppins',
                                                            color: Colors.white,
                                                            fontSize: MediaQuery.of(context).size.width >= 360 ? AppConstant.SIZE_TITLE16 : AppConstant.SIZE_TITLE14,
                                                          ),
                                                        ),
                                                      );
                                                    })
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 50,
                                              height: 50,
                                              child: ClipOval(
                                                  child: Image.network(
                                                'https://dream11.tennisworldxi.com/storage/app/${teamController.team1Flag}',
                                                fit: BoxFit.cover,
                                              )),
                                            ),
                                            Container(
                                              width: 16,
                                            ),
                                            Container(
                                              width: 50,
                                              height: 50,
                                              child: ClipOval(
                                                  child: Image.network(
                                                'https://dream11.tennisworldxi.com/storage/app/${teamController.team2Flag}',
                                                fit: BoxFit.cover,
                                              )),
                                            ),
                                            Expanded(
                                              child: Container(
                                                padding: EdgeInsets.only(left: 4),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Container(
                                                      child: BlocBuilder(
                                                        bloc: teamSelectionBloc,
                                                        builder: (context, TeamSelectionBlocState state) {
                                                          return Text(
                                                            '${teamController.team2ShortName}',
                                                            textAlign: TextAlign.start,
                                                            style: TextStyle(
                                                              fontFamily: 'Poppins',
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.white,
                                                              fontSize: MediaQuery.of(context).size.width >= 360 ? AppConstant.SIZE_TITLE18 : AppConstant.SIZE_TITLE16,
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    GetBuilder<TeamController>(builder: (cont) {
                                                      return Container(
                                                        child: Text(
                                                          '${cont.teamBSelecttedPlayer.length}',
                                                          style: TextStyle(
                                                            fontFamily: 'Poppins',
                                                            color: Colors.white,
                                                            fontSize: MediaQuery.of(context).size.width >= 360 ? AppConstant.SIZE_TITLE16 : AppConstant.SIZE_TITLE14,
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
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width >= 360 ? 75 : 65,
                                    padding: EdgeInsets.all(4),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            'Credits Left',
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              color: Colors.white54,
                                              fontSize: MediaQuery.of(context).size.width >= 360 ? AppConstant.SIZE_TITLE12 : AppConstant.SIZE_TITLE10,
                                            ),
                                          ),
                                        ),
                                        GetBuilder<TeamController>(builder: (controller) {
                                          return Container(
                                            child: Text(
                                              '${100.0 - controller.team_credits}',
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: MediaQuery.of(context).size.width >= 360 ? AppConstant.SIZE_TITLE20 : AppConstant.SIZE_TITLE18,
                                              ),
                                            ),
                                          );
                                        })
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                height: 40,
                                width: double.infinity,
                                padding: EdgeInsets.all(8),
                                child: GetBuilder<TeamController>(
                                  builder: (controller) {
                                    final playesCount = controller.getSelectedPlayerCount();
                                    return CreateTeamProgressbarView(
                                      teamCount: playesCount,
                                    );
                                  },
                                )),
                            SizedBox(
                              height: 4,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 40,
                        child: BlocBuilder(
                          bloc: teamSelectionBloc,
                          builder: (context, TeamSelectionBlocState state) {
                            return TabBar(
                              isScrollable: true,
                              indicatorWeight: 3,
                              controller: tabController,
                              unselectedLabelColor: AllCoustomTheme.getTextThemeColors(),
                              indicatorColor: AllCoustomTheme.getThemeData().primaryColor,
                              labelColor: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                              tabs: <Widget>[
                                TabTextView(
                                  tabTextType: TabTextType.wk,
                                  count: teamSelectionBloc.getSelectedPlayerCount(wk: TabTextType.wk),
                                  isSelected: selectedIndex == 0 ? true : false,
                                ),
                                TabTextView(
                                  tabTextType: TabTextType.bat,
                                  count: teamSelectionBloc.getSelectedPlayerCount(wk: TabTextType.bat),
                                  isSelected: selectedIndex == 1 ? true : false,
                                ),
                                TabTextView(
                                  tabTextType: TabTextType.ar,
                                  count: teamSelectionBloc.getSelectedPlayerCount(wk: TabTextType.ar),
                                  isSelected: selectedIndex == 2 ? true : false,
                                ),
                                TabTextView(
                                  tabTextType: TabTextType.bowl,
                                  count: teamSelectionBloc.getSelectedPlayerCount(wk: TabTextType.bowl),
                                  isSelected: selectedIndex == 3 ? true : false,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      Flexible(
                        child: ModalProgressHUD(
                          inAsyncCall: isLoginProsses,
                          color: Colors.transparent,
                          progressIndicator: CircularProgressIndicator(
                            strokeWidth: 2.0,
                          ),
                          child: BlocBuilder(
                            bloc: teamSelectionBloc,
                            builder: (context, TeamSelectionBlocState state) {
                              return TabBarView(
                                physics: BouncingScrollPhysics(
                                  parent: PageScrollPhysics(),
                                ),
                                controller: tabController,
                                children: <Widget>[
                                  TeamSelectionList(players: teamSelectionBloc.getTypeList(TabTextType.wk), tabType: TabTextType.wk),
                                  TeamSelectionList(players: teamSelectionBloc.getTypeList(TabTextType.bat), tabType: TabTextType.bat),
                                  TeamSelectionList(players: teamSelectionBloc.getTypeList(TabTextType.ar), tabType: TabTextType.ar),
                                  TeamSelectionList(players: teamSelectionBloc.getTypeList(TabTextType.bowl), tabType: TabTextType.bowl),
                                ],
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
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
                                  onTap: () async {
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
                          Expanded(child: GetBuilder<TeamController>(
                            builder: (cont) {
                              return Opacity(
                                opacity: cont.selectedPlayers.length == 11 &&
                                        cont.teamASelecttedPlayer.length >= 4 &&
                                        cont.teamASelecttedPlayer.length <= 7 &&
                                        cont.teamBSelecttedPlayer.length >= 4 &&
                                        cont.teamBSelecttedPlayer.length <= 7 &&
                                        cont.select_wicketKiperList.length >= 1 &&
                                        cont.select_batterList.length >= 3 &&
                                        cont.select_allRounderList.length >= 1 &&
                                        cont.select_bowlerList.length >= 3
                                    ? 1.0
                                    : 0.2,
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
                                      onTap: () {
                                        if (teamController.select_wicketKiperList.length >= 1 &&
                                            teamController.select_batterList.length >= 3 &&
                                            teamController.select_allRounderList.length >= 1 &&
                                            teamController.select_bowlerList.length >= 3 &&
                                            teamController.selectedPlayers.length == 11) {
                                          teamSelectionBloc.refreshCAndVC();
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ChooseCVCScreen(),
                                            ),
                                          );
                                        }
                                      },
                                      child: Center(
                                        child: Text(
                                          'CONTINUE',
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
                              );
                            },
                          )),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//TabTextView
class TabTextView extends StatelessWidget {
  final TabTextType? tabTextType;
  final bool? isSelected;
  final int? count;

  const TabTextView({
    Key? key,
    this.tabTextType,
    this.count = 0,
    this.isSelected = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              child: Text(
                tabTextType == TabTextType.wk
                    ? "WK"
                    : tabTextType == TabTextType.bat
                        ? "BAT"
                        : tabTextType == TabTextType.ar
                            ? "AR"
                            : tabTextType == TabTextType.bowl
                                ? "BOWL"
                                : '',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  color: isSelected! ? AllCoustomTheme.getBlackAndWhiteThemeColors() : AllCoustomTheme.getTextThemeColors(),
                  fontSize: AppConstant.SIZE_TITLE14,
                ),
              ),
            ),
            GetBuilder<TeamController>(builder: (con) {
              return Container(
                padding: EdgeInsets.only(bottom: 2),
                child: Text(
                  tabTextType == TabTextType.wk
                      ? "(${con.select_wicketKiperList.length})"
                      : tabTextType == TabTextType.bat
                          ? "(${con.select_batterList.length})"
                          : tabTextType == TabTextType.ar
                              ? "(${con.select_allRounderList.length})"
                              : tabTextType == TabTextType.bowl
                                  ? "(${con.select_bowlerList.length})"
                                  : '',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    color: isSelected! ? AllCoustomTheme.getBlackAndWhiteThemeColors() : AllCoustomTheme.getTextThemeColors(),
                    fontSize: AppConstant.SIZE_TITLE10,
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}

///team selection list

class TeamSelectionList extends StatefulWidget {
  final List<Players>? players;
  final TabTextType? tabType;
  final ShedualData? shedualData;

  const TeamSelectionList({Key? key, this.players, this.tabType, this.shedualData}) : super(key: key);
  @override
  _TeamSelectionListState createState() => _TeamSelectionListState();
}

class _TeamSelectionListState extends State<TeamSelectionList> {
  var messageList = <String>[];
  var animationType = AnimationType.isRegular;
  @override
  void initState() {
    teamTapBloc.setType(AnimationType.isRegular);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          new Container(
            height: 40,
            child: Container(
              height: 40,
              width: double.infinity,
              color: AllCoustomTheme.getThemeData().scaffoldBackgroundColor,
              child: Container(
                child: Center(
                  child: BlocBuilder(
                    bloc: teamTapBloc,
                    builder: (context, TeamTapBlocState teamTapBlocstate) {
                      animationType = teamTapBlocstate.animationType!;
                      return BlocBuilder(
                        bloc: teamSelectionBloc,
                        builder: (context, TeamSelectionBlocState state) {
                          return GetBuilder<TeamController>(builder: (con) {
                            return Text(
                              widget.tabType == TabTextType.bat && con.select_wicketKiperList.length < 1
                                  ? 'You must pick at least 1 Wicket-Keeper'
                                  : widget.tabType == TabTextType.ar && con.select_batterList.length < 3
                                      ? 'You must pick at least 3 Batsmen.'
                                      : widget.tabType == TabTextType.bowl && con.select_allRounderList.length < 1
                                          ? 'You must pick at least 1 All-Rounder.'
                                          : con.selectedPlayers.length == 11 && con.select_bowlerList.length < 3
                                              ? 'You must pick at least 3 bowlers.'
                                              : con.teamASelecttedPlayer.length == 7 && con.select_bowlerList.length >= 3 && con.select_allRounderList.length >= 1 && con.select_batterList.length >= 3
                                                  ? 'You can pick max 7 Players.'
                                                  : con.teamBSelecttedPlayer.length == 7 &&
                                                          con.select_bowlerList.length >= 3 &&
                                                          con.select_allRounderList.length >= 1 &&
                                                          con.select_batterList.length >= 3
                                                      ? 'You can pick max 7 Players.'
                                                      : con.selectedPlayers.length == 11
                                                          ? con.teamASelecttedPlayer.length < 4
                                                              ? 'You must pick at least 4 Players.'
                                                              : con.teamBSelecttedPlayer.length < 4
                                                                  ? 'You must pick at least 4 Players.'
                                                                  : '11 players selected, tap continue'
                                                          : getValideTxt(widget.tabType!),
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                                fontSize: AppConstant.SIZE_TITLE14,
                              ),
                            );
                          });
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 36,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 15),
                        child: Center(
                          child: Text(
                            'PLAYERS',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              color: AllCoustomTheme.getTextThemeColors(),
                              fontSize: AppConstant.SIZE_TITLE12,
                            ),
                          ),
                        ),
                      ),
                      Expanded(child: Container()),
                      Container(
                        width: 80,
                        child: Center(
                            // child: Text(
                            //   'POINTS',
                            //   style: TextStyle(
                            //     fontFamily: 'Poppins',
                            //     fontWeight: FontWeight.bold,
                            //     color: AllCoustomTheme.getTextThemeColors(),
                            //     fontSize: AppConstant.SIZE_TITLE12,
                            //   ),
                            // ),
                            ),
                      ),
                      BlocBuilder(
                        bloc: teamSelectionBloc,
                        builder: (context, TeamSelectionBlocState state) {
                          return InkWell(
                            onTap: () {
                              // teamSelectionBloc.setAssendingAndDesandingList();
                            },
                            child: Container(
                              width: 70,
                              child: Center(
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      'CREDITS',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold,
                                        color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                                        fontSize: AppConstant.SIZE_TITLE12,
                                      ),
                                    ),
                                    // Icon(
                                    //   state.assending! ? Icons.arrow_upward : Icons.arrow_downward,
                                    //   size: 20,
                                    //   color: AllCoustomTheme.getThemeData().primaryColor,
                                    // )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      Container(
                        width: 30,
                      )
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                )
              ],
            ),
          ),
          GetBuilder<TeamController>(
            builder: ((controller) {
              return Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(bottom: 100),
                  physics: BouncingScrollPhysics(),
                  itemCount: widget.tabType == TabTextType.wk
                      ? controller.wicketKiperList.length
                      : widget.tabType == TabTextType.bat
                          ? controller.batterList.length
                          : widget.tabType == TabTextType.bowl
                              ? controller.bowlerList.length
                              : controller.allRounderList.length,
                  itemBuilder: (context, index) {
                    return widget.tabType == TabTextType.wk
                        ? PlayerViewItem(
                            player: controller.wicketKiperList[index],
                            playerIndex: controller.allPlayersData.indexOf(controller.wicketKiperList[index]),
                          )
                        : widget.tabType == TabTextType.bat
                            ? PlayerViewItem(
                                player: controller.batterList[index],
                                playerIndex: controller.allPlayersData.indexOf(controller.batterList[index]),
                              )
                            : widget.tabType == TabTextType.bowl
                                ? PlayerViewItem(
                                    player: controller.bowlerList[index],
                                    playerIndex: controller.allPlayersData.indexOf(controller.bowlerList[index]),
                                  )
                                : PlayerViewItem(
                                    player: controller.allRounderList[index],
                                    playerIndex: controller.allPlayersData.indexOf(controller.allRounderList[index]),
                                  );
                  },
                ),
              );
            }),
          )
        ],
      ),
    );
  }

  String getValideTxt(TabTextType type) {
    var txt = '';
    if (animationType == AnimationType.isRegular) {
      if (TabTextType.wk == type) {
        txt = 'Pick 1 - 4 Wicket-Keeper';
      } else if (TabTextType.bat == type) {
        txt = 'Pick 3 - 6 Batsmen';
      } else if (TabTextType.ar == type) {
        txt = 'Pick 1 - 4 All-Rounders';
      } else if (TabTextType.bowl == type) {
        txt = 'Pick 3 - 6 Bowlers';
      }
    } else if (animationType == AnimationType.isMinimum) {
      if (TabTextType.wk == type) {
        txt = 'You can pick only 1 Wicket-Keeper.';
      } else if (TabTextType.bat == type) {
        txt = 'You can pick only 5 Batsmen.';
      } else if (TabTextType.ar == type) {
        txt = 'You can pick only 3 All-Rounders.';
      } else if (TabTextType.bowl == type) {
        txt = 'You can pick only 5 Bowlers.';
      }
    } else if (animationType == AnimationType.isFull) {
      txt = '11 players selected, tap continue.';
    } else if (animationType == AnimationType.isSeven) {
      txt = 'You can pick only 7 from each team.';
    } else if (animationType == AnimationType.isCredits) {
      txt = 'Not enough creadits to pick this player.';
    } else if (animationType == AnimationType.atLeast) {
      final isValidMini = teamSelectionBloc.validMinErrorRequirement();
      if (isValidMini != null) {
        if (TabTextType.wk == isValidMini) {
          txt = 'You must pick at least 1 Wicket-Keeper.';
        } else if (TabTextType.bat == isValidMini) {
          txt = 'You must pick at least 3 Batsmen.';
        } else if (TabTextType.ar == isValidMini) {
          txt = 'You must pick at least 1 All-Rounders.';
        } else if (TabTextType.bowl == isValidMini) {
          txt = 'You must pick at least 3 Bowlers.';
        }
      }
    }
    return txt;
  }
}

//playersListUI

class PlayerslistUI extends StatelessWidget {
  final Players player;
  final ShedualData? shedualData;
  const PlayerslistUI({Key? key, required this.player, required this.shedualData}) : super(key: key);
  bool isValidMiniMach(TabTextType t, List<TabTextType> tlist) {
    bool isMach = false;
    tlist.forEach((type) {
      if (t == type) {
        isMach = true;
        return;
      }
    });
    return isMach;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: teamSelectionBloc,
      builder: (context, TeamSelectionBlocState state) {
        var isDisabled = false;
        final validCredites = teamSelectionBloc.getTotalSelctedPlayerRating();
        final is7Player = teamSelectionBloc.getMax7PlayesCount(player);
        final isValid = teamSelectionBloc.isDisabled(player.pid!);
        final is11Player = teamSelectionBloc.getSelectedPlayerCount();
        final isValidMini = teamSelectionBloc.validMinErrorRequirement();
        if ((100.0 - validCredites) < player.fantasyPlayerRating! && !player.isSelcted!) {
          isDisabled = true;
          print('WK');
        }
        if (is7Player == 7 && !player.isSelcted!) {
          isDisabled = true;
          print('max 7');
        }
        if (is11Player == 11 && !player.isSelcted!) {
          isDisabled = true;
          print('max 11');
        }
        if (isValid && !player.isSelcted!) {
          isDisabled = true;
          print('max isValid');
        }
        if (isValidMini != null && !player.isSelcted!) {
          if (isValidMini != teamSelectionBloc.getTypeTextEnum(player.playingRole!)) {
            if (!isValidMiniMach(teamSelectionBloc.getTypeTextEnum(player.playingRole!)!, teamSelectionBloc.validMinErrorRequirementList())) {
              isDisabled = true;
              print('both if');
            }
          }
        }
        return Opacity(
          opacity: isDisabled ? 0.5 : 1.0,
          child: Container(
            height: 60,
            color: player.isSelcted! ? AllCoustomTheme.getThemeData().primaryColor.withOpacity(0.4) : AllCoustomTheme.getThemeData().backgroundColor,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: new BorderRadius.circular(0.0),
                onTap: () async {
                  if (!isDisabled) {
                    teamSelectionBloc.setPlaySelect(player.pid!);
                  } else {
                    bool isatlest = false;
                    bool isMinimum = false;
                    if (isValidMini != null && !player.isSelcted!) {
                      if (isValidMini != teamSelectionBloc.getTypeTextEnum(player.playingRole!)) {
                        if (!isValidMiniMach(teamSelectionBloc.getTypeTextEnum(player.playingRole!)!, teamSelectionBloc.validMinErrorRequirementList())) {
                          isatlest = true;
                        }
                      }
                    }
                    if (isValid && !player.isSelcted!) {
                      isMinimum = true;
                    }
                    if (isatlest && isMinimum) {
                      teamTapBloc.setType(AnimationType.atLeast);
                    } else {
                      if (isValidMini != null && !player.isSelcted!) {
                        teamTapBloc.setType(AnimationType.atLeast);
                      }
                      if (isValid && !player.isSelcted!) {
                        teamTapBloc.setType(AnimationType.isMinimum);
                      }
                    }
                    if (is7Player == 7 && !player.isSelcted!) {
                      teamTapBloc.setType(AnimationType.isSeven);
                    }
                    if ((100.0 - validCredites) < player.fantasyPlayerRating! && !player.isSelcted!) {
                      teamTapBloc.setType(AnimationType.isCredits);
                    }
                    if (is11Player == 11 && !player.isSelcted!) {
                      teamTapBloc.setType(AnimationType.isFull);
                    }
                  }
                },
                onLongPress: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => PlayerProfileScreen(
                  //       shedualData: shedualData,
                  //       player: player,
                  //       isChoose: true,
                  //     ),
                  //     fullscreenDialog: true,
                  //   ),
                  // );
                },
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 2),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PlayerProfileScreen(
                                      shedualData: shedualData,
                                      player: player,
                                      isChoose: true,
                                    ),
                                    fullscreenDialog: true,
                                  ),
                                );
                              },
                              child: Container(
                                width: 50,
                                height: 50,
                                child: AvatarImage(
                                  isProgressPrimaryColor: true,
                                  isCircle: true,
                                  isAssets: true,
                                  imageUrl: 'assets/cname/${player.pid}.png',
                                  radius: 50,
                                  sizeValue: 50,
                                ),
                              ),
                            ),
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
                                      '${player.title}',
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
                                      '${player.teamName} - ${player.playingRole!.toUpperCase()}',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: AllCoustomTheme.getTextThemeColors(),
                                        fontSize: AppConstant.SIZE_TITLE10,
                                      ),
                                    ),
                                  ),
                                  player.playing11 != ''
                                      ? Container(
                                          padding: EdgeInsets.only(top: 4),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                width: 6,
                                                height: 6,
                                                decoration: BoxDecoration(
                                                    color: player.playing11 == 'true'
                                                        ? Colors.green
                                                        : player.playing11 == 'false'
                                                            ? Colors.red
                                                            : AllCoustomTheme.getTextThemeColors(),
                                                    shape: BoxShape.circle),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(left: 4),
                                                child: Text(
                                                  player.playing11 == 'true'
                                                      ? 'Playing'
                                                      : player.playing11 == 'false'
                                                          ? 'Not Playing'
                                                          : "",
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      color: player.playing11 == 'true'
                                                          ? Colors.green
                                                          : player.playing11 == 'false'
                                                              ? Colors.red
                                                              : AllCoustomTheme.getTextThemeColors(),
                                                      fontSize: AppConstant.SIZE_TITLE10,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : SizedBox()
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 100,
                            child: Center(
                              child: Text(
                                '${player.point}',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: AllCoustomTheme.getTextThemeColors(),
                                  fontSize: AppConstant.SIZE_TITLE12,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 40,
                            child: Text(
                              '${player.fantasyPlayerRating}',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                                fontSize: AppConstant.SIZE_TITLE12,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 8, bottom: 8),
                            width: 0.4,
                            child: Container(
                              color: AllCoustomTheme.getTextThemeColors().withOpacity(0.5),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(right: 8),
                            child: Center(
                              child: Container(
                                width: 40,
                                child: Icon(
                                  player.isSelcted! ? Icons.close : Icons.add,
                                  color: player.isSelcted! ? Colors.red : Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
