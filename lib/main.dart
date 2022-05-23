import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: null,
        backgroundColor: const Color(0xffe4e5e7),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('images/logo.png'),
            const Padding(
              padding: EdgeInsets.only(left: 16.0, top: 64.0),
              child: Text(
                'Thèmes',
                style: TextStyle(fontSize: 35),
              ),
            ),
            Flexible(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 160.0,
                      height: 160.0,
                      child: Card(
                        child: Text('Hey'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
