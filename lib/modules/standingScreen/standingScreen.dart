import 'package:TennixWorldXI/GetxController/teamController.dart';
import 'package:TennixWorldXI/models/matches_short_info.dart';
import 'package:TennixWorldXI/modules/contests/contestsScreen.dart';
import 'package:flutter/material.dart';
import 'package:TennixWorldXI/constant/constants.dart';
import 'package:TennixWorldXI/constant/sharedPreferences.dart';
import 'package:TennixWorldXI/constant/themes.dart';
import 'package:TennixWorldXI/models/userData.dart';
import 'package:TennixWorldXI/modules/drawer/drawer.dart';
import 'package:TennixWorldXI/modules/home/homeScreen.dart';
import 'package:TennixWorldXI/modules/result/standingResult.dart';
import 'package:TennixWorldXI/utils/avatarImage.dart';
import 'package:TennixWorldXI/validator/validator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../api/Api_Handler/api_call_Structure.dart';
import '../../api/Api_Handler/api_constants.dart';
import '../../api/Api_Handler/api_error_response.dart';

class StandingScree extends StatefulWidget {
  final void Function()? menuCallBack;

  const StandingScree({Key? key, this.menuCallBack}) : super(key: key);
  @override
  _StandingScreeState createState() => _StandingScreeState();
}

class _StandingScreeState extends State<StandingScree> with SingleTickerProviderStateMixin {
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKeyF = new GlobalKey<RefreshIndicatorState>();

