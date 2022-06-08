// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_tools.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class JukeboxThemeAdapter extends TypeAdapter<JukeboxTheme> {
  @override
  final int typeId = 12;

  @override
  JukeboxTheme read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return JukeboxTheme(
      title: fields[0] as String,
      description: fields[1] as String,
      image: fields[2] as String,
      sounds: fields[3] == null ? [] : (fields[3] as List).cast<Sound>(),
    );
  }

  @override
  void write(BinaryWriter writer, JukeboxTheme obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.sounds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JukeboxThemeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SoundAdapter extends TypeAdapter<Sound> {
  @override
  final int typeId = 51;

  @override
  Sound read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Sound(
      name: fields[0] as String,
      fullpath: fields[1] as String,
      image: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Sound obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.fullpath)
      ..writeByte(2)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SoundAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class JukeboxImageAdapter extends TypeAdapter<JukeboxImage> {
  @override
  final int typeId = 86;

  @override
  JukeboxImage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return JukeboxImage(
      name: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, JukeboxImage obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JukeboxImageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
