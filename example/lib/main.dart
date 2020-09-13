import 'package:flutter/material.dart';
import 'floating.dart';
import 'rotatable.dart';
import 'floating_and_rotating.dart';

void main() {
  runApp(
      MaterialApp(home: MyApp(), theme: ThemeData(primarySwatch: Colors.blue)));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Flutter Rotatable Floating')),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
                minWidth: 200,
                padding: EdgeInsets.symmetric(vertical: 10),
                splashColor: Colors.blueAccent,
                color: Colors.lightBlueAccent,
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute<RotatableExample>(
                          builder: (BuildContext con) => RotatableExample()));
                },
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(text: 'Rotatable'),
                    WidgetSpan(
                        child: Icon(
                      Icons.touch_app,
                      color: Colors.blueGrey,
                    ))
                  ]),
                )),
            FlatButton(
                minWidth: 200,
                padding: EdgeInsets.symmetric(vertical: 10),
                splashColor: Colors.blueAccent,
                color: Colors.lightBlueAccent,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute<FloatingExample>(
                      builder: (BuildContext con) => FloatingExample()));
                },
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(text: 'Floating'),
                    WidgetSpan(
                        child: Icon(
                      Icons.touch_app,
                      color: Colors.blueGrey,
                    ))
                  ]),
                )),
            FlatButton(
                minWidth: 200,
                padding: EdgeInsets.symmetric(vertical: 10),
                splashColor: Colors.blueAccent,
                color: Colors.lightBlueAccent,
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute<FloatingAndRotatingExample>(
                          builder: (BuildContext con) =>
                              FloatingAndRotatingExample()));
                },
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: 'Floating and rotating'
                            ''),
                    WidgetSpan(
                        child: Icon(
                      Icons.touch_app,
                      color: Colors.blueGrey,
                    ))
                  ]),
                ))
          ],
        )));
  }
}
