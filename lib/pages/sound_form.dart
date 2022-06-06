import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../database/firebase_tools.dart';
import '../theme/app_colors.dart';

class SoundForm extends StatefulWidget {
  const SoundForm({Key? key, required this.themeName}) : super(key: key);

  final String themeName;

  @override
  _SoundFormState createState() => _SoundFormState();
}

class _SoundFormState extends State<SoundForm> {
  final myController = TextEditingController();
  TextEditingController titreTheme = TextEditingController();
  String _imageName = "";
  String _soundName = "";
  bool _isButtonDisabled = true;
  bool imageIsPicked = false;
  bool soundIsPicked = false;

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
                'New sound',
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
                labelText: 'Sound name',
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(),
                ),
                //fillColor: Colors.green
              ),
              validator: (val) {
                if (val!.isEmpty) {
                  return 'Sound name cannot be empty';
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
                          _imageName = fileName;

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
              _imageName,
              style: const TextStyle(
                  color: AppColors.darkGrey,
                  fontSize: 10,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 300.0,
                child: Card(
                  child: OutlinedButton(
                    child: const Text('Choose a sound'),
                    onPressed: () async {
                      var picked = await FilePicker.platform.pickFiles();

                      if (picked != null) {
                        final fileBytes = picked.files.first.bytes;
                        final fileName = picked.files.first.name;
                        if (fileName.toString().endsWith(".mp3") ||
                            fileName.toString().endsWith(".m4a")) {
                          _soundName = fileName;

                          setState(() {
                            soundIsPicked = true;
                          });
                          uploadFile(fileName, 'sounds', fileBytes);
                        }
                      }
                      onTextChange();
                    },
                  ),
                ),
              ),
            ),
            Text(
              _soundName,
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
                addSound(widget.themeName, titleController.text, _soundName, _imageName);
              },
              tooltip: 'Validate',
              child: const Icon(Icons.check),
            )
          : Container(),
    );
  }

  void onTextChange() {
    if (titleController.text.isNotEmpty && imageIsPicked && soundIsPicked) {
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
