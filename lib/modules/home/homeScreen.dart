// ignore_for_file: unnecessary_null_comparison

import 'dart:ui';
import 'package:TennixWorldXI/GetxController/teamController.dart';
import 'package:TennixWorldXI/modules/ScoreBoard/score_view.dart';
import 'package:TennixWorldXI/modules/login/sliderView.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:TennixWorldXI/api/apiProvider.dart';
import 'package:TennixWorldXI/constant/constants.dart';
import 'package:TennixWorldXI/constant/sharedPreferences.dart';
import 'package:TennixWorldXI/constant/themes.dart';
import 'package:TennixWorldXI/models/scheduleResponseData.dart';
import 'package:TennixWorldXI/modules/contests/contestsScreen.dart';
import 'package:TennixWorldXI/models/userData.dart';
import 'package:TennixWorldXI/modules/drawer/drawer.dart';
import 'package:TennixWorldXI/modules/notification/notificationScreen.dart';
import 'package:TennixWorldXI/utils/avatarImage.dart';
import 'package:TennixWorldXI/validator/validator.dart';

import '../../api/Api_Handler/api_call_Structure.dart';
import '../../api/Api_Handler/api_constants.dart';
import '../../api/Api_Handler/api_error_response.dart';
import '../../models/matches_short_info.dart';
import '../contests/createContest.dart';

class HomeScreen extends StatefulWidget {
  final void Function()? menuCallBack;

