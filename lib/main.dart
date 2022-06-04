import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/adapters.dart';
import 'database/firebase_options.dart';
import 'database/firebase_tools.dart';
import 'database/hive_tools.dart';
import 'pages/theme_library.dart';
import 'pages/details.dart';
import 'pages/theme.dart';
import 'pages/sound_form.dart';
import 'pages/home.dart';
import 'theme/app_colors.dart';
import 'widgets/sound_list.dart';


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
  await Hive.openBox<Sound>('sounds');

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
    const Details(),
    const ThemeLibrary(),
    const AnimatedPage(),
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
        brightness: useLightMode ? Brightness.light : Brightness.dark);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      home: Scaffold(
        appBar: null,
        backgroundColor: Colors.black,
        body: _pageOptions[_selectedIndex],
        floatingActionButton: Builder(
          builder: (context) {
            return FloatingActionButton.extended(
              elevation: 4.0,
              icon: const Icon(Icons.add),
              label: Text(fabString),
              onPressed: () async {
                if (_selectedIndex == 0) {
                  // Page 1
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyCustomForm(),
                    ),
                  );
                }
                if (_selectedIndex == 1) {
                  // Page 2

                  var picked = await FilePicker.platform.pickFiles();

                  if (picked != null) {
                    final fileBytes = picked.files.first.bytes;
                    final fileName = picked.files.first.name;
                    if (fileName.toString().endsWith(".mp3") ||
                        fileName.toString().endsWith(".m4a")) {
                      Fluttertoast.showToast(
                          msg: "Son ajouté avec succès",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 3,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                      addSound(fileName, fileBytes);
                    }
                  }
                  // TODO : On ajoute le son direct, il faut d'abord aller sur un formulaire (pour choisir une icone)
                  // https://pub.dev/packages/flutter_iconpicker
                }
              },
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: AppColors.darkGrey,
              ),
              label: 'Accueil',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.question_mark,
                color: AppColors.darkGrey,
              ),
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