  List<MatchShortInfo> _upComingMatches = <MatchShortInfo>[];
  List<MatchShortInfo> _liveMatches = <MatchShortInfo>[];
  List<MatchShortInfo> _completedMatches = <MatchShortInfo>[];
  bool isDataFetched = false;
  late TabController _tabController;
  bool isCallingApi = true;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
    _getMatchesList();
    _tabController.addListener(() {
      if (!isDataFetched && !isCallingApi) {
        _getMatchesList();
      }
    });
    updateData();
  }

  updateData() async {
    userData = (await MySharedPreferences().getUserData());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Stack(
        children: <Widget>[
          Container(
            color: AllCoustomTheme.getThemeData().primaryColor,
          ),
          SafeArea(
            child: Scaffold(
              drawer: AppDrawer(
                mySettingClick: () {},
                referralClick: () {},
              ),
              appBar: AppBar(
                elevation: 0,
                backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
                title: Text(
                  'Standings',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                bottom: TabBar(
                  controller: _tabController,
                  tabs: [
                    Tab(
                      icon: Text(
                        "Upcoming",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Tab(
                      icon: Text(
                        "Live",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Tab(
                      icon: Text(
                        "Completed",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              body: Container(
                color: AllCoustomTheme.getThemeData().backgroundColor,
                child: TabBarView(
                  controller: _tabController,
                  children: <Widget>[
                    isDataFetched
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height * 0.52,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                                itemCount: _upComingMatches.length,
                                itemBuilder: (context, int) {
                                  return GestureDetector(
                                    onTap: () {
                                      var teamCont = Get.put(TeamController(), permanent: true);
                                      teamCont.match_id = _upComingMatches[int].id;
                                      teamCont.team1Flag = _upComingMatches[int].country1Flag;
                                      teamCont.team2Flag = _upComingMatches[int].country2Flag;
                                      teamCont.team1Name = _upComingMatches[int].country1Name;
                                      teamCont.team2Name = _upComingMatches[int].country2Name;
                                      teamCont.team1ShortName = _upComingMatches[int].country1ShortName;
                                      teamCont.team2ShortName = _upComingMatches[int].country2ShortName;
                                      teamCont.contest_id = _upComingMatches[int].contest_id;
                                      teamCont.update();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => ContestsScreen(
                                                    matchID: _upComingMatches[int].id,
                                                    country1Flag: 'https://dream11.tennisworldxi.com/storage/app/${_upComingMatches[int].country1Flag}',
                                                    country1Name: _upComingMatches[int].country1ShortName.toString(),
                                                    country2Flag: 'https://dream11.tennisworldxi.com/storage/app/${_upComingMatches[int].country2Flag}',
                                                    country2Name: _upComingMatches[int].country2ShortName.toString(),
                                                    price: '123',
                                                    time: '1h 46m',
                                                    titel: _upComingMatches[int].title.toString(),
                                                    country1FullName: _upComingMatches[int].country1Name.toString(),
                                                    country2FullName: _upComingMatches[int].country2Name.toString(),
                                                  )));
                                    },
                                    child: Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      child: Column(children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(_upComingMatches[int].title.toString()),
                                              Icon(
                                                FontAwesomeIcons.bell,
                                                size: 20,
                                                color: Colors.black,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Divider(
                                          height: 1,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(_upComingMatches[int].country1Name.toString()),
                                              Text(_upComingMatches[int].country2Name.toString()),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {},
                                                    child: SizedBox(
                                                      width: 50,
                                                      height: 50,
                                                      child: ClipOval(
                                                          child: Image.network(
                                                        'https://dream11.tennisworldxi.com/storage/app/${_upComingMatches[int].country1Flag}',
                                                        fit: BoxFit.cover,
                                                      )),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    _upComingMatches[int].country1ShortName.toString(),
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.w800,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Text(
                                                '1h 46m',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.red,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    _upComingMatches[int].country2ShortName.toString(),
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.w800,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {},
                                                    child: SizedBox(
                                                      width: 50,
                                                      height: 50,
                                                      child: ClipOval(
                                                          child: Image.network(
                                                        'https://dream11.tennisworldxi.com/storage/app/${_upComingMatches[int].country2Flag}',
                                                        fit: BoxFit.cover,
                                                      )),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(20),
                                              bottomRight: Radius.circular(20),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      width: 50,
                                                      margin: EdgeInsets.all(5),
                                                      decoration: BoxDecoration(
                                                          color: Color.fromARGB(255, 156, 235, 159).withOpacity(0.2),
                                                          border: Border.all(
                                                            color: Colors.green,
                                                          )),
                                                      child: Center(
                                                        child: Text(
                                                          'Mega'.toUpperCase(),
                                                          style: TextStyle(
                                                            color: Color.fromARGB(255, 6, 95, 9),
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      '20 Lakhs',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      FontAwesomeIcons.gift,
                                                      color: Colors.grey,
                                                      size: 20,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Icon(
                                                      FontAwesomeIcons.rainbow,
                                                      color: Colors.grey,
                                                      size: 20,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ]),
                                    ),
                                  );
                                }),
                          )
                        : Center(child: CircularProgressIndicator()),
                    isDataFetched
                        ? Live(
                            liverMatches: _liveMatches,
                          )
                        : Center(child: CircularProgressIndicator()),
                    Completed(),
                    // isDataFetched
                    //     ? Results(
                    //         completedMatches: _completedMatches,
                    //       )
                    //     : Center(child: CircularProgressIndicator()),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  UserData? userData;

  Widget drawerButton() {
    return InkWell(
      // onTap: openDrawer,
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: AllCoustomTheme.getThemeData().scaffoldBackgroundColor,
            radius: 14,
            child: AvatarImage(
              imageUrl: AppConstant.appIcon,
              isCircle: true,
              radius: 28,
              sizeValue: 28,
              isAssets: false,
            ),
          ),
          Icon(Icons.sort, color: AllCoustomTheme.getReBlackAndWhiteThemeColors())
        ],
      ),
    );
  }

  Widget sliverText() {
    return FlexibleSpaceBar(
      centerTitle: false,
      titlePadding: EdgeInsetsDirectional.only(start: 16, bottom: 8, top: 0),
      title: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Standings',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 24,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500,
                color: AllCoustomTheme.getThemeData().backgroundColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void openDrawer() {
    widget.menuCallBack!();
  }

  Future<void> _getMatchesList() async {
    isCallingApi = true;
    API_STRUCTURE apiObject = API_STRUCTURE(
      context: context,
      apiName: ApiConstant.homeFeedMatches,
      apiRequestMethod: API_REQUEST_METHOD.GET,
      isWantSuccessMessage: false,
    );
    Map<dynamic, dynamic> apiResponse = await apiObject.requestAPI(isShowLoading: false);
    if (apiResponse.containsKey(API_RESPONSE.SUCCESS)) {
      Map<String, dynamic> _result = apiResponse[API_RESPONSE.SUCCESS]['data']['result'];
      debugPrint("_result:-> $_result");
      for (var data in _result['upcomingMatches']) {
        _upComingMatches.add(MatchShortInfo(
          id: data['id'],
          title: data['title'],
          country1Name: data['team_1_title'],
          country2Name: data['team_2_title'],
          time: data['match_date_time'],
          country1Flag: data['team_1_thumbnail'],
          country2Flag: data['team_2_thumbnail'],
          country1ShortName: data['team_1_short_name'],
          country2ShortName: data['team_2_short_name'],
          contest_id: data['contest_category_id'],
        ));
      }
      isCallingApi = false;
      isDataFetched = true;
      print('data fetch');
      setState(() {});
      // for (var data in _result['liveMatches']) {
      //   _liveMatches.add(MatchShortInfo(
      //     contest_id: 1,
      //     id: data['id'],
      //     title: data['title'],
      //     country1Name: data['team_1_title'],
      //     country2Name: data['team_2_title'],
      //     time: 'Live',
      //     country1Flag: 'assets/19.png',
      //     country2Flag: 'assets/25.png',
      //     country1ShortName: '',
      //     country2ShortName: '',
      //   ));
      // }
      // for (var data in _result['completedMatches']) {
      //   _completedMatches.add(MatchShortInfo(
      //     contest_id: 1,
      //     country1ShortName: '',
      //     country2ShortName: '',
      //     id: data['id'],
      //     title: data['title'],
      //     country1Name: data['team_1_title'],
      //     country2Name: data['team_2_title'],
      //     time: 'Completed',
      //     country1Flag: 'assets/19.png',
      //     country2Flag: 'assets/25.png',
      //   ));
      // }
      // setState(() {});
    }
    isCallingApi = false;
  }
}

class Fixtures extends StatefulWidget {
  List<MatchShortInfo> upComingMatches;
  Fixtures({required this.upComingMatches});
  @override
  _FixturesState createState() => _FixturesState();
}

class _FixturesState extends State<Fixtures> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 4),
      physics: BouncingScrollPhysics(),
      itemCount: widget.upComingMatches.length,
      itemBuilder: (context, index) {
        MatchShortInfo _matchInfo = widget.upComingMatches[index];
        return MatchesList(
          title: _matchInfo.title,
          country1Name: _matchInfo.country1Name,
          country2Name: _matchInfo.country2Name,
          country1Flag: _matchInfo.country1Flag,
          country2Flag: _matchInfo.country2Flag,
          price: _matchInfo.price,
          time: _matchInfo.time,
        );
      },
    );
  }
}

class Live extends StatefulWidget {
  List<MatchShortInfo> liverMatches;
  Live({required this.liverMatches});
  @override
  _LiveState createState() => _LiveState();
}

class _LiveState extends State<Live> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: AllCoustomTheme.getTextThemeColors(),
          width: 100,
          height: 100,
          child: Image.asset(
            'assets/cup.png',
            width: 50,
            height: 50,
          ),
        ),
        Text(
          "You haven't joined any contests that are Live\nJoin contests for any of the upcoming matches",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: AppConstant.SIZE_TITLE14,
            color: AllCoustomTheme.getTextThemeColors(),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Divider(
          height: 1.3,
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.only(top: 4),
            physics: BouncingScrollPhysics(),
            itemCount: widget.liverMatches.length,
            itemBuilder: (context, index) {
              MatchShortInfo _matchInfo = widget.liverMatches[index];
              return MatchesList(
                title: _matchInfo.title,
                country1Name: _matchInfo.country1Name,
                country2Name: _matchInfo.country2Name,
                country1Flag: _matchInfo.country1Flag,
                country2Flag: _matchInfo.country2Flag,
                price: _matchInfo.price,
                time: _matchInfo.time,
              );
            },
          ),
        )
      ],
    );
  }
}

class Results extends StatefulWidget {
  List<MatchShortInfo> completedMatches;
  Results({required this.completedMatches});
  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.only(top: 4),
            physics: BouncingScrollPhysics(),
            itemCount: widget.completedMatches.length,
            itemBuilder: (context, index) {
              MatchShortInfo _matchInfo = widget.completedMatches[index];
              return MatchesList(
                title: _matchInfo.title,
                country1Name: _matchInfo.country1Name,
                country2Name: _matchInfo.country2Name,
                country1Flag: _matchInfo.country1Flag,
                country2Flag: _matchInfo.country2Flag,
                price: _matchInfo.price,
                time: _matchInfo.time,
              );
            },
          ),
        )
      ],
    );
  }
}

class MatchesList extends StatefulWidget {
  final String? title;
  final String? country1Name;
  final String? country1Flag;
  final String? country2Name;
  final String? country2Flag;
  final String? time;
  final String? price;

  const MatchesList({
    Key? key,
    this.title,
    this.country1Name,
    this.country2Name,
    this.time,
    this.price,
    this.country1Flag,
    this.country2Flag,
  }) : super(key: key);

  @override
  _MatchesListState createState() => _MatchesListState();
}

class _MatchesListState extends State<MatchesList> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => StandingResult(
        //       country1Flag: widget.country1Flag,
        //       country2Flag: widget.country2Flag,
        //       country1Name: widget.country1Name,
        //       country2Name: widget.country2Name,
        //       price: widget.price,
        //       time: widget.time,
        //       titel: widget.titel,
        //     ),
        //   ),
        // );
      },
      onLongPress: () {
        // showModalBottomSheet<void>(
        //   context: context,
        //   builder: (
        //     BuildContext context,
        //   ) =>
        //       UnderGroundDrawer(
        //     country1Flag: widget.country1Flag,
        //     country2Flag: widget.country2Flag,
        //     country1Name: widget.country1Name,
        //     country2Name: widget.country2Name,
        //     price: widget.price,
        //     time: widget.time,
        //     titel: widget.titel,
        //   ),
        // );
      },
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'widget.title',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: AppConstant.SIZE_TITLE12,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).disabledColor,
                        ),
                      ),
                      Expanded(child: SizedBox()),
                      Image.asset(
                        AppConstant.lineups,
                        height: 14,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Icon(
                        Icons.notification_add_outlined,
                        size: 16,
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1.3,
                  ),
                  Row(
                    children: [
                      Text(
                        widget.country1Name!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: AppConstant.SIZE_TITLE14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Expanded(child: SizedBox()),
                      Text(
                        widget.country2Name!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: AppConstant.SIZE_TITLE14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        child: Image.asset(widget.country1Flag!),
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 3,
                            backgroundColor: Colors.green,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            widget.time!,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: AppConstant.SIZE_TITLE12,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        child: Image.asset(widget.country2Flag!),
                      ),
                    ],
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
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 3, left: 3),
                        child: Text(
                          "Mega",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: AppConstant.SIZE_TITLE12,
                            color: Colors.green,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      widget.price!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: AppConstant.SIZE_TITLE12,
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    Image.asset(
                      AppConstant.tv,
                      height: 18,
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
}

class Completed extends StatelessWidget {
  const Completed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // body: SizedBox(
      //   child: ListView.builder(
      //       itemCount: 10,
      //       itemBuilder: (context, int) {
      //         return GestureDetector(
      //           onTap: () {},
      //           child: Card(
      //             elevation: 5,
      //             shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(20),
      //             ),
      //             margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      //             child: Column(children: [
      //               Padding(
      //                 padding: const EdgeInsets.only(left: 10, top: 10),
      //                 child: Row(
      //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                   children: [
      //                     Text('ICC World CUP'),
      //                   ],
      //                 ),
      //               ),
      //               SizedBox(
      //                 height: 5,
      //               ),
      //               Divider(
      //                 height: 1,
      //               ),
      //               SizedBox(
      //                 height: 10,
      //               ),
      //               Padding(
      //                 padding: const EdgeInsets.symmetric(horizontal: 10),
      //                 child: Row(
      //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                   children: [
      //                     Text('Pakistan'),
      //                     Text('India'),
      //                   ],
      //                 ),
      //               ),
      //               Padding(
      //                 padding: EdgeInsets.symmetric(horizontal: 10),
      //                 child: Row(
      //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                   children: [
      //                     Row(
      //                       children: [
      //                         SizedBox(
      //                           width: 50,
      //                           height: 50,
      //                           child: Image.asset('assets/13.png'),
      //                         ),
      //                         SizedBox(
      //                           width: 10,
      //                         ),
      //                         Text(
      //                           'PAK',
      //                           style: TextStyle(
      //                             fontSize: 20,
      //                             fontWeight: FontWeight.w800,
      //                           ),
      //                         )
      //                       ],
      //                     ),
      //                     Text(
      //                       'Completed'.toUpperCase(),
      //                       style: TextStyle(
      //                         fontSize: 16,
      //                         fontWeight: FontWeight.w800,
      //                         color: Colors.green,
      //                       ),
      //                     ),
      //                     Row(
      //                       children: [
      //                         Text(
      //                           'IND',
      //                           style: TextStyle(
      //                             fontSize: 20,
      //                             fontWeight: FontWeight.w800,
      //                           ),
      //                         ),
      //                         SizedBox(
      //                           width: 10,
      //                         ),
      //                         SizedBox(
      //                           width: 50,
      //                           height: 50,
      //                           child: Image.asset('assets/17.png'),
      //                         ),
      //                       ],
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //               Container(
      //                 height: 30,
      //                 decoration: BoxDecoration(
      //                   color: Colors.grey[200],
      //                   borderRadius: BorderRadius.only(
      //                     bottomLeft: Radius.circular(20),
      //                     bottomRight: Radius.circular(20),
      //                   ),
      //                 ),
      //                 child: Padding(
      //                   padding: const EdgeInsets.symmetric(horizontal: 20),
      //                   child: Row(
      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                     children: [
      //                       Row(
      //                         children: [
      //                           Text(
      //                             '1 Team',
      //                             style: TextStyle(
      //                               color: Colors.black,
      //                               fontWeight: FontWeight.bold,
      //                             ),
      //                           ),
      //                           Text(
      //                             '1 Contest',
      //                             style: TextStyle(
      //                               color: Colors.black,
      //                               fontWeight: FontWeight.bold,
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               )
      //             ]),
      //           ),
      //         );

      //       }),
      // ),
    );
  }
}