  const HomeScreen({Key? key, this.menuCallBack}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

  var sheduallist = <ShedualData>[];
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isLoginProsses = true;
  UserData? userData;
  double index = 0.0;
  List<MatchShortInfo> _upComingMatches = <MatchShortInfo>[];
  var picPath = [
    'assets/cname/1.jpg',
    'assets/cname/2.jpg',
    'assets/cname/3.jpg',
  ];
  @override
  void initState() {
    getPlayersData(false);
    super.initState();
  }

  Future<Null> getPlayersData(bool pool) async {
    userData = (await MySharedPreferences().getUserData());
    if (!pool) {
      setState(() {
        isLoginProsses = true;
      });
    }

    var responseData = await ApiProvider().postScheduleList();

    if (responseData != null && responseData.shedualData != null) {
      sheduallist = responseData.shedualData!;
    }
    await _getMatchesList();
    if (!mounted) return null;
    setState(() {
      isLoginProsses = false;
    });
    return null;
  }

  @override
  void dispose() {
    super.dispose();
  }

  int currentIndex = 0;
  CarouselController controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Stack(
      children: <Widget>[
        Container(
          color: AllCoustomTheme.getThemeData().primaryColor,
        ),
        SafeArea(
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
              title: Center(
                child: Column(
                  children: [
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: ClipOval(
                        child: Image.asset('assets/cname/logo.jpeg'),
                      ),
                    ),
                    Text(
                      'TENNISWORDXI',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.event_available_sharp,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    // do something
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    // do something
                  },
                )
              ],
            ),
            drawer: AppDrawer(
              mySettingClick: () {},
              referralClick: () {},
            ),
            key: _scaffoldKey,
            backgroundColor: AllCoustomTheme.getThemeData().backgroundColor,
            body: RefreshIndicator(
              displacement: 100,
              key: _refreshIndicatorKey,
              onRefresh: () async {
                await getPlayersData(true);
              },
              child: ModalProgressHUD(
                inAsyncCall: isLoginProsses,
                color: Colors.transparent,
                progressIndicator: CircularProgressIndicator(
                  strokeWidth: 2.0,
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: MediaQuery.of(context).size.width * 0.40,
                      top: 10,
                      child: Column(
                        children: [
                          Text(
                            'Cricket',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: AllCoustomTheme.getThemeData().primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      top: 40,
                      child: Container(
                        width: size.width,
                        height: size.height * 0.2,
                        child: Column(
                          children: [
                            Container(
                                width: size.width,
                                height: size.height * 0.15,
                                margin: EdgeInsets.only(bottom: 5),
                                child: CarouselSlider(
                                  carouselController: controller,
                                  options: CarouselOptions(
                                      aspectRatio: 2.0,
                                      scrollDirection: Axis.horizontal,
                                      enlargeCenterPage: true,
                                      autoPlay: true,
                                      onPageChanged: ((ind, reason) {
                                        setState(() {
                                          index = ind.toDouble();
                                        });
                                      })),
                                  items: picPath
                                      .map((item) => Container(
                                            child: Center(
                                                child: Image.asset(
                                              item,
                                              fit: BoxFit.fitWidth,
                                              width: 1000,
                                              height: 100,
                                            )),
                                          ))
                                      .toList(),
                                )),
                            DotsIndicator(
                              dotsCount: 3,
                              position: index,
                              onTap: (val) {
                                controller.jumpToPage(val.toInt());
                              },
                              decorator: DotsDecorator(
                                size: const Size(15.0, 15.0),
                                activeSize: const Size(15.0, 15.0),
                                activeColor: Colors.green,
                                color: Colors.grey,
                                spacing: EdgeInsets.only(right: 5),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 190,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'Upcoming Matches',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.52,
                            width: size.width,
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
                                                    onTap: () {
                                                      Get.to(ScoreView(
                                                        team_id: 1,
                                                      ));
                                                    },
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
                                                    onTap: () {
                                                      Get.to(ScoreView(
                                                        team_id: 2,
                                                      ));
                                                    },
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
                          ),
                        ],
                      ),
                    ),
                    // CustomScrollView(
                    //   physics: BouncingScrollPhysics(),
                    //   slivers: <Widget>[
                    //     SliverList(
                    //       delegate: new SliverChildBuilderDelegate(
                    //         (context, index) => listItems(index),
                    //         childCount: _upComingMatches.length,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget drawerButton() {
    return InkWell(
      // onTap: openDrawer,
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: AllCoustomTheme.getThemeData().scaffoldBackgroundColor,
            radius: 16,
            child: AvatarImage(
              imageUrl: 'https://www.menshairstylesnow.com/wp-content/uploads/2018/03/Hairstyles-for-Square-Faces-Slicked-Back-Undercut.jpg',
              isCircle: true,
              radius: 28,
              sizeValue: 28,
            ),
          ),
          SizedBox(
            width: 4,
          ),
          Icon(
            Icons.sort,
            size: 30,
          )
        ],
      ),
    );
  }

  Widget notificationButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NotificationScreen(),
              fullscreenDialog: true,
            ));
      },
      child: Container(
        padding: EdgeInsets.all(12),
        child: Icon(
          Icons.notifications,
          color: AllCoustomTheme.getReBlackAndWhiteThemeColors(),
        ),
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
              'Upcoming Matches',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showInSnackBar(String value) {
    // ignore: deprecated_member_use
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
        backgroundColor: Colors.red,
      ),
    );
  }

  Widget listItems(int index) {
    MatchShortInfo _matchInfo = _upComingMatches[index];
    return MatchesList(
      id: _matchInfo.id,
      title: _matchInfo.title,
      country1Name: _matchInfo.country1Name,
      country2Name: _matchInfo.country2Name,
      country1Flag: _matchInfo.country1Flag,
      country2Flag: _matchInfo.country2Flag,
      price: _matchInfo.price,
      time: _matchInfo.time,
    );
  }

  void openDrawer() {
    widget.menuCallBack!();
  }

  bool isCallingApi = false;
  bool isDataFetched = false;
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
      isLoginProsses = false;
      setState(() {});
    }
    isCallingApi = false;
  }
}

class MatchesList extends StatefulWidget {
  final String? title;
  final int id;
  final String? country1Name;
  final String? country1Flag;
  final String? country2Name;
  final String? country2Flag;
  final String? time;
  final String? price;

