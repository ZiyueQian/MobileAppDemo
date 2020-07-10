// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Dispatch.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DispatchAdapter extends TypeAdapter<Dispatch> {
  @override
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
      fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Dispatch obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.dispatchRecord)
      ..writeByte(1)
      ..write(obj.dispatchAmount)
      ..writeByte(2)
      ..write(obj.dispatchType)
      ..writeByte(3)
      ..write(obj.dispatchTime)
      ..writeByte(4)
      ..write(obj.dispatchConfirmation);
  }

  @override
  // TODO: implement typeId
  int get typeId => 0;
}
