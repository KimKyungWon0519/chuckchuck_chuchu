import 'package:chuckchuck_chuchu/provider/colorProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AllStretchingViewPage extends StatefulWidget {
  @override
  _AllStretchingViewPageState createState() => _AllStretchingViewPageState();
}

class _AllStretchingViewPageState extends State<AllStretchingViewPage> {
  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('더보기'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Url').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data.documents;

            return Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: colorProvider.cardColor,
                    child: ListTile(
                      title: Text(
                        data[index]['name'],
                        style: TextStyle(color: colorProvider.textColor),
                      ),
                      onTap: () async {
                        var url = data[index]['url'];

                        if(await canLaunch(url)) {
                          await launch(url);
                        }
                      },
                    ),
                  );
                }
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      backgroundColor: colorProvider.backgroundColor,
    );
  }
}
