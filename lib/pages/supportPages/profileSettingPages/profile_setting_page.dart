import 'package:chuckchuck_chuchu/pages/supportPages/profileSettingPages/change_profile_image.dart';
import 'package:chuckchuck_chuchu/pages/supportPages/profileSettingPages/pwd_reset_page.dart';
import 'package:chuckchuck_chuchu/provider/colorProvider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'chage_display_name_page.dart';

class ProfileSettingPage extends StatefulWidget {
  @override
  _ProfileSettingPageState createState() => _ProfileSettingPageState();
}

class _ProfileSettingPageState extends State<ProfileSettingPage> {
  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("내 정보 변경"),
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
                child: ListTile(
                  title: Text('이름 변경', style: TextStyle(color: colorProvider.textColor),),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ChangeDisplayNamePage(),)),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                    color: colorProvider.cardColor,
                    borderRadius: BorderRadius.circular(30)),
                child: ListTile(
                    title: Text('비밀번호 변경', style: TextStyle(color: colorProvider.textColor),),
                    trailing: Icon(Icons.exit_to_app),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PwdResetPage(),)),
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
