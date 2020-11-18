import 'package:chuckchuck_chuchu/pages/supportPages/profileSettingPages/profile_setting_page.dart';
import 'package:chuckchuck_chuchu/provider/colorProvider.dart';
import 'package:chuckchuck_chuchu/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    final loginProvider = Provider.of<LoginProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("설정"),
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: colorProvider.cardColor,
                    borderRadius: BorderRadius.circular(30)),
                child: CheckboxListTile(
                  value: colorProvider.isDarkMode,
                  onChanged: (value) => colorProvider.isDarkMode = value,
                  title: Text('다크 모드', style: TextStyle(color: colorProvider.textColor),),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    color: colorProvider.cardColor,
                    borderRadius: BorderRadius.circular(30)),
                child: ListTile(
                  title: Text('정보 변경', style: TextStyle(color: colorProvider.textColor),),
                  trailing: Icon(Icons.cached),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileSettingPage(),
                      )),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                    color: colorProvider.cardColor,
                    borderRadius: BorderRadius.circular(30)),
                child: ListTile(
                  title: Text('로그아웃', style: TextStyle(color: colorProvider.textColor),),
                  trailing: Icon(Icons.exit_to_app),
                  onTap: () {
                    loginProvider.signOut();
                    Navigator.pop(context);
                  }
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: colorProvider.backgroundColor,
    );
  }
}
