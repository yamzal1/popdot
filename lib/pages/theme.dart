import 'package:flutter/material.dart';

class ClassTheme extends StatelessWidget {
  const ClassTheme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Icon test = const Icon(Icons.flight_outlined);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Theme name"),
        ),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.flight_outlined)),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.flight_outlined)),
              IconButton(onPressed: () {}, icon: test, tooltip: 'Avion')
            ],
          ),
        ),
      ),
    );
  }
}
