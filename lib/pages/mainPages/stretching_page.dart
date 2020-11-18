import 'package:chuckchuck_chuchu/pages/supportPages/stretchingInforPages/AllStretchingViewPage.dart';
import 'package:chuckchuck_chuchu/pages/supportPages/stretchingInforPages/set_stretching_time_page.dart';
import 'package:chuckchuck_chuchu/provider/colorProvider.dart';
import 'package:chuckchuck_chuchu/shared_preferences/dateTime_sharedPreferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

DateTime dateTime;
String strDateTime;

class StretchingPage extends StatefulWidget {
  @override
  _StretchingPageState createState() => _StretchingPageState();
}

class _StretchingPageState extends State<StretchingPage> {
  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    final dateTimeSharedPreferences =
        Provider.of<DateTimeSharedPreferences>(context);

    dateTime = DateFormat('yyyy-MM-dd hh:mm:ss')
        .parse(dateTimeSharedPreferences.dateTime);
    strDateTime = DateFormat('HH시간 mm분').format(dateTime);

    return Container(
      height: double.infinity,
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Url').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data.documents;

            return Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        strDateTime,
                        style: TextStyle(
                            fontSize: 50, color: colorProvider.textColor),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SetStretchingTimePage(),
                            )),
                        child: Text(
                          '편집',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: colorProvider.buttonColor,
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 3,
                  color: colorProvider.iconColor,
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.only(
                      top: 20,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              '스트레칭 컨텐츠',
                              style: TextStyle(
                                  color: colorProvider.textColor, fontSize: 25),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) => Card(
                              color: colorProvider.cardColor,
                              child: ListTile(
                                title: Text(
                                  data[index]['name'],
                                  style:
                                      TextStyle(color: colorProvider.textColor),
                                ),
                                onTap: () async {
                                  final url = data[index]['url'];

                                  if(await canLaunch(url)) {
                                    await launch(url);
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          // onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AllStretchingViewPage(),)),
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AllStretchingViewPage(),
                              )),
                          child: Text(
                            '더보기',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: colorProvider.buttonColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );

    //   Container(
    //   height: double.infinity,
    //   width: double.infinity,
    //   margin: EdgeInsets.all(40),
    //   child: Column(
    //     children: [
    //       Expanded(
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           children: [
    //             Text(
    //               strDateTime,
    //               style:
    //                   TextStyle(fontSize: 50, color: colorProvider.textColor),
    //             ),
    //             SizedBox(
    //               height: 20,
    //             ),
    //             RaisedButton(
    //               shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(30)),
    //               onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SetStretchingTimePage(),)),
    //               child: Text(
    //                 '편집',
    //                 style: TextStyle(color: Colors.white),
    //               ),
    //               color: colorProvider.buttonColor,
    //             ),
    //           ],
    //         ),
    //       ),
    //       Divider(
    //         thickness: 3,
    //         color: colorProvider.iconColor,
    //       ),
    //       Expanded(
    //         flex: 2,
    //         child: Container(
    //           margin: EdgeInsets.only(
    //             top: 20,
    //           ),
    //           child: Column(
    //             children: [
    //               Row(
    //                 children: [
    //                   Text(
    //                     '스트레칭 컨텐츠',
    //                     style: TextStyle(
    //                         color: colorProvider.textColor, fontSize: 25),
    //                   ),
    //                   Expanded(
    //                     child: Container(),
    //                   ),
    //                 ],
    //               ),
    //               SizedBox(
    //                 height: 10,
    //               ),
    //               Expanded(
    //                 child: ListView.builder(
    //                   itemBuilder: (context, index) => Card(
    //                     color: colorProvider.cardColor,
    //                     child: ListTile(
    //                       title: Text(
    //                         '이이이이이잉',
    //                         style: TextStyle(color: colorProvider.textColor),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               SizedBox(
    //                 height: 10,
    //               ),
    //               RaisedButton(
    //                 shape: RoundedRectangleBorder(
    //                     borderRadius: BorderRadius.circular(30)),
    //                // onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AllStretchingViewPage(),)),
    //                 onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TestFirebasePage(),)),
    //                 child: Text(
    //                   '더보기',
    //                   style: TextStyle(color: Colors.white),
    //                 ),
    //                 color: colorProvider.buttonColor,
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
