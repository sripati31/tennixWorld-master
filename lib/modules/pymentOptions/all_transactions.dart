// ignore_for_file: unused_field, unnecessary_null_comparison, deprecated_member_use

import 'package:TennixWorldXI/modules/pymentOptions/Winning_screen.dart';
import 'package:TennixWorldXI/modules/pymentOptions/manage_payment.dart';
import 'package:TennixWorldXI/modules/pymentOptions/withdraw.dart';
import 'package:TennixWorldXI/modules/pymentOptions/withdrawScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../utils/toast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:TennixWorldXI/api/apiProvider.dart';
import 'package:TennixWorldXI/constant/constants.dart';
import 'package:TennixWorldXI/constant/themes.dart';
import 'package:TennixWorldXI/models/scheduleResponseData.dart';
import 'package:TennixWorldXI/models/userData.dart';
import 'package:TennixWorldXI/modules/contests/contestsScreen.dart';

class AllTransactions extends StatefulWidget {
  final String? paymetMoney;
  final entryFees;
  final ShedualData? shedualData;
  final bool? isOnlyAddMoney;
  final VoidCallback? isTruePayment;

  const AllTransactions({Key? key, this.paymetMoney, this.shedualData, this.isOnlyAddMoney = false, this.entryFees, this.isTruePayment}) : super(key: key);
  @override
  _AllTransactionsState createState() => _AllTransactionsState();
}

class _AllTransactionsState extends State<AllTransactions> {
  var paymet = '';
  var isProsses = false;
  var paymentController = new TextEditingController();
  UserData userData = new UserData();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var cashBonus = '';
  late Razorpay _razorpay;

  @override
  void initState() {
    if (widget.paymetMoney != null) {
      paymet = '${double.tryParse(widget.paymetMoney!)!.toInt()}';
    }
    paymentController.text = paymet;
    getUserData();
    super.initState();

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    CustomToast.showToast(message: "SUCCESS: " + response.paymentId!);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    CustomToast.showToast(
      message: "ERROR: " + response.code.toString() + " - " + response.message!,
    );
    print(response.message);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    CustomToast.showToast(message: "EXTERNAL_WALLET: " + response.walletName!);
  }

  @override
  void dispose() {
    super.dispose();
    paymentController.dispose();
    _razorpay.clear();
  }

  static final String tokenizationKey = 'sandbox_8hxpnkht_kzdtzv2btm4p7s5j';

  void getUserData() async {
    setState(() {
      isProsses = true;
    });
    var responseData = await ApiProvider().drawerInfoList();
    if (responseData != null) {
      userData = responseData.data!;
    }
    if (!widget.isOnlyAddMoney!) {
      if ((double.tryParse(widget.entryFees)! * 0.20) < double.tryParse(userData.cashBonus!)!) {
        cashBonus = '${double.tryParse(widget.entryFees)! * 0.20}';
      } else {
        cashBonus = '${double.tryParse(userData.cashBonus!)}';
      }
    }
    setState(() {
      isProsses = false;
    });
  }

