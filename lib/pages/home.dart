import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:popdot/pages/listingSounds.dart';
import 'package:popdot/pages/theme.dart';
import 'package:popdot/theme/appcolors.dart';
import 'package:popdot/widgets/liste_sons.dart';
import 'package:popdot/pages/biblitheme.dart';
import 'package:popdot/pages/details.dart';

import '../database/firebase_tools.dart';
import 'FormuSons.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //static const String boitesons = 'sounds';
  static const String boitesons = 'sounds';



  int _selectedIndex = 0;

  final _pageOptions  = [
    new HomePage(),
    new Details(),
    new AnimatedPage(),
    new ClassTheme(),
    new BibliTheme(),

  ];




  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
            SizedBox(
              height: 300,
              child: Flexible(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 300.0,
                        child: Card(
                          child: OutlinedButton(
                            child: Text('UPLOAD FILE'),
                            onPressed: () async {
                              var picked = await FilePicker.platform.pickFiles();

                              if (picked != null) {
                                final fileBytes = picked.files.first.bytes;
                                final fileName = picked.files.first.name;
                                if (fileName.toString().endsWith(".mp3") ||
                                    fileName.toString().endsWith(".m4a")) {
                                  addSound(fileName, fileBytes);
                                }
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 300.0,
                        child: Card(
                          child: OutlinedButton(
                            child: Text('Charger une image'),
                            onPressed: () async {
                              var picked = await FilePicker.platform.pickFiles();

                              if (picked != null) {
                                final fileBytes = picked.files.first.bytes;
                                final fileName = picked.files.first.name;
                                if (fileName.toString().endsWith(".jpg") ||
                                    fileName.toString().endsWith(".png")) {
                                  addImage(fileName, fileBytes);
                                }
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 300.0,
                        child: Card(
                          child: Builder(
                            builder: (context) {
                              return OutlinedButton(
                                child: Text('+'),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => MyCustomForm()),
                                    );
                                  },
                              );
                            }
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
