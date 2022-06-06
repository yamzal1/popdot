import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import '../database/firebase_tools.dart';
import '../database/hive_tools.dart';
import '../theme/app_colors.dart';

class ThemeForm extends StatefulWidget {
  const ThemeForm({Key? key}) : super(key: key);
  static const String themeBoxName = "themes";
  @override
  _ThemeFormState createState() => _ThemeFormState();
}

class _ThemeFormState extends State<ThemeForm> {
  final myController = TextEditingController();
  TextEditingController titreTheme = TextEditingController();
  late Box<JukeboxTheme> themeBox;
  String _nomImage = "";
  bool _isButtonDisabled = true;
  bool imageIsPicked = false;

  final DescController = TextEditingController();
  final TitreController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    themeBox = Hive.box(ThemeForm.themeBoxName);
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
      backgroundColor: AppColors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
              child: Text(
                'Nouveau thème',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  // color: Theme.of(context).primaryColor,
                  color: AppColors.darkGrey,
                ),
              ),
            ),
            TextFormField(
              controller: TitreController,
              decoration: InputDecoration(
                labelText: "Titre du thème",
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(),
                ),
                //fillColor: Colors.green
              ),
              validator: (val) {
                if (val?.length == 0) {
                  return "Le titre ne peut pas être vide !";
                } else {
                  return null;
                }
              },
              onChanged: (text) {
                onTextChange();
              },
              keyboardType: TextInputType.name,
              style: TextStyle(
                fontFamily: "Poppins",
              ),
            ),
            const Padding(padding: EdgeInsets.all(10)),
            TextFormField(
              controller: DescController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: "Description du thème",
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(),
                ),
                //fillColor: Colors.green
              ),
              validator: (desc) {
                if (desc?.length == 0) {
                  return "La description ne peut pas être vide !";
                } else {
                  return null;
                }
              },
              onChanged: (text) {
                onTextChange();
              },
              style: const TextStyle(
                fontFamily: "Poppins",
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
                      var picked = await FilePicker.platform.pickFiles();

                      if (picked != null) {
                        final fileBytes = picked.files.first.bytes;
                        final fileName = picked.files.first.name;
                        if (fileName.toString().endsWith(".jpg") ||
                            fileName.toString().endsWith(".png")) {
                          _nomImage = fileName;

                          setState(() {
                            imageIsPicked = true;
                          });
                          addImage(fileName, fileBytes);
                        }
                      }
                      onTextChange();
                    },
                  ),
                ),
              ),
            ),
            Text(
              _nomImage,
              style: const TextStyle(
                  color: AppColors.darkGrey,
                  fontSize: 10,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      floatingActionButton: _isButtonDisabled == false
          ? FloatingActionButton(
              onPressed: () async {
                createTheme(TitreController.text, DescController.text,
                    await getImageURL(_nomImage));
              },
              tooltip: 'Valider',
              child: const Icon(Icons.check),
            )
          : Container(),
    );
  }

  void onTextChange() {
    if (DescController.text.isNotEmpty &&
        TitreController.text.isNotEmpty &&
        imageIsPicked) {
      setState(() {
        _isButtonDisabled = false;
      });
    } else {
      setState(() {
        _isButtonDisabled = true;
      });
    }
  }
}
