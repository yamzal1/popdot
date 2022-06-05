import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import '../database/firebase_tools.dart';
import '../database/hive_tools.dart';
import '../theme/app_colors.dart';


class ThemeForm extends StatefulWidget {
  const ThemeForm({Key? key}) : super(key: key);
  //static const String soundBoxName = "sounds";
  @override
  _ThemeFormState createState() => _ThemeFormState();
}


class _ThemeFormState extends State<ThemeForm> {

  final myController = TextEditingController();
  TextEditingController titreTheme = TextEditingController();
  //late Box<Sound> soundBox;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //soundBox = Hive.box(ThemeForm.soundBoxName);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }



  void reset() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un thème'),
      ),
      body: Center(





      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {  },
        tooltip: 'Valider',
        child: const Icon(Icons.check),
      ),
    );
  }
}
