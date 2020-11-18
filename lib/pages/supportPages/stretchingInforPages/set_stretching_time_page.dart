import 'package:chuckchuck_chuchu/provider/colorProvider.dart';
import 'package:chuckchuck_chuchu/shared_preferences/dateTime_sharedPreferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

DateTime setTime;

class SetStretchingTimePage extends StatefulWidget {
  @override
  _SetStretchingTimePageState createState() => _SetStretchingTimePageState();
}

class _SetStretchingTimePageState extends State<SetStretchingTimePage> {
  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    final dateTimeSharedPreferences = Provider.of<DateTimeSharedPreferences>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('시간 간격 설정'),
      ),
      body: Container(
        margin: EdgeInsets.only(bottom: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Container()),
            TimePickerSpinner(
              time: DateFormat('yyyy-MM-dd hh:mm:ss')
                  .parse(dateTimeSharedPreferences.dateTime),
              itemWidth: 100,
              normalTextStyle: TextStyle(color: colorProvider.iconColor, fontSize: 40),
              highlightedTextStyle: TextStyle(color: colorProvider.textColor, fontSize: 40),
              onTimeChange: (time) => setTime = time,
            ),
            Expanded(child: Container()),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              onPressed: () {
                dateTimeSharedPreferences.setPreferences(setTime.toString());
                Navigator.pop(context);
              },
              child: Text(
                '저장',
                style: TextStyle(color: Colors.white),
              ),
              color: colorProvider.buttonColor,
            ),
          ],
        ),
      ),
      backgroundColor: colorProvider.backgroundColor,
    );
  }
}
