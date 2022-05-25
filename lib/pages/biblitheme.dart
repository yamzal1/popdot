import 'package:flutter/material.dart';

class BibliTheme extends StatelessWidget {
  Icon test = Icon(Icons.flight_outlined);
  @override
  Widget build(BuildContext context) {
    const title = 'Bibliothèque thèmes lksqjzql';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(title),
        ),
        body: GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 5,
          // Generate 100 widgets that display their index in the List.
          children: List.generate(25, (index) {
            return Center(
              child: Text(
                'Item $index',
                style: Theme.of(context).textTheme.headline5,
              ),
            );
          }),
        ),
      ),
    );
  }
}
