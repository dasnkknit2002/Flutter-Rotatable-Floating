import 'package:flutter/material.dart';
import 'package:rotatable/rotatable.dart';

class RotatableExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Rotatable')),
        body: Center(
            child: Rotatable(Container(
                child: Icon(
                  Icons.,
                  color: Colors.blueGrey,
                ),
                width: 150,
                height: 150,
                color: Colors.lightBlueAccent))));
  }
}
