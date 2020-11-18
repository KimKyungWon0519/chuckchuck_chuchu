import 'package:chuckchuck_chuchu/pages/supportPages/profile_page.dart';
import 'package:chuckchuck_chuchu/provider/colorProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerPage extends StatefulWidget {
  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    return SafeArea(
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        child: Drawer(
          child: Container(
            color: colorProvider.drawColor,
            child: Column(
              children: [
                DrawerHeader(
                    child: Text(
                  'Menu',
                      style: TextStyle(color: colorProvider.textColor, fontSize: 30),
                )),
                ListTile(
                  title: Text('프로필',style: TextStyle(color: colorProvider.textColor),),
                  leading: ImageIcon(AssetImage('images/icons/profile_icon.png')),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(),)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