  void openPaymentOption() async {
    var options = {
      'key': 'rzp_test_ZAO3p5KJhdTKpQ',
      'amount': 10000,
      'name': 'Add Amount',
      'description': 'Test',
      'prefill': {'contact': '', 'email': ''},
      'external': {
        'wallets': ['paytm']
      },
      "colors": "#008080",
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
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
              key: _scaffoldKey,
              backgroundColor: AllCoustomTheme.getThemeData().backgroundColor,
              body: ModalProgressHUD(
                inAsyncCall: isProsses,
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
                                          'All Transactions',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 24,
                                            fontWeight: FontWeight.w500,
                                            color: AllCoustomTheme.getThemeData().backgroundColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: AppBar().preferredSize.height,
                                    ),
                                  ],
                                ),
                              ),
                              widget.shedualData != null ? MatchHadder() : SizedBox(),
                            ],
                          ),
                        ),
                        Expanded(
                          child: userData != null
                              ? SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.only(left: 16.0, right: 16, bottom: 16, top: 16),
                                            child: Row(
                                              children: <Widget>[
                                                Text(
                                                  'Current Balance',
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: SizedBox(),
                                                ),
                                                userData != null
                                                    ? Text(
                                                        '₹720',
                                                        style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                          color: AllCoustomTheme.getThemeData().primaryColor,
                                                          fontSize: AppConstant.SIZE_TITLE18,
                                                        ),
                                                      )
                                                    : Container(
                                                        width: 12,
                                                        height: 12,
                                                        child: CircularProgressIndicator(
                                                          strokeWidth: 2.0,
                                                          valueColor: AlwaysStoppedAnimation<Color>(
                                                            AllCoustomTheme.getBlackAndWhiteThemeColors(),
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
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (_) => ManagePayment()));
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          height: 60,
                                          margin: EdgeInsets.all(5),
                                          child: Card(
                                              elevation: 5,
                                              borderOnForeground: true,
                                              child: Padding(
                                                padding: EdgeInsets.all(10),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Manage Payment',
                                                      style: TextStyle(fontSize: 18),
                                                    ),
                                                    Icon(
                                                      Icons.arrow_forward_ios,
                                                      size: 20,
                                                    ),
                                                  ],
                                                ),
                                              )),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(WinningScreen());
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          height: 60,
                                          margin: EdgeInsets.all(5),
                                          child: Card(
                                              elevation: 5,
                                              borderOnForeground: true,
                                              child: Padding(
                                                padding: EdgeInsets.all(10),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Winning',
                                                      style: TextStyle(fontSize: 18),
                                                    ),
                                                    Icon(
                                                      Icons.arrow_forward_ios,
                                                      size: 20,
                                                    ),
                                                  ],
                                                ),
                                              )),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(WithdrawContestRecord());
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          height: 60,
                                          margin: EdgeInsets.all(5),
                                          child: Card(
                                              elevation: 5,
                                              borderOnForeground: true,
                                              child: Padding(
                                                padding: EdgeInsets.all(10),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Withdraw',
                                                      style: TextStyle(fontSize: 18),
                                                    ),
                                                    Icon(
                                                      Icons.arrow_forward_ios,
                                                      size: 20,
                                                    ),
                                                  ],
                                                ),
                                              )),
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 60,
                                        margin: EdgeInsets.all(5),
                                        child: Card(
                                            elevation: 5,
                                            borderOnForeground: true,
                                            child: Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    'Join Contest',
                                                    style: TextStyle(fontSize: 18),
                                                  ),
                                                  Icon(
                                                    Icons.arrow_forward_ios,
                                                    size: 20,
                                                  ),
                                                ],
                                              ),
                                            )),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 60,
                                        margin: EdgeInsets.all(5),
                                        child: Card(
                                            elevation: 5,
                                            borderOnForeground: true,
                                            child: Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    'Refund',
                                                    style: TextStyle(fontSize: 18),
                                                  ),
                                                  Icon(
                                                    Icons.arrow_forward_ios,
                                                    size: 20,
                                                  ),
                                                ],
                                              ),
                                            )),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 60,
                                        margin: EdgeInsets.all(5),
                                        child: Card(
                                            elevation: 5,
                                            borderOnForeground: true,
                                            child: Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    'Cancel Matches',
                                                    style: TextStyle(fontSize: 18),
                                                  ),
                                                  Icon(
                                                    Icons.arrow_forward_ios,
                                                    size: 20,
                                                  ),
                                                ],
                                              ),
                                            )),
                                      )
                                    ],
                                  ),
                                )
                              : SizedBox(),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void showInSnackBar(String value) {
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

  void showInSnackBars(String value) {
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
        backgroundColor: Colors.green,
      ),
    );
  }
}
