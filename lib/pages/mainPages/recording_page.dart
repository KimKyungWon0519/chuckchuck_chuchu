import 'package:chuckchuck_chuchu/provider/colorProvider.dart';
import 'package:chuckchuck_chuchu/provider/login_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_chart/charts/line-chart.widget.dart';
import 'package:line_chart/model/line-chart.model.dart';
import 'package:provider/provider.dart';

String strDateTime = null;
String strRecord = null;

class RecordingPage extends StatefulWidget {
  @override
  _RecordingPageState createState() => _RecordingPageState();
}

class _RecordingPageState extends State<RecordingPage> {

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    final size = MediaQuery.of(context).size;

    return StreamBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<LineChartModel> dataList = List();

          for (var data in snapshot.data.documents) {
            Timestamp timestamp = data['datetime'];
            DateTime dateTime = timestamp.toDate();
            dataList.add(LineChartModel(amount: data['data'], date: dateTime));
          }

          return Container(
            height: double.infinity,
            width: double.infinity,
            margin: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LineChart(
                  width: size.width,
                  height: size.height / 2.5,
                  data: dataList,
                  linePaint: Paint()
                    ..strokeWidth = 3
                    ..style = PaintingStyle.stroke
                    ..color = colorProvider.textColor,
                  showPointer: true,
                  showCircles: true,
                  circlePaint: Paint()..color = colorProvider.textColor,
                  onValuePointer: (LineChartModelCallback value) {
                    setState(() {
                      strDateTime =
                          DateFormat('MM월 dd일').format(value.chart.date);
                      strRecord = value.chart.amount.toStringAsFixed(2);
                    });
                  },
                  insidePadding: 20,
                ),
                SizedBox(height: 20,),
                Text('${strDateTime??'날짜'} - ${strRecord??'자세 기록'}', style: TextStyle(color: colorProvider.textColor),),
              ],
            ),
          );
        } else {
          return Center(
            child: Text('기록된 자세가 없습니다.'),
          );
        }
      },
      stream: FirebaseFirestore.instance
          .collection('position_record')
          .where('uid', isEqualTo: LoginProvider.userInformation.uid)
          .snapshots(),
    );
  }
}

class DataList {
  final DateTime time;
  final double record;

  DataList(this.time, this.record);
}
