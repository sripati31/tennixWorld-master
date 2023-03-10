import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:TennixWorldXI/constant/constants.dart';
import 'package:TennixWorldXI/constant/themes.dart';
import 'package:TennixWorldXI/modules/drawer/drawer.dart';
import 'package:TennixWorldXI/modules/home/winner.dart';
import 'package:TennixWorldXI/modules/myProfile/myProfileScreen.dart';
import 'package:TennixWorldXI/modules/standingScreen/standingScreen.dart';
import 'package:TennixWorldXI/validator/validator.dart';
import 'package:provider/provider.dart';
import '../../bloc/bottom_nav_bar_provider.dart';
import 'homeScreen.dart';
import 'moreScreen.dart';
import 'package:TennixWorldXI/constant/global.dart';

class TabScreen extends StatefulWidget {
  final BuildContext? menuScreenContext;
  TabScreen({Key? key, this.menuScreenContext}) : super(key: key);

  @override
  TabScreenState createState() => TabScreenState();
}

class TabScreenState extends State<TabScreen> {
  late PersistentTabController _controller;
  int currentIndex = 0;
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  late bool hideNavBar = false;
  late BottomNavProvider _bottomNavProvider;
  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _bottomNavProvider.showTabBarStatus();
    });
    HomeScreen(
      menuCallBack: () {
        // ScaffoldMessenger.of(context).openEndDrawer();
      },
    );
  }

  List<Widget> _buildScreens() {
    return [
      HomeScreen(
        menuCallBack: () {
          // ScaffoldMessenger.of(context).openEndDrawer();
        },
      ),
      StandingScree(
        menuCallBack: () {
          // ScaffoldMessenger.of(context).openEndDrawer();
        },
      ),
      // MyProfileScreen(),
      Winner(),
      Text(''),
      Text(''),

      // MoreScreen(inviteFriendClick: () {
      //   showModalBottomSheet<void>(
      //     context: context,
      //     builder: (BuildContext context) => uderGroundDrawer(),
      //   );
      // }),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(
          FontAwesomeIcons.home,
          size: 18,
        ),
        title: "home",
        activeColorPrimary: AllCoustomTheme.getThemeData().primaryColor,
        inactiveColorPrimary: HexColor('#AAAFBC'),
        textStyle: TextStyle(
          fontFamily: 'Poppins',
          color: AllCoustomTheme.getTextThemeColors(),
          fontSize: AppConstant.SIZE_TITLE10,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          FontAwesomeIcons.trophy,
          size: 18,
          color: Color.fromARGB(255, 206, 206, 42),
        ),
        title: ("My Match"),
        activeColorPrimary: AllCoustomTheme.getThemeData().primaryColor,
        inactiveColorPrimary: HexColor('#AAAFBC'),
        textStyle: TextStyle(
          fontFamily: 'Poppins',
          color: AllCoustomTheme.getTextThemeColors(),
          fontSize: AppConstant.SIZE_TITLE10,
        ),
      ),
      // PersistentBottomNavBarItem(
      //   icon: Icon(
      //     FontAwesomeIcons.userAlt,
      //     size: 18,
      //     color: Colors.white,
      //   ),
      //   activeColorPrimary: AllCoustomTheme.getThemeData().primaryColor,
      //   inactiveColorPrimary: HexColor('#AAAFBC'),
      //   textStyle: TextStyle(
      //     fontFamily: 'Poppins',
      //     color: AllCoustomTheme.getTextThemeColors(),
      //     fontSize: AppConstant.SIZE_TITLE10,
      //   ),
      // ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.military_tech,
          size: 26,
          color: Colors.white,
        ),
        title: ("Winner"),
        activeColorPrimary: AllCoustomTheme.getThemeData().primaryColor,
        inactiveColorPrimary: HexColor('#AAAFBC'),
        textStyle: TextStyle(
          fontFamily: 'Poppins',
          color: AllCoustomTheme.getTextThemeColors(),
          fontSize: AppConstant.SIZE_TITLE10,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.live_tv,
          size: 26,
        ),
        title: ("Live"),
        activeColorPrimary: AllCoustomTheme.getThemeData().primaryColor,
        inactiveColorPrimary: HexColor('#AAAFBC'),
        textStyle: TextStyle(
          fontFamily: 'Poppins',
          color: AllCoustomTheme.getTextThemeColors(),
          fontSize: AppConstant.SIZE_TITLE10,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset(
          'assets/reward.jpeg',
        ),
        activeColorPrimary: AllCoustomTheme.getThemeData().primaryColor,
        inactiveColorPrimary: HexColor('#AAAFBC'),
        textStyle: TextStyle(
          fontFamily: 'Poppins',
          color: AllCoustomTheme.getTextThemeColors(),
          fontSize: AppConstant.SIZE_TITLE10,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    _bottomNavProvider = Provider.of<BottomNavProvider>(context, listen: true);
    AppConstant.mainScreenContext = context;
    return Scaffold(
      key: _scaffoldKey,
      // drawer: Container(
      //   width: MediaQuery.of(context).size.width * 0.75,
      //   child: AppDrawer(
      //     mySettingClick: () {
      //       setState(() {
      //         currentIndex = 2;
      //         _buildScreens();
      //       });
      //     },
      //     referralClick: () {
      //       showModalBottomSheet<void>(
      //         context: context,
      //         builder: (BuildContext context) => uderGroundDrawer(),
      //       );
      //     },
      //   ),
      // ),
      body: PersistentTabView(
        context,
        controller: _controller,
        backgroundColor: Theme.of(context).cardColor,
        screens: _buildScreens(),
        items: _navBarsItems(),
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0 ? 0.0 : kBottomNavigationBarHeight,
        hideNavigationBarWhenKeyboardShows: true,
        margin: EdgeInsets.all(0.0),
        popActionScreens: PopActionScreensType.all,
        bottomScreenMargin: 0.0,
        // onWillPop: (context) async {
        //   await showDialog(
        //     context: context!,
        //     useSafeArea: true,
        //     builder: (context) => Container(
        //       height: 50.0,
        //       width: 50.0,
        //       color: Colors.white,
        //       child: ElevatedButton(
        //         child: Text("Close"),
        //         onPressed: () {
        //           Navigator.pop(context);
        //         },
        //       ),
        //     ),
        //   );
        //   return false;
        // },
        hideNavigationBar: _bottomNavProvider.isHideTabBar,
        decoration: NavBarDecoration(colorBehindNavBar: Colors.indigo, borderRadius: BorderRadius.circular(0)),
        popAllScreensOnTapOfSelectedTab: true,
        itemAnimationProperties: ItemAnimationProperties(
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style15,
      ),
    );
  }

  Widget uderGroundDrawer() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 4),
          color: Theme.of(context).backgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              Text(
                "Kick off your friend's Fixturers journey!",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                  fontWeight: FontWeight.bold,
                  fontSize: AppConstant.SIZE_TITLE16,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "For every friend that plays, you both get 100 for free!",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: AllCoustomTheme.getTextThemeColors(),
                  fontSize: AppConstant.SIZE_TITLE14,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Divider(
                height: 1,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'SHARE YOUR INVITE CODE',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: AllCoustomTheme.getBlackAndWhiteThemeColors().withOpacity(0.6),
                  fontSize: AppConstant.SIZE_TITLE12,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "How it works",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: AllCoustomTheme.getThemeData().primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: AppConstant.SIZE_TITLE14,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Container(
                      height: 24,
                      width: 1,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "Rules of FairPlay",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: AllCoustomTheme.getThemeData().primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: AppConstant.SIZE_TITLE14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Divider(
                height: 1,
              ),
              Text(
                'Cricket123',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                  fontWeight: FontWeight.bold,
                  fontSize: AppConstant.SIZE_TITLE20,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  // Share.share('check out my website https://example.com');
                },
                child: Container(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
                  decoration: new BoxDecoration(
                    color: AllCoustomTheme.getThemeData().backgroundColor,
                    borderRadius: new BorderRadius.circular(4.0),
                    border: Border.all(
                      color: Colors.green,
                      width: 1,
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(color: Colors.black.withOpacity(0.2), offset: Offset(0, 1), blurRadius: 5.0),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Share Code'.toUpperCase(),
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.green,
                        fontSize: AppConstant.SIZE_TITLE12,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
