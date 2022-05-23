import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

var db = FirebaseFirestore.instance;
var storage = FirebaseStorage.instance;

void createTheme(title, description, image) {
  final theme = <String, dynamic> {
    "title": title,
    "description": description,
    "image": image
  };

  db.collection("themes").add(theme).then((DocumentReference doc) => null);

}

void addSound(name, file) {
  final sound = <String, dynamic> {
    "name": name,
    "title": name,
    "icon": "plane or smth"
  };

  db.collection("sounds").add(sound).then((DocumentReference doc) => null);

  uploadFile(name, 'sounds', file);
}

void addImage(name, file) {
  final image = <String, dynamic> {
    "name": name,
    "title": name,
    "icon": "plane or smth"
  };

  db.collection("images").add(image).then((DocumentReference doc) => null);

  uploadFile(name, 'images', file);
}

Future<void> uploadFile(name, folder, file) async {
  // Folders : sounds or images
  storage.ref('$folder/$name').putData(file);
}