  const MatchesList({
    Key? key,
    required this.id,
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ContestsScreen(
              country1Flag: widget.country1Flag,
              country2Flag: widget.country2Flag,
              country1Name: widget.country1Name,
              country2Name: widget.country2Name,
              price: widget.price,
              time: widget.time,
              titel: widget.title,
            ),
          ),
        );
      },
      onLongPress: () {
        showModalBottomSheet<void>(
          context: context,
          builder: (
            BuildContext context,
          ) =>
              UnderGroundDrawer(
            country1Flag: widget.country1Flag!,
            country2Flag: widget.country2Flag!,
            country1Name: widget.country1Name!,
            country2Name: widget.country2Name!,
            price: widget.price!,
            time: widget.time!,
            titel: widget.title!,
          ),
        );
      },
      child: Card(
        borderOnForeground: true,
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
                        widget.title!,
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
                      Container(
                        child: Text(
                          widget.time!,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: AppConstant.SIZE_TITLE12,
                            color: Colors.red,
                          ),
                        ),
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

class UnderGroundDrawer extends StatefulWidget {
  final String? titel;
  final String? country1Name;
  final String? gmail;
  final String? country1Flag;
  final String? country2Name;
  final String? country2Flag;
  final String? time;
  final String? price;

  const UnderGroundDrawer({
    Key? key,
    this.titel,
    this.country1Name,
    this.gmail,
    this.country1Flag,
    this.country2Name,
    this.country2Flag,
    this.time,
    this.price,
  }) : super(key: key);

  @override
  _UnderGroundDrawerState createState() => _UnderGroundDrawerState();
}

class _UnderGroundDrawerState extends State<UnderGroundDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
      ),
      child: Column(
        children: <Widget>[
          matchSchedulData(),
          Divider(
            height: 1,
          ),
          Expanded(
            child: matchInfoList(),
          ),
        ],
      ),
    );
  }

  Widget matchInfoList() {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: 1,
      itemBuilder: (context, index) {
        return Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(right: 16, left: 16, top: 10, bottom: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 100,
                      child: Text(
                        'Match',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: AppConstant.SIZE_TITLE16,
                          color: AllCoustomTheme.getTextThemeColors(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Text(
                        widget.country1Name! + " vs " + widget.country2Name!,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: AppConstant.SIZE_TITLE16,
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.only(right: 16, left: 16, bottom: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 100,
                      child: Text(
                        'Series',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: AppConstant.SIZE_TITLE16,
                          color: AllCoustomTheme.getTextThemeColors(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Text(
                        widget.titel!,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: AppConstant.SIZE_TITLE16,
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.only(right: 16, left: 16, bottom: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 100,
                      child: Text(
                        'Start Date',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: AppConstant.SIZE_TITLE16,
                          color: AllCoustomTheme.getTextThemeColors(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Text(
                        widget.time!,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: AppConstant.SIZE_TITLE16,
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.only(right: 16, left: 16, bottom: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 100,
                      child: Text(
                        'Start Time',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: AppConstant.SIZE_TITLE16,
                          color: AllCoustomTheme.getTextThemeColors(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Text(
                        '15:00:00',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: AppConstant.SIZE_TITLE16,
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.only(right: 16, left: 16, bottom: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 100,
                      child: Text(
                        'Venue',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: AppConstant.SIZE_TITLE16,
                          color: AllCoustomTheme.getTextThemeColors(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Text(
                        'India',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: AppConstant.SIZE_TITLE16,
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.only(right: 16, left: 16, bottom: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 100,
                      child: Text(
                        'Umpires',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: AppConstant.SIZE_TITLE16,
                          color: AllCoustomTheme.getTextThemeColors(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Text(
                        'Martine',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: AppConstant.SIZE_TITLE16,
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.only(right: 16, left: 16, bottom: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 100,
                      child: Text(
                        'Referee',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: AppConstant.SIZE_TITLE16,
                          color: AllCoustomTheme.getTextThemeColors(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Text(
                        'Charls piter',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: AppConstant.SIZE_TITLE16,
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.only(right: 16, left: 16, bottom: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 100,
                      child: Text(
                        'Match Format',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: AppConstant.SIZE_TITLE16,
                          color: AllCoustomTheme.getTextThemeColors(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Text(
                        'Match Formate',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: AppConstant.SIZE_TITLE16,
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.only(right: 16, left: 16, bottom: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 100,
                      child: Text(
                        'Location',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: AppConstant.SIZE_TITLE16,
                          color: AllCoustomTheme.getTextThemeColors(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Text(
                        'India',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: AppConstant.SIZE_TITLE16,
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider()
            ],
          ),
        );
      },
    );
  }

  Widget matchSchedulData() {
    return Container(
      padding: EdgeInsets.all(10),
      height: 50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 30,
                height: 30,
                child: Container(
                  width: 50,
                  height: 50,
                  child: Image.asset(widget.country1Flag!),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: 4),
            child: new Text(
              widget.country1Name!,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                color: AllCoustomTheme.getThemeData().primaryColor,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            child: Text(
              'vs',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: AppConstant.SIZE_TITLE14,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            child: new Text(
              widget.country2Name!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                color: AllCoustomTheme.getThemeData().primaryColor,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 4),
            child: Container(
              child: Container(
                width: 50,
                height: 50,
                child: Image.asset(widget.country2Flag!),
              ),
            ),
          ),
          Expanded(
            child: Container(),
          ),
          Text(
            widget.time!,
            style: TextStyle(
              fontFamily: 'Poppins',
              color: HexColor(
                '#AAAFBC',
              ),
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

enum AppBarBehavior { normal, pinned, floating, snapping }
