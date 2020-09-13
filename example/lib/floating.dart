import 'package:flutter/material.dart';
import 'package:rotatable/bouncing_avatar.dart';

class FloatingExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Floating')),
        body: Center(
            child: BouncingAvatar(Container(
                child: Icon(
                  Icons.touch_app,
                  semanticLabel:
                      'Touch and move object to see effect. Click to see bounce effect.',
                  color: Colors.blueGrey,
                ),
                width: 150,
                height: 150,
                color: Colors.lightBlueAccent))));
  }
}
