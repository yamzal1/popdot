import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

part 'main.g.dart';

@HiveType(typeId: 12)
class JukeboxTheme {
  JukeboxTheme(
      {required this.title,
      required this.description,
      required this.image,
      required this.sounds});

  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  String image;

  @HiveField(3, defaultValue: [])
  List<Sound> sounds;

  @override
  String toString() {
    return title;
  }
}

@HiveType(typeId: 51)
class Sound {
  Sound({required this.name, required this.fullpath, required this.icon});

  @HiveField(0)
  String name;

  @HiveField(1)
  String fullpath;

  @HiveField(2)
  String icon;

  @override
  String toString() {
    return "name: $name, fullPath: $fullpath, icon: $icon";
  }
}

@HiveType(typeId: 86)
class JukeboxImage {
  JukeboxImage({required this.name});

  @HiveField(0)
  String name;

  @override
  String toString() {
    return name;
  }
}
