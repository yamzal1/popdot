import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/adapters.dart';
import 'database/firebase_options.dart';
import 'database/firebase_tools.dart';
import 'database/hive_tools.dart';

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

  runApp(const MyApp());
}

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
                              if (fileName.contains(".mp3")) {
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
      ),
    );
  }
}
