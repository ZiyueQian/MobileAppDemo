// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Dispatch.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DispatchAdapter extends TypeAdapter<Dispatch> {
  @override
  final typeId = 0;
  Dispatch read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Dispatch(
      fields[0] as String,
      fields[3] as DateTime,
      fields[1] as int,
      fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Dispatch obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.dispatchRecord)
      ..writeByte(1)
      ..write(obj.dispatchAmount)
      ..writeByte(2)
      ..write(obj.dispatchType)
      ..writeByte(3)
      ..write(obj.dispatchTime);
  }
}
