import 'package:chuckchuck_chuchu/provider/colorProvider.dart';
import 'package:chuckchuck_chuchu/provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final formkey = GlobalKey<FormState>();
String displayName;

class ChangeDisplayNamePage extends StatefulWidget {
  @override
  _ChangeDisplayNamePageState createState() => _ChangeDisplayNamePageState();
}

class _ChangeDisplayNamePageState extends State<ChangeDisplayNamePage> {
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
                      return '이름을 입력해주세요';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (newValue) => displayName = newValue,
                  decoration: InputDecoration(
                      hintText: '이름',
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

                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) => Dialog(
                            insetPadding: EdgeInsets.all(80),
                            child: Container(
                              margin: EdgeInsets.all(50),
                              child: CircularProgressIndicator(),
                              height: 150,
                            ),
                          ),
                        );

                        await loginProvider.changeDisplayName(displayName);

                        Navigator.pop(context);
                        Navigator.pop(context);
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
