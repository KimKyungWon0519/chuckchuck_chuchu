import 'package:chuckchuck_chuchu/pages/supportPages/profileSettingPages/profile_setting_page.dart';
import 'package:chuckchuck_chuchu/provider/colorProvider.dart';
import 'package:chuckchuck_chuchu/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileCard extends StatefulWidget {
  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final loginProvider = Provider.of<LoginProvider>(context);
    final colorProvider = Provider.of<ColorProvider>(context);

    return Container(
      child: Card(
        color: colorProvider.cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Container(
          margin: EdgeInsets.all(10),
          height: size.height / 4,
          width: double.infinity,
          child: Stack(
            children: [
              Positioned(
                child: IconButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileSettingPage(),)),
                  icon: ImageIcon(
                    AssetImage('images/icons/edit_profile_icon.png'),
                    color: colorProvider.iconColor,
                  ),
                ),
                left: size.width - 120,
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImageIcon(
                      AssetImage('images/icons/profile_icon.png'),
                      size: size.width / 4,
                      color: colorProvider.iconColor,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      loginProvider.displayName ?? loginProvider.email,
                      style: TextStyle(color: colorProvider.textColor),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
