import 'package:chuckchuck_chuchu/provider/colorProvider.dart';
import 'package:chuckchuck_chuchu/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final formkey = GlobalKey<FormState>();
String email;

class PwdResetPage extends StatefulWidget {
  @override
  _PwdResetPageState createState() => _PwdResetPageState();
}

class _PwdResetPageState extends State<PwdResetPage> {
  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    final loginProvider = Provider.of<LoginProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('비밀번호 변경'),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                TextFormField(
                  style: TextStyle(color: colorProvider.menuColor, fontFamily: 'Rotobo'),
                  validator: (value) {
                    if(value.isEmpty) {
                      return '이메일을 입력해주세요';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (newValue) => email = newValue,
                  decoration: InputDecoration(
                      hintText: '이메일',
                      hintStyle: TextStyle(color: colorProvider.menuColor),
                      enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: colorProvider.menuColor))),
                ),
                Expanded(child: Container()),
                Container(
                  child: RaisedButton(
                    onPressed: () async {
                      if(formkey.currentState.validate()) {
                        formkey.currentState.save();

                        await showDialog(context: context, builder: (context) {
                          return AlertDialog(content: Text('이메일을 확인해주세요'),);
                        },);

                        Navigator.pop(context);
                        loginProvider.sendPasswordResetEmail(email);
                      }
                    },
                    child: Text(
                      '변경',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.deepPurpleAccent,
                  ),
                  width: double.infinity,
                )
              ],
            ),
          ),
        ),
      ),
      backgroundColor: colorProvider.backgroundColor,
    );
  }
}
