import 'package:chuckchuck_chuchu/provider/colorProvider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ChangeProfileImagePage extends StatefulWidget {
  @override
  _ChangeProfileImagePageState createState() => _ChangeProfileImagePageState();
}

class _ChangeProfileImagePageState extends State<ChangeProfileImagePage> {
  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);

    return Container(
      child: Wrap(
        children: [
          ListTile(
            title: Text('사진에서 가져오기',),
            onTap: () {},
          ),
          ListTile(
            title: Text('카메라에서 촬영하기',),
            onTap: () {
              ImagePicker().getImage(source: ImageSource.camera);
            },
          )
        ],
      ),
    );
  }
}
