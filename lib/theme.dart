import 'package:flutter/material.dart';


class ClassTheme extends StatelessWidget {
  Icon test = Icon(Icons.flight_outlined);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Nom du thème"),
        ),
        body: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:[
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.flight_outlined)),
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.flight_outlined)),
              IconButton(
                  onPressed: () {},
                  icon: test,
                  tooltip: 'Avion')
          ],
            )
          ),
        //GridView()

      )
    );



  }
}