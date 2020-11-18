import 'dart:async';

import 'package:chuckchuck_chuchu/pages/mainPages/home_page.dart';
import 'package:chuckchuck_chuchu/pages/mainPages/recording_page.dart';
import 'package:chuckchuck_chuchu/pages/mainPages/stretching_page.dart';
import 'package:chuckchuck_chuchu/pages/supportPages/drawer_page.dart';
import 'package:chuckchuck_chuchu/provider/colorProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'supportPages/setting_page.dart';

List titles = ['실시간 자세', '자세 기록', '스트레칭 간격'];
List pages = [HomePage(), RecordingPage(), StretchingPage()];
int index = 0;

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);


    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(titles[index]),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingPage())))
        ],
      ),
      drawer: DrawerPage(),
      body: SafeArea(
        child: pages[index],
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Color.fromRGBO(105, 105, 105, 1),
        selectedItemColor: colorProvider.BNColor,
        backgroundColor: colorProvider.backgroundColor,
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('images/icons/home_icon.png')),
              label: '현재 자세'),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('images/icons/recording_icon.png')),
              label: '자세 기록'),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('images/icons/stretching_icon.png')),
              label: '스트레칭'),
        ],
      ),
      backgroundColor: colorProvider.backgroundColor,
    );
  }
}
