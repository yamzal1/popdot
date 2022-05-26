import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

part 'main.g.dart';

@HiveType(typeId: 12)
class Theme {
  Theme(
      {required this.title,
        required this.description,
        required this.image});

  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  String image;

  @HiveField(3, defaultValue: [])
  late List<Sound> sounds;

  @override
  String toString() {
    return title;
  }
}

@HiveType(typeId: 51)
class Sound {
  Sound({required this.name, required this.icon});

  @HiveField(0)
  String name;

  @HiveField(1)
  String icon;

  // @override
  // String toString() {
  //   return name;
  // }
}

@HiveType(typeId: 86)
class ImageObject {
  ImageObject({required this.name});

  @HiveField(0)
  String name;

  @override
  String toString() {
    return name;
  }
}

