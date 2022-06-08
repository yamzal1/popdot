import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hive/hive.dart';

import 'hive_tools.dart';

var db = FirebaseFirestore.instance;
var storage = FirebaseStorage.instance;

Future<void> makeABunchaThemes() async {
  var box = await Hive.openBox('themes');
  box.clear();
  // await box.add(JukeboxTheme(
  //     title: 'Spain',
  //     description: 'sjdfjsdjfsjdkifjskldjfksjd',
  //     image: 'upload_test.jpg',
  //     sounds: []));
  // await box.add(JukeboxTheme(
  //     title: 'Ratp',
  //     description: 'sjdfjsdjfsjdkifjskldjfksjd',
  //     image: 'upload_test.jpg',
  //     sounds: []));
  // await box.add(JukeboxTheme(
  //     title: 'Antony',
  //     description: 'sjdfjsdjfsjdkifjskldjfksjd',
  //     image: 'upload_test.jpg',
  //     sounds: []));
  // await box.add(JukeboxTheme(
  //     title: 'Orly',
  //     description: 'sjdfjsdjfsjdkifjskldjfksjd',
  //     image: 'upload_test.jpg',
  //     sounds: []));
  // await box.add(JukeboxTheme(
  //     title: 'Aeroport',
  //     description: 'sjdfjsdjfsjdkifjskldjfksjd',
  //     image: 'upload_test.jpg',
  //     sounds: []));
  // await box.add(JukeboxTheme(
  //     title: 'Ile',
  //     description: 'dfjsdjfsjdkifjskldjfksjd',
  //     image: 'upload_test.jpg',
  //     sounds: []));
  // await box.add(JukeboxTheme(
  //     title: 'France',
  //     description: 'sjdfjsdjfsjdkifjskldjfksjd',
  //     image: 'upload_test.jpg',
  //     sounds: []));
  await box.close();
}

Future<void> createTheme(title, description, String image) async {
  var box = await Hive.openBox<JukeboxTheme>('themes');
  box.add(JukeboxTheme(
      title: title, description: description, image: image.replaceAll(' ', ''), sounds: []));
  box.close();
}

Future<void> deleteTheme(title) async {
  var box = await Hive.openBox<JukeboxTheme>('themes');
  var i = 0;
  for (var theme in box.values) {
    if (theme.title == title) {
      box.deleteAt(i);
    }

    i++;
  }

  box.close();
}

Future<void> updateTheme(title, newTitle, description, String image, sounds) async {
  var box = await Hive.openBox<JukeboxTheme>('themes');

  var i = 0;
  for (var theme in box.values) {
    var newSounds = theme.sounds;
    if (sounds.isNotEmpty) {
      newSounds = sounds;
    }

    if (theme.title == title) {
      box.putAt(
          i,
          JukeboxTheme(
              title: newTitle,
              description: description,
              image: image.replaceAll(' ', ''),
              sounds: newSounds));
    }

    i++;
  }

  box.close();
}

Future<void> updateSound(themeName, newTitle, image) async {
  var box = await Hive.openBox<JukeboxTheme>('themes');

  var i = 0;
  for (var theme in box.values) {
    if (theme.title == themeName) {
      for (var sound in theme.sounds) {
        var newSound =
            Sound(name: newTitle, fullpath: sound.fullpath, image: image);

        theme.sounds.remove(sound);
        theme.sounds.add(newSound);
      }

      box.putAt(
        i,
        JukeboxTheme(
            title: theme.title,
            description: theme.description,
            image: theme.image,
            sounds: theme.sounds),
      );
    }
  }
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
    QuerySnapshot soundsQuerySnapshot =
        await doc.reference.collection('sounds').get();
    List<Sound> sounds = [];

    for (var soundDoc in soundsQuerySnapshot.docs) {
      Sound newSound = Sound(
          name: soundDoc.id,
          fullpath: (soundDoc.data() as Map<String, dynamic>)['fullpath'],
          image: (soundDoc.data() as Map<String, dynamic>)['icon']);
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

  return (box.values
          .toList()
          .where((element) => element.title == themeName)
          .first as JukeboxTheme)
      .sounds;
}

Future<void> addSound(themeName, String name, String filepath, String image) async {
  var box = await Hive.openBox<JukeboxTheme>('themes');

  var newSound =
      Sound(name: name, fullpath: filepath.replaceAll(' ', ''), image: image.replaceAll(' ', ''));
  var theme = (box.values
      .toList()
      .where((element) => element.title == themeName)
      .first);

  theme.sounds.add(
    newSound,
  );

  updateTheme(
      theme.title, theme.title, theme.description, theme.image, theme.sounds);
}

Future<void> addImage(name, file) async {
  var box = await Hive.openBox<JukeboxImage>('images');
  box.add(JukeboxImage(name: name));

  uploadFile(name, 'images', file);
}

Future<void> uploadFile(String name, folder, file) async {
  // Folders : sounds or images
  String formattedName = name.replaceAll(' ', '');
  storage.ref('$folder/$formattedName').putData(file);
}

Future<String> getImageURL(name) async {
  return await storage.ref('images/$name').getDownloadURL();
}

Future<String> listFiles(filename) async {
  var filePath = await storage.ref().child('sounds/' + filename).fullPath;
  return filePath;
}

Future<String> getDownloadURL(filePath) async {
  print(filePath);
  return await storage.ref(filePath).getDownloadURL();
}
