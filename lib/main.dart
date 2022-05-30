import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:popdot/pages/listingSounds.dart';
import 'package:popdot/theme/appcolors.dart';
import 'package:popdot/widgets/liste_sons.dart';
import 'database/firebase_options.dart';
import 'database/firebase_tools.dart';
import 'database/hive_tools.dart';
import 'package:popdot/pages/biblitheme.dart';
import 'package:popdot/pages/details.dart';
import 'pages/theme.dart';
import 'pages/FormuSons.dart';

void main() async {
  // Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Hive
  await Hive.initFlutter();
  Hive.registerAdapter(ThemeAdapter());
  Hive.registerAdapter(SoundAdapter());
  Hive.registerAdapter(ImageAdapter());
  // var sons = Hive.openBox<Sound>('sounds');
  await Hive.openBox<Sound>('sounds');

  // print(sons.values.toList().cast<Sound>());
  // print(sons.keys);
  // print(sons.values);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //static const String boitesons = 'sounds';
  static const String boitesons = 'sounds';



  int selectedIndex = 0;

  final widgetOptions = [
    new Details(),
    new AnimatedPage(),
    new ClassTheme(),
    new BibliTheme(),

  ];




  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Builder(builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Details()),
                    );
                  },
                  child: const Text('Page des details'),
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Builder(builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AnimatedPage()),
                    );
                  },
                  child: const Text('Page test 404'),
                );
              }),
            ),
            Builder(builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ClassTheme()),
                  );
                },
                child: const Text('Page Louis'),
              );
            }),
            Builder(builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyCustomForm()),
                  );
                },
                child: const Text('Formule sons test'),
              );
            }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Builder(builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BibliTheme()),
                    );
                  },
                  child: const Text('Page Alex'),
                );
              }),
            ),
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
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 160.0,
                      height: 160.0,
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
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor:  AppColors.white,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.audiotrack,
                  color: AppColors.beige,
                ),
                label: "Details theme"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.library_books_rounded,
                  color: AppColors.beige,
                ),
                label: "Sons"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.volume_up,
                  color: AppColors.beige,
                ),
                label: "Test"),
          ],
          currentIndex: selectedIndex,
          fixedColor: AppColors.darkGrey,
          onTap: onItemTapped,
          selectedLabelStyle: TextStyle(color: Colors.red, fontSize: 20),
          unselectedFontSize: 16,
          selectedIconTheme:
              IconThemeData(color: AppColors.darkGrey, opacity: 1.0, size: 30.0),
          unselectedItemColor: Colors.black,
          unselectedLabelStyle: TextStyle(fontSize: 18, color: Colors.pink),
        ),
      ),
    );
  }
}
