import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'database/firebase_options.dart';
import 'database/hive_tools.dart';
import 'pages/home.dart';
import 'pages/theme.dart';
import 'pages/theme_library.dart';
import 'pages/theme_sounds.dart';
import 'widgets/404.dart';

void main() async {
  // Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Hive
  await Hive.initFlutter();
  Hive.registerAdapter(JukeboxThemeAdapter());
  Hive.registerAdapter(SoundAdapter());
  Hive.registerAdapter(JukeboxImageAdapter());

  runApp(const Popdot());
}

class Popdot extends StatefulWidget {
  const Popdot({Key? key}) : super(key: key);

  @override
  State<Popdot> createState() => _PopdotState();
}

class _PopdotState extends State<Popdot> {
  bool useMaterial3 = true;
  bool useLightMode = true;

  late ThemeData themeData;

  static const String soundBoxName = 'sounds';
  String fabString = "Ajouter un thème";

  int _selectedIndex = 0;

  final _pageOptions = [
    const HomePage(),
    const Details(
      title: "",
      isBaseTheme: false,
    ),
    const ThemeLibrary(),
    const NoSound(),
    const ClassTheme(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      if (_selectedIndex == 0) {
        fabString = "Ajouter un thème";
      } else if (_selectedIndex == 1) {
        fabString = "Ajouter un son";
      }
    });
  }

  @override
  void initState() {
    super.initState();
    themeData = updateThemes(useMaterial3, useLightMode);
  }

  ThemeData updateThemes(bool useMaterial3, bool useLightMode) {
    return ThemeData(
      useMaterial3: useMaterial3,
      brightness: useLightMode ? Brightness.light : Brightness.dark,
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      home: Scaffold(
        appBar: null,
        backgroundColor: Colors.black,
        body: _pageOptions[_selectedIndex],
        // floatingActionButton: Builder(
        //   builder: (context) {
        //     return FloatingActionButton.extended(
        //       elevation: 4.0,
        //       icon: const Icon(Icons.add),
        //       label: Text(fabString),
        //       onPressed: () async {
        //         if (_selectedIndex == 0) {
        //           // Page 1
        //           Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //               builder: (context) => ThemeForm(),
        //             ),
        //           );
        //         }
        //         if (_selectedIndex == 1) {
        //           // Page 2
        //
        //           Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //               builder: (context) => SoundForm(),
        //             ),
        //           );
        //         }
        //       },
        //     );
        //   },
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // bottomNavigationBar: BottomNavigationBar(
        //   items: const <BottomNavigationBarItem>[
        //     BottomNavigationBarItem(
        //       icon: Icon(
        //         Icons.home,
        //         color: AppColors.darkGrey,
        //       ),
        //       label: 'Accueil',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(
        //         Icons.question_mark,
        //         color: AppColors.darkGrey,
        //       ),
        //       label: 'Autre page ?',
        //     ),
        //   ],
        //   currentIndex: _selectedIndex,
        //   selectedItemColor: AppColors.darkGrey,
        //   onTap: _onItemTapped,
        // ),
      ),
    );
  }
}
