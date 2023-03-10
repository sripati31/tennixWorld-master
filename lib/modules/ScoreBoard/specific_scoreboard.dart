import 'package:TennixWorldXI/constant/themes.dart';
import 'package:TennixWorldXI/models/MyModels/scorebard_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SpecificScoreView extends StatefulWidget {
  SpecificScoreView({super.key});

  @override
  State<SpecificScoreView> createState() => _SpecificScoreViewState();
}

class _SpecificScoreViewState extends State<SpecificScoreView> {
  List<LiveScoreboardModel> teaminfo = [];

  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getteamInfo();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(200, 3, 189, 245),
        body: isLoading
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: CircularProgressIndicator(),
                  )
                ],
              )
            : ListView(
                padding: EdgeInsets.zero,
                children: [
                  // Stack(
                  //   children: [
                  //     Container(
                  //       width: double.infinity,
                  //       height: 100,
                  //     ),
                  //     Positioned(
                  //       top: 20,
                  //       child: Container(
                  //         width: MediaQuery.of(context).size.width * 0.5,
                  //         height: 70,
                  //         decoration: BoxDecoration(
                  //           color: Colors.blueAccent,
                  //           borderRadius: BorderRadius.only(
                  //             bottomLeft: Radius.circular(80),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     Positioned(
                  //       right: 0,
                  //       top: 20,
                  //       child: Container(
                  //         width: MediaQuery.of(context).size.width * 0.5,
                  //         height: 70,
                  //         decoration: BoxDecoration(
                  //           color: Colors.redAccent,
                  //           borderRadius: BorderRadius.only(
                  //             bottomRight: Radius.circular(80),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     Positioned(
                  //         left: MediaQuery.of(context).size.width * 0.32,
                  //         child: Column(
                  //           children: [
                  //             Container(
                  //               width: 130,
                  //               height: 40,
                  //               decoration: BoxDecoration(
                  //                 color: Colors.black,
                  //                 border: Border.all(
                  //                   color: Color.fromARGB(255, 249, 250, 250),
                  //                   width: 1,
                  //                 ),
                  //                 borderRadius: BorderRadius.only(
                  //                   topRight: Radius.circular(30),
                  //                   topLeft: Radius.circular(30),
                  //                 ),
                  //               ),
                  //               child: Center(
                  //                 child: Text(
                  //                   'Pakistan'.toUpperCase(),
                  //                   style: TextStyle(
                  //                     color: Colors.white,
                  //                     fontWeight: FontWeight.bold,
                  //                     fontSize: 16,
                  //                   ),
                  //                 ),
                  //               ),
                  //             ),
                  //             Container(
                  //               width: 150,
                  //               height: 40,
                  //               decoration: BoxDecoration(
                  //                 color: Colors.black,
                  //                 border: Border.all(
                  //                   color: Color.fromARGB(255, 249, 250, 250),
                  //                   width: 1,
                  //                 ),
                  //                 borderRadius: BorderRadius.only(
                  //                   bottomRight: Radius.circular(40),
                  //                   bottomLeft: Radius.circular(40),
                  //                 ),
                  //               ),
                  //               child: Center(
                  //                 child: Text(
                  //                   '150 - 4',
                  //                   style: TextStyle(
                  //                     color: Colors.white,
                  //                     fontWeight: FontWeight.bold,
                  //                     fontSize: 20,
                  //                   ),
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ))
                  //   ],
                  // ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 100,
                          height: 60,
                          child: ClipOval(
                            child: Image.asset('assets/23.png'),
                          ),
                        ),
                        Text(
                          'Pakistan',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: ListView.builder(
                        itemCount: 11,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Column(
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height * 0.063,
                                  margin: EdgeInsets.zero,
                                  decoration: BoxDecoration(border: Border.all(color: Colors.white)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 10,
                                        height: 40,
                                        // margin: EdgeInsets.only(right: 5),
                                        // child: Center(
                                        //   child: Text(
                                        //     '${index + 1}',
                                        //     style: TextStyle(
                                        //       color: Colors.white,
                                        //       fontWeight: FontWeight.bold,
                                        //       fontSize: 14,
                                        //     ),
                                        //   ),
                                        // ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          'playername',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      index % 3 == 0
                                          ? Expanded(
                                              flex: 2,
                                              child: Text(
                                                'C catchplayername',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            )
                                          : Expanded(
                                              flex: 2,
                                              child: Text(
                                                '',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                      index % 3 == 0
                                          ? Expanded(
                                              flex: 2,
                                              child: Text(
                                                '',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            )
                                          : Expanded(
                                              flex: 2,
                                              child: Text(
                                                'C&B bowlername',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          width: 40,
                                          height: 40,
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  '2',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Text(
                                                  '10',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Extra Run : 20',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              'Over : 34.5',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              'Total : 180',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  void getteamInfo() async {
    try {
      // print('get team');
      // teaminfo.clear();
      // var response = await Dio().get('https://dream11.tennisworldxi.com/api/team/players/${widget.team_id}');
      // var teamname = response.data['team']['name'];
      // List playerList = response.data['players'];
      // for (int i = 0; i < playerList.length; i++) {
      //   teaminfo.add(
      //     LiveScoreboardModel(
      //       bowl: playerList[i]['total_balls'],
      //       bowlername: playerList[i]['player_name'],
      //       catchplayername: playerList[i]['player_name'],
      //       playername: playerList[i]['player_name'],
      //       runs: playerList[i]['total_runs'],
      //       teamname: teamname,
      //     ),
      //   );
      // }
      isLoading = false;
      setState(() {});
    } catch (e) {}
  }
}
