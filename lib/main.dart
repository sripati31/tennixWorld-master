import 'package:TennixWorldXI/TestClass.dart';
import 'package:TennixWorldXI/bloc/bottom_nav_bar_provider.dart';
import 'package:TennixWorldXI/bloc/phoneVerificationBloc.dart';
import 'package:TennixWorldXI/constant/firsttime.dart';
import 'package:TennixWorldXI/constant/global.dart';
import 'package:TennixWorldXI/constant/routes.dart';
import 'package:TennixWorldXI/constant/themes.dart';
import 'package:TennixWorldXI/modules/CustomImagePicker/camera.dart';
import 'package:TennixWorldXI/modules/ScoreBoard/player_record.dart';
import 'package:TennixWorldXI/modules/ScoreBoard/score_view.dart';
import 'package:TennixWorldXI/modules/ScoreBoard/specific_scoreboard.dart';
import 'package:TennixWorldXI/modules/createTeam/CreateTeamViews/player_view_item.dart';
import 'package:TennixWorldXI/modules/home/tabScreen.dart';
import 'package:TennixWorldXI/modules/login/loginScreen.dart';
import 'package:TennixWorldXI/modules/login/otpValidationScreen.dart';
import 'package:TennixWorldXI/modules/pymentOptions/WinningScreenTabViews/Contest.dart';
import 'package:TennixWorldXI/modules/splash/SplashScreen.dart';
import 'package:TennixWorldXI/view_model/auth_view_model/login_view_model.dart';
import 'package:TennixWorldXI/view_model/auth_view_model/sign_up_view_model.dart';
import 'package:TennixWorldXI/view_model/auth_view_model/social_login_view_model.dart';
import 'package:TennixWorldXI/view_model/user_view_model/user_prefrence_model.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'constant/constants.dart';
import 'modules/ScoreBoard/Player_all_record.dart';

int userId = 2;
var userToken =
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMDViODlmZGMxMmE3NjU4Yjk0Nzg2MGNjMzY1NGFjODQ5YzgxZmE2ZjUyMGQ2ZWYwMzQxOTI4N2NlNWM1N2NjZGFjYzM0MjFkOGMyOWVkYjAiLCJpYXQiOjE2NzQ3NDU0MjQsIm5iZiI6MTY3NDc0NTQyNCwiZXhwIjoxNzA2MjgxNDI0LCJzdWIiOiIxMyIsInNjb3BlcyI6W119.ahijn0D37cmTKtlSsDon3Rds7czxnSZGBIHRsbo05AmkcrbUUxrtVOatIaG7SRKIZyc87FuQC6PmdeUR9GEcCZSWC5780O-cTvq8MQyXXNinRjRPcT1uxteFb0Cq0lzDe8kVEr4fo1DKD9X6AvCAjjSRY0RytLQu5J996s0PxP6YUexXi2xubomXzQc3dmcO9Q8qqgBMqExPs_lV79bY07C25ZsdHzMz7zfTUPmKttPWQUWZ_9ApluFC7oMFVIUsbLc9wNcXx6lEUCou5jAztfClZShZ6Y1ELjcgnQHL_7R-vU2gKSp3xki0qHkcJRYxn3EVleXnUJThN69ss_w3JhlXI-4eqX9SnVSkwjXvjINtfugP0rqJp-NfxykdWQ3uaAi-deAJAJ753K20Z1hgVle1t-jTua1AVmyjyk8xuZK42Rnvho8CsdeOTTyfY13JAXZ5YmExPabbWVyQaauU-BOkeb4POl2sS91wOxOKGtbopGOdwzKAyS7EUvjqamH-qiUtd60alqgi9Tzc8elBfvbrZu6WHQgBugOoDhSm--iZAhRsEggObJC_HaQhhjlh8qKlhkgG7Sip09bojBmGcOehH_Hw3t4s_Nx4yMJxZ4hxb215qXxfDcPNBBs5DThnN1cJwXg6-SuaPi9bOoHX1DPwVcembTiOCRKCM1LaJBY';

class SimpleBlocDelegate extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocDelegate();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  ).then(
    (_) => runApp(new MyApp()),
  );
}

class MyApp extends StatefulWidget {
  static setCustomeTheme(BuildContext context, int index, {Color? color}) {
    final _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.setCustomeTheme(index, color: color!);
  }

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    Utils.phoneVerificationBloc =
        PhoneVerificationBloc(PhoneVerificationBlocState.initial());
    Utils.phoneVerificationBloc!.onInisialList("91", "phoneNoData");
    FirstTime.getValues();
    super.initState();
  }

  void setCustomeTheme(int index, {Color? color}) {
    if (index == 6) {
      setState(() {
        AllCoustomTheme.isLight = true;
      });
    } else if (index == 7) {
      setState(() {
        AllCoustomTheme.isLight = false;
      });
    }
    setState(() {
      Utils.colorsIndex = index;
      Utils.primaryColorString = color != null ? color : Color(0xFF4FBE9F);
      Utils.secondaryColorString = Utils.primaryColorString;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness:
          AllCoustomTheme.isLight ? Brightness.dark : Brightness.light,
    ));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: BottomNavProvider()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => SignUpViewModel()),
        ChangeNotifierProvider(create: (_) => SocialLoginViewModel()),

        // ChangeNotifierProvider.value(value: LoginViewModel()),
        // ChangeNotifierProvider.value(value: SignUpViewModel()),
        // ChangeNotifierProvider.value(value: SocialLoginViewModel()),
      ],
      child: Container(
        color: Color(0xff081c3f),
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppConstant.AppName,
          theme: AllCoustomTheme.getThemeData(),
          routes: routes,
          // home: NewMatchSetup(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  var routes = <String, WidgetBuilder>{
    Routes.SPLASH: (BuildContext context) => new SplashScreen(),
    Routes.LOGIN: (BuildContext context) => new LoginScreen(),
    Routes.TAB: (BuildContext context) => new TabScreen(),
    Routes.OTP: (BuildContext context) => new OtpValidationScreen(),
    Routes.CameraPickerRoute: (BuildContext context) =>
        new CustomImagePickerScreen(),
  };
}
