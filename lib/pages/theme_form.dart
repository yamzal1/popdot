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
  String _nomImage = "";
  String _nomTheme = "Thème";


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

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: TextFormField(
                decoration: new InputDecoration(
                  labelText: "Titre du thème",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(
                    ),
                  ),
                  //fillColor: Colors.green
                ),
                validator: (val) {
                  if(val?.length==0) {
                    return "Le titre ne peut pas être vide !";
                  }else{
                    return null;
                  }
                },
                keyboardType: TextInputType.name,
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 300.0,
                child: Card(
                  child: OutlinedButton(
                    child: const Text('Choisir une image'),
                    onPressed: () async {
                      var picked =
                      await FilePicker.platform.pickFiles();

                      if (picked != null) {
                        final fileBytes = picked.files.first.bytes;
                        final fileName = picked.files.first.name;
                        if (fileName.toString().endsWith(".jpg") ||
                            fileName.toString().endsWith(".png")) {
                          _nomImage = fileName;

                                setState(() {});
                          //addImage(fileName, fileBytes);
                        }
                      }
                    },
                  ),
                ),

              ),
            ),
            Text(
              _nomImage,
              style: TextStyle(
                  color: AppColors.darkGrey,
                  fontSize: 10,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),



      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {  },
        tooltip: 'Valider',
        child: const Icon(Icons.check),
      ),
    );
  }
}
