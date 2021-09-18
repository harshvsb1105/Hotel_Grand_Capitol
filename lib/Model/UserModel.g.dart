// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel()
      ..registrationNumber = fields[0] as String
      ..names = (fields[1] as List)?.cast<String>()
      ..numberOfPeople = fields[2] as String
      ..phoneNo = fields[3] as String
      ..type = fields[4] as String
      ..bookingID = fields[5] as String
      ..paymentMode = fields[6] as String
      ..amount = fields[7] as String
      ..roomNo = (fields[8] as List)?.cast<String>()
      ..guestImage = fields[9] as String
      ..guestsId = fields[10] as String
      ..checkInDate = fields[11] as String
      ..checkOutDate = fields[12] as String;
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.registrationNumber)
      ..writeByte(1)
      ..write(obj.names)
      ..writeByte(2)
      ..write(obj.numberOfPeople)
      ..writeByte(3)
      ..write(obj.phoneNo)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.bookingID)
      ..writeByte(6)
      ..write(obj.paymentMode)
      ..writeByte(7)
      ..write(obj.amount)
      ..writeByte(8)
      ..write(obj.roomNo)
      ..writeByte(9)
      ..write(obj.guestImage)
      ..writeByte(10)
      ..write(obj.guestsId)
      ..writeByte(11)
      ..write(obj.checkInDate)
      ..writeByte(12)
      ..write(obj.checkOutDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
