import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:popdot/pages/info_screen.dart';
import '../database/firebase_tools.dart';
import '../database/hive_tools.dart';



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String soundBoxName = "sounds";

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Ajouter un son',
      home: MyCustomForm(),
    );
  }
}

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();
  TextEditingController entreprise = TextEditingController();
  late Box<Sound> soundBox;
  Icon? _icon;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    soundBox = Hive.box(MyApp.soundBoxName);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }



  void prepSound() async {

  }

  void reset() {
  }

  _pickIcon() async {
    IconData? icon = await FlutterIconPicker.showIconPicker(context,
        iconPackModes: [IconPack.cupertino]);

    _icon = Icon(icon);
    setState(() {});

    debugPrint('Picked Icon:  $icon');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un son'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[


            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 160.0,
                height: 160.0,
                child: Card(
                  child: OutlinedButton(
                    child: const Text('Choisir un son'),
                    onPressed: () async {
                      var picked = await FilePicker.platform.pickFiles();

                      if (picked != null) {
                        final fileBytes = picked.files.first.bytes;
                        final fileName = picked.files.first.name;
                        if (fileName.toString().endsWith(".mp3") ||
                            fileName.toString().endsWith(".m4a")) {
                          //addSound(fileName, fileBytes);
                        }
                      }
                    },
                  ),
                ),
              ),
            ),


            ElevatedButton(
              onPressed: _pickIcon,
              child: const Text('Choisir une icone'),
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: prepSound,
        tooltip: 'Valider',
        child: const Icon(Icons.check),
      ),
    );
  }
}
