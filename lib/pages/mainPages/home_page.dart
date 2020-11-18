import 'package:chuckchuck_chuchu/provider/colorProvider.dart';
import 'package:chuckchuck_chuchu/provider/socketProvider.dart';
import 'package:chuckchuck_chuchu/ui/profile_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    final size = MediaQuery.of(context).size;
    final socketProvider = Provider.of<SocketProvider>(context);

    return Container(
      height: double.infinity,
      width: double.infinity,
      margin: EdgeInsets.all(20),
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  socketProvider.imagePath,
                  width: size.width / 2,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  socketProvider.infoMessage,
                  style: TextStyle(color: colorProvider.textColor),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 40, bottom: 40),
              child: Card(
                color: colorProvider.cardColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Container(
                  margin: EdgeInsets.all(20),
                  height: double.infinity,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '내 디바이스',
                            style: TextStyle(color: colorProvider.textColor),
                          ),
                          Expanded(child: Container()),
                          socketProvider.isConnected == true
                              ? InkWell(
                                  child: Text('해체'),
                                  onTap: () =>
                                      socketProvider.disconnectFromServer(),
                                )
                              : Container(),
                        ],
                      ),
                      Center(
                        child: socketProvider.isConnected == true
                            ? Image.asset(
                                'images/icons/device_icon.png',
                                width: size.width / 3,
                              )
                            : connectButton(socketProvider, colorProvider),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget connectButton(
      SocketProvider socketProvider, ColorProvider colorProvider) {
    return IconButton(
      iconSize: 50,
      color: colorProvider.iconColor,
      icon: Center(child: Icon(Icons.add)),
      onPressed: () => socketProvider.connectToServer(),
    );
  }
}
