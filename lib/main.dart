import 'dart:async';

import 'package:chuckchuck_chuchu/pages/RootPage.dart';
import 'package:chuckchuck_chuchu/pages/signManager/signIntro_page.dart';
import 'package:chuckchuck_chuchu/provider/colorProvider.dart';
import 'package:chuckchuck_chuchu/provider/login_provider.dart';
import 'package:chuckchuck_chuchu/provider/socketProvider.dart';
import 'package:chuckchuck_chuchu/shared_preferences/dateTime_sharedPreferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  print('start');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('asfd');
    return Container();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('MyApp');
    // TODO: implement build
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginProvider>(
          create: (_) => LoginProvider(),
        ),
        ChangeNotifierProvider<ColorProvider>(
          create: (_) => ColorProvider(),
        ),
        ChangeNotifierProvider<SocketProvider>(
          create: (_) => SocketProvider(),
        ),
        ChangeNotifierProvider<DateTimeSharedPreferences>(
          create: (_) => DateTimeSharedPreferences(),
        ),
      ],
      child: Main(),
    );
  }
}


class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    print('Main');
    final colorProvider = Provider.of<ColorProvider>(context);
    final loginProvider = Provider.of<LoginProvider>(context);
    final dateTimeSharedPreferences =
        Provider.of<DateTimeSharedPreferences>(context);

    dateTimeSharedPreferences.initPreferences();

    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'NIXGONFONTS',
        appBarTheme: AppBarTheme(
            color: colorProvider.backgroundColor,
            iconTheme: IconThemeData(
              color: colorProvider.menuColor,
            ),
            textTheme: TextTheme(
              headline6: TextStyle(
                  color: colorProvider.menuColor,
                  fontSize: 25,
                  fontFamily: 'NIXGONFONTS'),
            ),
            elevation: 0.0),
        textTheme: TextTheme(
          bodyText1: TextStyle(
            fontSize: 15,
          ),
        ),
      ),
      title: '척척추추',
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            loginProvider.setUser(snapshot.data);
            return RootPage();
          } else {
            return SignIntroPage();
          }
        },
      ),
    );
  }
}
