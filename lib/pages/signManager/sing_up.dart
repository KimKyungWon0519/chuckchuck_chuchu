import 'package:chuckchuck_chuchu/provider/login_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

String email;
String password;
String checkPassword;

final formKey = GlobalKey<FormState>();

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Container(
          margin: EdgeInsets.all(20),
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'SignUp',
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(height: 30),
              TextFormField(
                style: TextStyle(fontFamily: 'Rotobo'),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    hintText: '이메일',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return '이메일을 입력해주세요';
                  } else
                    return null;
                },
                onSaved: (newValue) => email = newValue,
              ),
              SizedBox(height: 20),
              TextFormField(
                style:TextStyle(fontFamily: 'Rotobo'),
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    hintText: '비밀번호'),
                validator: (value) {
                  if (value.isEmpty) {
                    return '비밀번호 입력해주세요';
                  } else if (value.length < 8) {
                    return '8자 이상의 비밀번호를 입력해주세요';
                  } else {
                    checkPassword = value;
                    return null;
                  }
                },
                onSaved: (newValue) => password = newValue,
              ),
              SizedBox(height: 20),
              TextFormField(
                style: TextStyle(fontFamily: 'Rotobo'),
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    hintText: '비밀번호 확인'),
                validator: (value) {
                  if (value.isEmpty) {
                    return '비밀번호 입력해주세요';
                  } else if (checkPassword != value) {
                    return '비밀번호가 맞지 않습니다.';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 20),
              Container(
                height: 50,
                width: double.infinity,
                child: RaisedButton(
                  color: Color.fromRGBO(0,133,255,1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: () async {
                    if (formKey.currentState.validate()) {
                      formKey.currentState.save();
                      FocusScope.of(context).unfocus();
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

                      bool result = await loginProvider.signUpEmail(
                          email: email, password: password);

                      Navigator.pop(context);

                      if (result == true)
                        Navigator.pop(context);
                      else {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                              '회원가입 실패',
                            ),
                            content: Text('다시 시도 해주세요'),
                            actions: [
                              FlatButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('확인'))
                            ],
                          ),
                        );
                      }
                    }
                  },
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
    );
  }
}
