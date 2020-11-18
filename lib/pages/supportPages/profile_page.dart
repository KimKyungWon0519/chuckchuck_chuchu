import 'package:chuckchuck_chuchu/pages/signManager/signIntro_page.dart';
import 'package:chuckchuck_chuchu/provider/colorProvider.dart';
import 'package:chuckchuck_chuchu/provider/login_provider.dart';
import 'package:chuckchuck_chuchu/ui/profile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    final loginProvider = Provider.of<LoginProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('내 정보'),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              ProfileCard(),
              SizedBox(
                height: 10,
              ),
              Text(
                '당신의 등급은 일반입니다.',
                style: TextStyle(color: colorProvider.textColor),
              ),
              Expanded(child: Container()),
              Row(
                children: [
                  Expanded(child: Container()),
                  FlatButton(
                    onPressed: () {
                      loginProvider.signOut();
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Text(
                          '로그아웃',
                          style: TextStyle(color: colorProvider.textColor),
                        ),
                        Icon(
                          Icons.exit_to_app,
                          color: colorProvider.iconColor,
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      backgroundColor: colorProvider.backgroundColor,
    );
  }
}
