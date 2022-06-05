import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:hive_flutter/adapters.dart';
import '../database/firebase_tools.dart';
import '../database/hive_tools.dart';
import '../theme/app_colors.dart';

// Define a custom Form widget.
class SoundForm extends StatefulWidget {
  const SoundForm({Key? key}) : super(key: key);
  static const String soundBoxName = "sounds";

  @override
  _SoundFormState createState() => _SoundFormState();
}


class _SoundFormState extends State<SoundForm> {

  late Box<Sound> soundBox;

  Icon _icon = Icon(Icons.music_note, color: Colors.white);
  String _titre = "Nouveau son";

  _openIconPicker() async {
    IconData? icon = await FlutterIconPicker.showIconPicker(context,
        iconPackModes: [IconPack.material], adaptiveDialog: true);

    if (icon != null) {
      _icon = Icon(icon, color: Colors.white);
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    soundBox = Hive.box(SoundForm.soundBoxName);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    super.dispose();
  }

  void prepSound() async {}

  void reset() {}

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
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Container(
                decoration: BoxDecoration(color: AppColors.darkGrey),
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  leading: AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      child: _icon != null
                          ? _icon
                          : Container(
                              child: Icon(
                                Icons.music_note,
                                color: Colors.white,
                              ),
                            )),
                  title: Text(
                    _titre,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
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
                          _titre = fileName;
                          setState(() {});
                          //addSound(fileName, fileBytes);
                        }
                      }
                    },
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _openIconPicker,
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
