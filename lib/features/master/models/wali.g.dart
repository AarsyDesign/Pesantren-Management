// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wali.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Wali _$WaliFromJson(Map<String, dynamic> json) => Wali(
  id: json['id'] as String,
  tenantId: json['tenantId'] as String,
  nama: json['nama'] as String,
  noTelp: json['noTelp'] as String?,
  alamat: json['alamat'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$WaliToJson(Wali instance) => <String, dynamic>{
  'id': instance.id,
  'tenantId': instance.tenantId,
  'nama': instance.nama,
  'noTelp': instance.noTelp,
  'alamat': instance.alamat,
  'createdAt': instance.createdAt.toIso8601String(),
};
