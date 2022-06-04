import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hive/hive.dart';
import 'hive_tools.dart';

var db = FirebaseFirestore.instance;
var storage = FirebaseStorage.instance;

Future<void> createTheme(title, description, image) async {
  var box = await Hive.openBox('themes');
  box.add(Theme(title: title, description: description, image: image));
}

Future<void> addSound(name, file) async {
  var box = await Hive.openBox<Sound>('sounds');
  box.add(Sound(name: name, icon: "plane or smth"));
  uploadFile(name, 'sounds', file);
}

Future<void> addImage(name, file) async {
  var box = await Hive.openBox('images');
  box.add(ImageObject(name: name));

  uploadFile(name, 'images', file);
}

Future<void> uploadFile(name, folder, file) async {
  // Folders : sounds or images
  storage.ref('$folder/$name').putData(file);
}

Future<void> downloadFile(name, folder) async {}
