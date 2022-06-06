import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hive/hive.dart';
import 'hive_tools.dart';

var db = FirebaseFirestore.instance;
var storage = FirebaseStorage.instance;

Future<void> makeABunchaThemes() async {
  var box = await Hive.openBox('themes');
  await box.add(JukeboxTheme(
      title: 'Spain',
      description: 'sjdfjsdjfsjdkifjskldjfksjd',
      image: '0.jpg',
      sounds: []));
  await box.add(JukeboxTheme(
      title: 'Ratp',
      description: 'sjdfjsdjfsjdkifjskldjfksjd',
      image: '1.jpg',
      sounds: []));
  await box.add(JukeboxTheme(
      title: 'Antony',
      description: 'sjdfjsdjfsjdkifjskldjfksjd',
      image: '2.jpg',
      sounds: []));
  await box.add(JukeboxTheme(
      title: 'Orly',
      description: 'sjdfjsdjfsjdkifjskldjfksjd',
      image: '3.jpg',
      sounds: []));
  await box.add(JukeboxTheme(
      title: 'Aeroport',
      description: 'sjdfjsdjfsjdkifjskldjfksjd',
      image: '4.jpg',
      sounds: []));
  await box.add(JukeboxTheme(
      title: 'Ile',
      description: 'dfjsdjfsjdkifjskldjfksjd',
      image: '5.jpg',
      sounds: []));
  await box.add(JukeboxTheme(
      title: 'France',
      description: 'sjdfjsdjfsjdkifjskldjfksjd',
      image: '6.jpg',
      sounds: []));
  await box.close();
}

Future<void> createTheme(title, description, image) async {
  var box = await Hive.openBox<JukeboxTheme>('themes');
  box.add(JukeboxTheme(
      title: title, description: description, image: image, sounds: []));
  box.close();
}

Future<List> getThemes() async {
  var box = await Hive.openBox<JukeboxTheme>('themes');

  return box.values.toList();
}

Future<List> getMadeForYouThemes() async {
  Box box = await Hive.openBox<JukeboxTheme>('base_themes');
  box.clear();

  QuerySnapshot themesQuerySnapshot = await db.collection('themes').get();
  var themes = [];

  for (var doc in themesQuerySnapshot.docs) {
    QuerySnapshot soundsQuerySnapshot = await doc.reference.collection('sounds').get();
    List<Sound> sounds = [];
    for (var soundDoc in soundsQuerySnapshot.docs) {
      Sound newSound = Sound(name: soundDoc.id, fullpath: (soundDoc.data() as Map<String, dynamic>)['fullpath'], icon: (soundDoc.data() as Map<String, dynamic>)['icon']);
      sounds.add(newSound);
    }

    JukeboxTheme newTheme = JukeboxTheme(
        title: doc.id,
        description: (doc.data() as Map<String, dynamic>)['description'],
        image: (doc.data() as Map<String, dynamic>)['image'],
        sounds: sounds);

    box.add(newTheme);
    themes.add(newTheme);
  }

  return themes;
}

Future<List> getSounds(themeName, isBaseTheme) async {
  Box box;

  if (isBaseTheme) {
    box = Hive.box<JukeboxTheme>('base_themes');
  } else {
    box = Hive.box<JukeboxTheme>('themes');
  }

  return (box.values.toList().where((element) => element.title == themeName).first as JukeboxTheme).sounds;
}

Future<void> addSound(String name, file) async {
  var box = await Hive.openBox<Sound>('sounds');
  box.add(Sound(name: name.replaceAll('.mp3', '').replaceAll('.m4a', ''), fullpath: name, icon: "plane or smth"));
  uploadFile(name, 'sounds', file);
}

Future<void> addImage(name, file) async {
  var box = await Hive.openBox<JukeboxImage>('images');
  box.add(JukeboxImage(name: name));

  uploadFile(name, 'images', file);
}

Future<void> uploadFile(name, folder, file) async {
  // Folders : sounds or images
  storage.ref('$folder/$name').putData(file);
}

Future<String> getImageURL(name) async {
  return await storage.ref('images/$name').getDownloadURL();
}

Future<String> listFiles(filename) async {
  var filePath = await storage.ref().child('sounds/' + filename).fullPath;
  return filePath;
}

Future<String> getDownloadURL(filePath) async {
  return await storage.ref(filePath).getDownloadURL();
}