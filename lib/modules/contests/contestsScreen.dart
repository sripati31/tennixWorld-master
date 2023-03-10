// ignore_for_file: deprecated_member_use, unnecessary_null_comparison

import 'dart:core';
import 'dart:ui';
import 'package:TennixWorldXI/GetxController/teamController.dart';
import 'package:TennixWorldXI/main.dart';
import 'package:TennixWorldXI/models/contest_list_model.dart';
import 'package:TennixWorldXI/modules/contests/entre_referal_discount.dart';
import 'package:TennixWorldXI/modules/contests/join_user_contest.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:TennixWorldXI/constant/constants.dart';
import 'package:TennixWorldXI/constant/themes.dart';
import 'package:TennixWorldXI/models/contestsResponseData.dart';
import 'package:TennixWorldXI/modules/contests/contestCodeScreen.dart';
import 'package:TennixWorldXI/modules/contests/createContest.dart';
import 'package:TennixWorldXI/modules/contests/createTeamButtonView.dart';
import 'package:TennixWorldXI/modules/createTeam/createTeamScreen.dart';
import 'package:TennixWorldXI/validator/validator.dart';
import 'package:sticky_headers/sticky_headers.dart';
import '../../api/Api_Handler/api_call_Structure.dart';
import '../../api/Api_Handler/api_constants.dart';
import '../../api/Api_Handler/api_error_response.dart';
import '../../utils/toast.dart';
import 'insideContest.dart';

class ContestsScreen extends StatefulWidget {
  final String? titel;
  final String? country1Name;
  final String? country1Flag;
  final String? country2Name;
  final String? country2Flag;
  final String? time;
  final String? price;
  final int? matchID;
  final String? country1FullName;
  final String? country2FullName;

  const ContestsScreen({
    Key? key,
    this.titel,
    this.country1Name,
    this.country1Flag,
    this.country2Name,
    this.country2Flag,
    this.time,
    this.price,
    this.matchID,
    this.country1FullName,
    this.country2FullName,
  }) : super(key: key);
  @override
  _ContestsScreenState createState() => _ContestsScreenState();
}

