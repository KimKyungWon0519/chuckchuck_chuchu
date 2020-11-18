import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'login_provider.dart';

class SocketProvider with ChangeNotifier {
  Socket _clientSocket;
  String _ip = '192.168.43.215';
  bool isConnected = false;
  String infoMessage = '연결된 디바이스가 없습니다.';
  String imagePath = 'images/position_icons/normal_position.png';
  double _data;
  double _sum = 0;
  int _cnt = 0;

  SocketProvider();

  void connectToServer() async {
    await Socket.connect(_ip, 80, timeout: Duration(seconds: 5)).then((socket) {
      print('connect - $_ip');
      _clientSocket = socket;
      isConnected = true;

      socket.listen((onData) {
        DateTime newDateTime = DateTime.now();
        connectWrite('connect');
        _data = double.parse(String.fromCharCodes(onData).trim());
        _cnt++;
        _sum += _data;
        print(_data);
        if (80 < _data && _data < 120) {
          infoMessage = '좋은 자세를 유지하고 있습니다.';
          imagePath = 'images/position_icons/good_position.png';
        } else {
          infoMessage = '나쁜 자세를 유지하고 있습니다.';
          imagePath = 'images/position_icons/bad_position.png';
        }

        notifyListeners();
        print(newDateTime.difference(dateTime).inMinutes);
        if(newDateTime.difference(dateTime).inMinutes > 10) {
          dateTime = newDateTime;

          FirebaseFirestore.instance.collection('position_record').add({
                  'data': double.parse(getData()),
                  'datetime': DateTime.now().toUtc(),
                  'uid': LoginProvider.userInformation.uid
                });
        }
      }, onError: onError, );
    });

    connectWrite('connect');
  }

  void connectWrite(String string) {
    if(_clientSocket != null) {
      _clientSocket.write(string);
    }
  }

  void onError(e) {
    print("onError: $e");
    showSnackBarWithKey(e.toString());
    disconnectFromServer();
  }

  void disconnectFromServer() {
    connectWrite('disconnect');
    _clientSocket.close();
    _clientSocket = null;
    isConnected = false;
    infoMessage = '연결된 디바이스가 없습니다.';
    imagePath = 'images/position_icons/normal_position.png';


    notifyListeners();
  }

  showSnackBarWithKey(String message) {
    scaffoldKey.currentState
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(message),
        action: SnackBarAction(
          label: 'Done',
          onPressed: (){},
        ),
      ));
  }

  getData() {
    double avg = _sum / _cnt;
    _sum = 0;
    _cnt = 0;

    return avg.toStringAsFixed(2);
  }
}

final scaffoldKey = GlobalKey<ScaffoldState>();
DateTime dateTime = DateTime.now();