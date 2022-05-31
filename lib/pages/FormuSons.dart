import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:popdot/pages/listingSounds.dart';
import 'package:popdot/widgets/liste_sons.dart';
import '../database/firebase_options.dart';
import '../database/firebase_tools.dart';
import '../database/hive_tools.dart';
import 'package:popdot/pages/biblitheme.dart';
import 'package:popdot/pages/details.dart';
import 'theme.dart';
import '../main.dart';


void main() async{
  await Hive.initFlutter();
  Hive.registerAdapter(SoundAdapter());
  await Hive.openBox<Sound>(MyApp.boitesons);
  runApp(const MyApp());}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String boitesons = "sounds";

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Retrieve Text Input',
      home: MyCustomForm(),
    );
  }
}

enum SingingCharacter { Cadre, NonCadre }

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
  SingingCharacter _character = SingingCharacter.Cadre;
  late Box<Sound> soundBox;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    soundBox = Hive.box(MyApp.boitesons);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  void updateRadio(SingingCharacter value) {
    setState(() {
      _character = value;
    });
  }

  void prepSound() async{
    if (entreprise.text != "" ){
        var name = entreprise.text;
        var file = _character.name;
      //soundBox.add(sound);
      addSound(name, file);
      reset();
      Navigator.of(context).push
        (MaterialPageRoute(builder: (context) => InfoScreen()));
    }
  }

  void reset() {
    entreprise.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Retrieve Text Input'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: entreprise,
              decoration: const InputDecoration(
                icon: Icon(Icons.corporate_fare),
                hintText: 'Nom du son ?',
                labelText: 'Sons *',
              ),
              onSaved: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              validator: (String? value) {
                return (value == null) ? 'Ne laissez pas un champ vide svp.' : null;
              },
            ),
            Text('data'),
            ListTile(
              title: const Text('Cadre'),
              leading: Radio<SingingCharacter>(
                value: SingingCharacter.Cadre,
                groupValue: _character,
                onChanged: (value) => updateRadio(value!),
              ),
            ),
            ListTile(
              title: const Text('Non-cadre'),
              leading: Radio<SingingCharacter>(
                value: SingingCharacter.NonCadre,
                groupValue: _character,
                onChanged: (value) => updateRadio(value!),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_outlined)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.schedule_outlined)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.flight_outlined)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.lightbulb)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.pets_outlined))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.grade_outlined)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.euro_symbol_outlined)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.rocket_launch_outlined)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.nightlight_round_outlined)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.sports_esports_outlined))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.military_tech_outlined)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.science_outlined)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.history_edu_outlined)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.sports_basketball_outlined)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.piano_outlined))
              ],
            ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: prepSound,
        tooltip: 'Show me the value!',
        child: const Icon(Icons.text_fields),
      ),
    );
  }
}