class _ContestsScreenState extends State<ContestsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool iscontestsProsses = false;
  var categoryList = ContestsLeagueResponseData();
  bool tab1 = true;
  bool tab2 = false;
  bool tab3 = false;
  bool isLoading = true;
  bool isTeamSelect = false;
  var teamController = Get.find<TeamController>();
  @override
  void initState() {
    categoryList.contestsCategoryLeagueListData = <ContestsLeagueCategoryListResponseData>[];
    categoryList.teamlist = [];
    categoryList.totalcontest = 0;
    super.initState();
    teamController.getAllUserTeams();
    teamController.getContestList().then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
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
                                        child: Text(
                                          widget.titel!,
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Expanded(child: SizedBox()),
                                      Image.asset(
                                        AppConstant.wallet,
                                        height: 22,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            child: ModalProgressHUD(
                              inAsyncCall: iscontestsProsses,
                              color: Colors.transparent,
                              progressIndicator: CircularProgressIndicator(
                                strokeWidth: 2.0,
                              ),
                              child: Container(
                                child: contestsListData(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        !tab2
            ? Padding(
                padding: const EdgeInsets.only(bottom: 70),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateTeamScreen(),
                            fullscreenDialog: true,
                          ),
                        );
                      },
                      child: Text('create team'.toUpperCase()),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
                      ),
                    ),
                    Opacity(
                      opacity: 1.0,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(TeamList());
                        },
                        child: Text('Join Contest'.toUpperCase()),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
                        ),
                      ),
                    )
                  ],
                ),
              )
            : SizedBox()
      ],
    );
  }

  void showInSnackBar(String value, {bool isGreeen = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      new SnackBar(
        content: new Text(
          value,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: AppConstant.SIZE_TITLE14,
            color: AllCoustomTheme.getReBlackAndWhiteThemeColors(),
          ),
        ),
        backgroundColor: isGreeen ? Colors.green : Colors.red,
      ),
    );
  }

  Widget contestsListData() {
    return Column(
      children: <Widget>[
        Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      tab1 = true;
                      tab2 = false;
                      // tab3 = false;
                    });
                  },
                  child: Column(
                    children: [
                      Text(
                        "Contest",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: AppConstant.SIZE_TITLE16,
                          color: tab1 ? AllCoustomTheme.getThemeData().primaryColor : AllCoustomTheme.getTextThemeColors(),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 2,
                        width: 80,
                        color: tab1 ? AllCoustomTheme.getThemeData().primaryColor : AllCoustomTheme.getThemeData().backgroundColor,
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      tab1 = false;
                      tab2 = true;
                      // tab3 = false;
                    });
                  },
                  child: Column(
                    children: [
                      Text(
                        "My contest",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: AppConstant.SIZE_TITLE16,
                          color: tab2 ? AllCoustomTheme.getThemeData().primaryColor : AllCoustomTheme.getTextThemeColors(),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 2,
                        width: 80,
                        color: tab2 ? AllCoustomTheme.getThemeData().primaryColor : AllCoustomTheme.getThemeData().backgroundColor,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        tab1
            ? Expanded(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InsideContest(),
                                fullscreenDialog: false,
                              ),
                            );
                          },
                          child: StickyHeader(
                              header: new Container(
                                height: MediaQuery.of(context).size.height * 0.20,
                                color: AllCoustomTheme.getThemeData().scaffoldBackgroundColor,
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: 4,
                                    bottom: 6,
                                    left: MediaQuery.of(context).size.width * 0.03,
                                    right: MediaQuery.of(context).size.width * 0.03,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Text(
                                        '${widget.titel}',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: MediaQuery.of(context).size.height * 0.14,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${widget.country1FullName}'.toUpperCase(),
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color: AllCoustomTheme.getThemeData().primaryColor,
                                                    fontSize: AppConstant.SIZE_TITLE12,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      width: 50,
                                                      height: 50,
                                                      child: ClipOval(
                                                        child: Image.network(
                                                          widget.country1Flag!,
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.only(left: 8, right: 8),
                                                      child: Text(
                                                        widget.country1Name!.toUpperCase(),
                                                        textAlign: TextAlign.start,
                                                        style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                          fontWeight: FontWeight.bold,
                                                          color: AllCoustomTheme.getThemeData().primaryColor,
                                                          fontSize: AppConstant.SIZE_TITLE12,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      '20 Lac',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '1h 34 min',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: AppConstant.SIZE_TITLE16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Theme.of(context).primaryColor,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: MediaQuery.of(context).size.height * 0.03,
                                                )
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.020),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    '${widget.country2FullName}'.toUpperCase(),
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      color: AllCoustomTheme.getThemeData().primaryColor,
                                                      fontSize: AppConstant.SIZE_TITLE12,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        padding: EdgeInsets.only(left: 8, right: 8),
                                                        child: Text(
                                                          widget.country2Name!,
                                                          textAlign: TextAlign.start,
                                                          style: TextStyle(
                                                            fontFamily: 'Poppins',
                                                            fontWeight: FontWeight.bold,
                                                            color: AllCoustomTheme.getThemeData().primaryColor,
                                                            fontSize: AppConstant.SIZE_TITLE12,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 50,
                                                        height: 50,
                                                        child: ClipOval(
                                                          child: Image.network(
                                                            widget.country2Flag!,
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    width: MediaQuery.of(context).size.width * 0.12,
                                                    height: MediaQuery.of(context).size.height * 0.01,
                                                    child: Icon(Icons.live_tv),
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
                              ),
                              content: Padding(
                                padding: const EdgeInsets.only(left: 8, right: 8, top: 6, bottom: 100),
                                child: SizedBox(
                                    height: 600,
                                    child: isLoading
                                        ? Column(
                                            children: [
                                              Center(
                                                child: CircularProgressIndicator(
                                                  color: AllCoustomTheme.getThemeData().primaryColor,
                                                ),
                                              ),
                                            ],
                                          )
                                        : ListView.builder(
                                            itemCount: teamController.contestListModel.length,
                                            itemBuilder: (context, index) {
                                              return contestnt(
                                                teamController.contestListModel[index].prizePool.toString(),
                                                teamController.contestListModel[index].entryFee.toString(),
                                                teamController.contestListModel[index].totalSpot.toString(),
                                                teamController.contestListModel[index].currentSpot.toString(),
                                                teamController.contestListModel[index].noOfWinner.toString(),
                                                0.1,
                                                teamController.contestListModel[index].id,
                                              );
                                            })),
                              )),
                        );
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 140, left: 16, right: 16),
                      child: Container(
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                decoration: new BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: new BorderRadius.circular(20),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(color: AllCoustomTheme.getThemeData().primaryColor.withOpacity(0.5), offset: Offset(0, 1), blurRadius: 5.0),
                                  ],
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    splashColor: AllCoustomTheme.getThemeData().primaryColor.withOpacity(0.4),
                                    borderRadius: new BorderRadius.circular(20),
                                    onTap: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ContestCodeScreen(),
                                          fullscreenDialog: true,
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(left: 8, right: 8),
                                      child: Center(
                                        child: Text(
                                          'Enter Contest Code',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.bold,
                                            color: AllCoustomTheme.getThemeData().primaryColor,
                                            fontSize: AppConstant.SIZE_TITLE10,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Container(
                                decoration: new BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: new BorderRadius.circular(20),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(color: AllCoustomTheme.getThemeData().primaryColor.withOpacity(0.5), offset: Offset(0, 1), blurRadius: 5.0),
                                  ],
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    splashColor: AllCoustomTheme.getThemeData().primaryColor.withOpacity(0.4),
                                    borderRadius: new BorderRadius.circular(20),
                                    onTap: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CreateContestScreen(
                                            country1Flag: widget.country1Flag!,
                                            country2Flag: widget.country2Flag!,
                                            country1Name: widget.country1Name!,
                                            country2Name: widget.country2Name!,
                                            price: widget.price!,
                                            time: widget.time!,
                                            titel: widget.titel!,
                                          ),
                                          fullscreenDialog: true,
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(left: 8, right: 8),
                                      child: Center(
                                        child: Text(
                                          'Create a Contest',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.bold,
                                            color: AllCoustomTheme.getThemeData().primaryColor,
                                            fontSize: AppConstant.SIZE_TITLE10,
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
                    ),
                  ],
                ),
              )
            : tab2
                ? teamController.contestListModel.length != 0
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: ListView.builder(
                              itemCount: teamController.contestListModel.length,
                              itemBuilder: (context, index) {
                                return contestnt(
                                  teamController.contestListModel[index].prizePool.toString(),
                                  teamController.contestListModel[index].entryFee.toString(),
                                  teamController.contestListModel[index].totalSpot.toString(),
                                  teamController.contestListModel[index].currentSpot.toString(),
                                  teamController.contestListModel[index].noOfWinner.toString(),
                                  0.1,
                                  teamController.contestListModel[index].id,
                                );
                              }),
                        ),
                      )
                    : Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'You have not joined a contest yet!',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              color: AllCoustomTheme.getTextThemeColors(),
                              fontSize: AppConstant.SIZE_TITLE14,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Image.asset(
                            AppConstant.g1,
                            fit: BoxFit.cover,
                            height: 200,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            'What are you waiting for',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              color: AllCoustomTheme.getTextThemeColors(),
                              fontSize: AppConstant.SIZE_TITLE14,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            height: 50,
                            padding: EdgeInsets.only(left: 50, right: 50, bottom: 8),
                            child: Row(
                              children: <Widget>[
                                Flexible(
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
                                          Get.to(JoinUserContest());
                                        },
                                        child: Center(
                                          child: Text(
                                            'JOIN CONTEST',
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
                              ],
                            ),
                          ),
                        ],
                      )
                : SizedBox(),
      ],
    );
  }

  Widget contestnt(
    String prizPool,
    String entryFee,
    String totalSpot,
    String currentSpot,
    String winnerNo,
    double progress,
    var contest_id,
  ) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InsideContest(),
          fullscreenDialog: false,
        ),
      ),
      child: Card(
        margin: EdgeInsets.only(bottom: 8),
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Prize Pool',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: AllCoustomTheme.getTextThemeColors(),
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        prizPool,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '${teamController.team1ShortName}',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(' vs ', style: TextStyle(fontSize: 18, color: Colors.grey)),
                      Text('${teamController.team2ShortName}',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'Lineup',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Text(
                          'Entry',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: AllCoustomTheme.getTextThemeColors(),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        children: [
                          winnerNo != '1'
                              ? Text('')
                              : InkWell(
                                  onTap: () {
                                    setshowDialog();
                                  },
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 14, top: 4, bottom: 4),
                                      child: Text(
                                        '₹600',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.lineThrough,
                                          decorationThickness: 4.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                          InkWell(
                            onTap: () {
                              setshowDialog();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 14, left: 14, top: 4, bottom: 4),
                                child: Text(
                                  entryFee,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Theme.of(context).canvasColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 4,
            ),
            LinearPercentIndicator(
              lineHeight: 6,
              percent: progress,
              linearStrokeCap: LinearStrokeCap.roundAll,
              backgroundColor: AllCoustomTheme.getThemeData().scaffoldBackgroundColor,
              progressColor: AllCoustomTheme.getThemeData().primaryColor,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Text(
                    currentSpot + ' spot left',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      color: Colors.orange[400],
                    ),
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                  Text(
                    totalSpot + ' total spot',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      color: Colors.orange[400],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: AllCoustomTheme.isLight ? HexColor("#f5f5f5") : Theme.of(context).disabledColor.withOpacity(0.1),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 100,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(ReferalDiscount());
                      },
                      child: Container(
                        width: 100,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'Get Discount',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Image.asset(
                      AppConstant.guaranteed,
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> setshowDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                'CONFIRMATION',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  color: AllCoustomTheme.getThemeData().primaryColor,
                                  fontSize: AppConstant.SIZE_TITLE18,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Container(
                              child: Text(
                                'Unutilized Balance + Winning = ₹1000',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  color: AllCoustomTheme.getTextThemeColors(),
                                  fontSize: AppConstant.SIZE_TITLE12,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          child: Icon(Icons.close),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Text(
                          'Entry',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                            fontSize: AppConstant.SIZE_TITLE14,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          '₹575',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: AllCoustomTheme.getThemeData().primaryColor,
                            fontSize: AppConstant.SIZE_TITLE14,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Text(
                          'Usable Cash Bonus',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                            fontSize: AppConstant.SIZE_TITLE14,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          '-₹0',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: AllCoustomTheme.getThemeData().primaryColor,
                            fontSize: AppConstant.SIZE_TITLE14,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                ),
                Container(
                  padding: const EdgeInsets.only(top: 8, left: 16.0, right: 16, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Text(
                          'To Pay',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontSize: AppConstant.SIZE_TITLE14,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          '₹575',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontSize: AppConstant.SIZE_TITLE14,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Container(
                  height: 40,
                  padding: EdgeInsets.only(left: 50, right: 50, bottom: 8),
                  child: Row(
                    children: <Widget>[
                      Flexible(
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
                                Navigator.pop(context);
                              },
                              child: Center(
                                child: Text(
                                  'JOIN CONTEST',
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
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 16.0, right: 16, bottom: 20),
                  child: Text(
                    "By joining this contest, you accept FansyApp's T&C.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      color: AllCoustomTheme.getTextThemeColors().withOpacity(0.5),
                      fontSize: AppConstant.SIZE_TITLE12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void setSoCloseContestFilled(String price, String leagueId) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => soCloseFilledPopup(price, leagueId),
    );
  }

  Widget soCloseFilledPopup(String price, String leagueId) {
    ContestsLeagueListData leageData = new ContestsLeagueListData();
    categoryList.contestsCategoryLeagueListData!.forEach((category) {
      category.contestsCategoryLeagueListData!.forEach((list) {
        if (int.tryParse('${list.remainingTeam}') != 0) {
          if (int.tryParse('${list.entryFees}') == int.tryParse('$price') && list.leagueId != leagueId) {
            leageData = list;
            return;
          }
        }
      });
    });
    if (leageData == null) {
      categoryList.contestsCategoryLeagueListData!.forEach((category) {
        category.contestsCategoryLeagueListData!.forEach((list) {
          if (int.tryParse('${list.remainingTeam}') != 0) {
            int? aa = int.tryParse('$price');
            if (int.tryParse('${list.entryFees}')! <= aa! && list.leagueId != leagueId) {
              leageData = list;
              return;
            }
          }
        });
      });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 16, top: 8, bottom: 8, right: 16),
          color: Colors.white,
          child: Text(
            'So close! That contest filled up',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: AppConstant.SIZE_TITLE20,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 16, bottom: 8, right: 16),
          color: Colors.white,
          child: Text(
            "No worries, join this contest instead! It's exactly the same type",
            style: TextStyle(
              fontFamily: 'Poppins',
              color: AllCoustomTheme.getBlackAndWhiteThemeColors().withOpacity(0.6),
              fontWeight: FontWeight.bold,
              fontSize: AppConstant.SIZE_TITLE14,
            ),
          ),
        ),
        Divider(
          height: 1,
        ),
        Container(
          padding: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 8),
                      color: Colors.white,
                      child: Text(
                        'Prize Pool'.toUpperCase(),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: AllCoustomTheme.getTextThemeColors(),
                          fontSize: AppConstant.SIZE_TITLE12,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8, top: 4),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 12,
                            height: 12,
                            padding: EdgeInsets.only(top: 1.5),
                            child: Image.asset(AppConstant.ruppeIcon),
                          ),
                          Text(
                            "${leageData.totalWiningAmount}".toUpperCase(),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                              fontWeight: FontWeight.bold,
                              fontSize: AppConstant.SIZE_TITLE14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 8),
                      color: Colors.white,
                      child: Text(
                        "Winners".toUpperCase(),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: AllCoustomTheme.getTextThemeColors(),
                          fontSize: AppConstant.SIZE_TITLE12,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 4),
                      child: Text(
                        "${leageData.totalWiner}".toUpperCase(),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                          fontWeight: FontWeight.bold,
                          fontSize: AppConstant.SIZE_TITLE14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 8),
                      color: Colors.white,
                      child: Text(
                        "Teams".toUpperCase(),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: AllCoustomTheme.getTextThemeColors(),
                          fontSize: AppConstant.SIZE_TITLE12,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 4),
                      child: Text(
                        "${leageData.totalTeam}".toUpperCase(),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                          fontWeight: FontWeight.bold,
                          fontSize: AppConstant.SIZE_TITLE14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(right: 8),
                      color: Colors.white,
                      child: Text(
                        "Entry".toUpperCase(),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: AllCoustomTheme.getTextThemeColors(),
                          fontSize: AppConstant.SIZE_TITLE12,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 8, top: 4),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 12,
                            height: 12,
                            padding: EdgeInsets.only(top: 1.5),
                            child: Image.asset(AppConstant.ruppeIcon),
                          ),
                          Text(
                            "${leageData.entryFees}".toUpperCase(),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                              fontWeight: FontWeight.bold,
                              fontSize: AppConstant.SIZE_TITLE14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            height: 40,
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
                    Navigator.pop(context);
                  },
                  child: Center(
                    child: Text(
                      'JOIN CONTEST',
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
        Container(
          padding: EdgeInsets.only(left: 16, bottom: 8, right: 16),
          color: Colors.white,
          child: Text(
            "You can check other competitors after joining the contest",
            style: TextStyle(
              fontFamily: 'Poppins',
              color: AllCoustomTheme.getTextThemeColors(),
              fontWeight: FontWeight.bold,
              fontSize: AppConstant.SIZE_TITLE14,
            ),
          ),
        ),
      ],
    );
  }

  Widget uderGroundDrawer(ContestsLeagueListData data) {
    return Column(
      children: <Widget>[
        Container(
          height: 40,
          padding: EdgeInsets.only(top: 4),
          color: Colors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'WINNING BREAKUP',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: AppConstant.SIZE_TITLE16,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 60,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Prize Pool',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                      fontSize: AppConstant.SIZE_TITLE16,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    '₹' + data.totalWiningAmount!,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: AllCoustomTheme.getTextThemeColors(),
                      fontWeight: FontWeight.bold,
                      fontSize: AppConstant.SIZE_TITLE20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: data.leagueWiner!.length,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(right: 10, left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Text(
                            'Rank: ' + data.leagueWiner![index].postion!,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: AppConstant.SIZE_TITLE14,
                            ),
                          ),
                        ),
                        Text(
                          '₹ ' + data.leagueWiner![index].price!,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: AllCoustomTheme.getTextThemeColors(),
                            fontSize: AppConstant.SIZE_TITLE14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider()
                ],
              );
            },
          ),
        ),
        Container(
          padding: EdgeInsets.only(right: 8, left: 8, bottom: 4),
          child: Text(
            'Note: The actual prize money may be different than the prize money mentioned above if there is a tie for any of the winning position. Check FQAs for further details.as per government regulations, a tax of 31.2% will be deducted if an individual wins more than Rs. 10,000',
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontFamily: 'Poppins',
              color: AllCoustomTheme.getTextThemeColors(),
              fontSize: AppConstant.SIZE_TITLE14,
            ),
          ),
        )
      ],
    );
  }

  Widget listItems(String name, String description) {
    return Column(
      children: <Widget>[
        InkWell(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 4, top: 8),
                child: Text(
                  name,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: AppConstant.SIZE_TITLE18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
                child: Text(
                  description,
                  style: TextStyle(fontFamily: 'Poppins', fontSize: AppConstant.SIZE_TITLE14, color: AllCoustomTheme.getTextThemeColors()),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

//   List<ContestListModel> contestListModel = [];
//   Future<void> _getContestList() async {
//     contestListModel.clear();
//     // if (teamController.userTeams.length != 0) {
//     var formData = {
//       'match_id': teamController.match_id,
//       'contest_id': teamController.contest_id,
//       'user_id': userId,
//     };
//     var response = await Dio().post('https://dream11.tennisworldxi.com/api/contest/leaderboard', queryParameters: formData);
//     var data = response.data['data']['contest'];
//     print(data.length);
//     if (data.length > 0) {
//       contestListModel.add(ContestListModel(
//         id: data['id'] ?? 0,
//         title: data['title'] ?? '',
//         prizePool: data['winning_prize'].toString(),
//         entryFee: data['entrance_amount'].toString(),
//         noOfWinner: data['no_of_winners'].toString(),
//         totalSpot: data['spot'].toString(),
//         currentSpot: data['current_spot'].toString(),
//       ));
//     }
//     print('data ${contestListModel.length}');

//     // }
//     isLoading = false;
//     setState(() {});
//   }
}

class MatchHadder extends StatefulWidget {
  final String? titel;
  final String? country1Name;
  final String? country1Flag;
  final String? country2Name;
  final String? country2Flag;
  final String? time;
  final String? price;

  const MatchHadder({
    Key? key,
    this.titel,
    this.country1Name,
    this.country1Flag,
    this.country2Name,
    this.country2Flag,
    this.time,
    this.price,
  }) : super(key: key);

  @override
  _MatchHadderState createState() => _MatchHadderState();
}

class _MatchHadderState extends State<MatchHadder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AllCoustomTheme.getThemeData().backgroundColor,
      child: Column(
        children: <Widget>[
          Container(
            height: 36,
            padding: EdgeInsets.only(left: 8, right: 8, bottom: 4, top: 4),
            child: Row(
              children: <Widget>[
                Container(
                  width: 24,
                  height: 24,
                  child: ClipOval(
                    child: Image.network(
                      widget.country1Flag!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: Text(
                    widget.country1Name!,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      color: AllCoustomTheme.getThemeData().primaryColor,
                      fontSize: AppConstant.SIZE_TITLE12,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    'vs',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: AppConstant.SIZE_TITLE12,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: Text(
                    widget.country2Name!,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      color: AllCoustomTheme.getThemeData().primaryColor,
                      fontSize: AppConstant.SIZE_TITLE12,
                    ),
                  ),
                ),
                Container(
                  width: 24,
                  height: 24,
                  child: ClipOval(
                    child: Image.network(
                      widget.country2Flag!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(),
                ),
                Container(
                  child: Text(
                    widget.time!,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: HexColor(
                        '#AAAFBC',
                      ),
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}

class TeamList extends StatefulWidget {
  const TeamList({super.key});

  @override
  State<TeamList> createState() => _TeamListState();
}

class _TeamListState extends State<TeamList> {
  var teamController = Get.put(TeamController());
  bool isTeamSelect = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Join Contest'),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Opacity(
            opacity: isTeamSelect ? 1.0 : 0.4,
            child: ElevatedButton(
              onPressed: () {
                if (isTeamSelect) {
                  teamController.joinUserContest(context);
                }
              },
              child: Text('Join Contest'.toUpperCase()),
              style: ElevatedButton.styleFrom(
                backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
              ),
            ),
          ),
        ],
      ),
      body: SizedBox(
        child: GetBuilder<TeamController>(
          builder: (con) => ListView.builder(
              itemCount: con.userTeams.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Card(
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
                                color: Colors.green[900]
                                // image: DecorationImage(image: AssetImage(AppConstant.cricketGround), fit: BoxFit.cover)
                                ),
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
                                          color: Colors.white,
                                          fontSize: AppConstant.SIZE_TITLE14,
                                        ),
                                      ),
                                      Expanded(child: SizedBox()),
                                      Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Icon(
                                        Icons.copy_all,
                                        color: Colors.white,
                                        size: 16,
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
                                          '${con.userTeams[index].team1_count}',
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
                                          '${con.userTeams[index].team2_count}',
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
                                Expanded(child: SizedBox()),
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
                                Expanded(child: SizedBox()),
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
                                Expanded(child: SizedBox()),
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
                                Radio(
                                    value: teamController.radioBtnVal[index],
                                    groupValue: teamController.group_val,
                                    onChanged: (val) {
                                      teamController.group_val = teamController.radioBtnVal[index];
                                      teamController.team_id = con.userTeams[index].team_id;
                                      teamController.update();
                                      setState(() {
                                        isTeamSelect = true;
                                      });
                                    }),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    index + 1 == con.userTeams.length
                        ? SizedBox(
                            height: 50,
                          )
                        : SizedBox(),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
