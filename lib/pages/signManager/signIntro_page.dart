import 'package:chuckchuck_chuchu/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'sing_up.dart';
import 'sign_in.dart';

class SignIntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('sign intro');
    final provider = Provider.of<LoginProvider>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.grey.withOpacity(0.6), BlendMode.dstATop),
                image: AssetImage('images/background/signPage_background.png'),
                fit: BoxFit.fill),
          ),
          child: Container(
            margin: EdgeInsets.all(30),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome To',
                        style: TextStyle(fontSize: 30, color: Colors.white, fontFamily: 'Rotobo'),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Image.asset(
                        'images/logo/text_logo.png',
                        color: Colors.white,
                        width: size.width / 4,
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 50,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            onPressed: () => showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                      child: SignInPage(),
                                    )),
                            color: Color.fromRGBO(0, 133, 255, 1),
                            child: Text(
                              '로그인',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          height: 50,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            onPressed: () async {
                              showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                  child: SignUpPage(),
                                ),
                              );
                            },
                            color: Color.fromRGBO(0, 133, 255, 1),
                            child: Text(
                              '회원가입',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
