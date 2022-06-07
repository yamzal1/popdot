import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';

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
  String _nomImage = "";
  bool _isButtonDisabled = true;
  bool imageIsPicked = false;

  final descController = TextEditingController();
  final titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
                'New theme',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  // color: Theme.of(context).primaryColor,
                  color: AppColors.darkGrey,
                ),
              ),
            ),
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(),
                ),
                //fillColor: Colors.green
              ),
              validator: (val) {
                if (val!.isEmpty) {
                  return 'Title cannot be empty';
                } else {
                  return null;
                }
              },
              onChanged: (text) {
                onTextChange();
              },
              keyboardType: TextInputType.name,
              style: const TextStyle(
                fontFamily: "Poppins",
              ),
            ),
            const Padding(padding: EdgeInsets.all(10)),
            TextFormField(
              controller: descController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Description',
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(),
                ),
              ),
              validator: (desc) {
                if (desc!.isEmpty) {
                  return 'Description cannot be empty';
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
                    child: const Text('Choose an image'),
                    onPressed: () async {
                      var picked = await ImagePicker()
                          .pickImage(source: ImageSource.camera);

                      if (picked != null) {
                        final fileBytes = await picked.readAsBytes();
                        final fileName = picked.name;
                        if (fileName.toString().endsWith(".jpg") ||
                            fileName.toString().endsWith(".png")) {
                          _nomImage = fileName;

                          setState(() {
                            imageIsPicked = true;
                          });
                          uploadFile(fileName, 'images', fileBytes);
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
                createTheme(
                    titleController.text, descController.text, _nomImage);
                setState(() {

                });//Peut être inutile
                Navigator.pop(context);
              },
              tooltip: 'Validate',
              child: const Icon(Icons.check),
            )
          : Container(),
    );
  }

  void onTextChange() {
    if (descController.text.isNotEmpty &&
        titleController.text.isNotEmpty &&
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
