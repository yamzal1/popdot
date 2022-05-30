import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:popdot/pages/home.dart';
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
        backgroundColor: Colors.black,
        body: _pageOptions[_selectedIndex],
        floatingActionButton: Builder(
          builder: (context) {
            return FloatingActionButton.extended(
              elevation: 4.0,
              icon: const Icon(Icons.add),
              label: const Text('Ajouter un thème'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyCustomForm()),
                );
              },
            );
          }
        ),
        floatingActionButtonLocation:
        FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home,color: AppColors.darkGrey,),
              label: 'Accueil',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.question_mark,color: AppColors.darkGrey,),
              label: 'Autre page ?',
            ),

          ],
          currentIndex: _selectedIndex,
          selectedItemColor: AppColors.darkGrey,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
