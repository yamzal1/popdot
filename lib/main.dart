import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:popdot/pages/home.dart';
import 'package:popdot/theme/app_colors.dart';
import 'package:popdot/widgets/liste_sons.dart';
import 'database/firebase_options.dart';
import 'database/firebase_tools.dart';
import 'database/hive_tools.dart';
import 'package:popdot/pages/theme_library.dart';
import 'package:popdot/pages/details.dart';
import 'pages/theme.dart';
import 'pages/sound_form.dart';

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
  static const String soundBoxName = 'sounds';
  String fabString = "Ajouter un thème";

  int _selectedIndex = 0;

  final _pageOptions = [
    const HomePage(),
    const Details(),
    AnimatedPage(),
    ClassTheme(),
    ThemeLibrary(),
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
              label: Text(fabString),
              onPressed: () async {
                if (_selectedIndex == 0) {
                  // Page 1
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyCustomForm()),
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
