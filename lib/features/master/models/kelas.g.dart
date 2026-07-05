// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kelas.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Kelas _$KelasFromJson(Map<String, dynamic> json) => Kelas(
  id: json['id'] as String,
  tenantId: json['tenantId'] as String,
  tahunAjaranId: json['tahunAjaranId'] as String,
  nama: json['nama'] as String,
  tingkat: (json['tingkat'] as num?)?.toInt(),
  waliKelas: json['waliKelas'] as String?,
  isDeleted: json['isDeleted'] as bool,
  createdAt: json['createdAt'] as String,
  updatedAt: json['updatedAt'] as String,
);

Map<String, dynamic> _$KelasToJson(Kelas instance) => <String, dynamic>{
  'id': instance.id,
  'tenantId': instance.tenantId,
  'tahunAjaranId': instance.tahunAjaranId,
  'nama': instance.nama,
  'tingkat': instance.tingkat,
  'waliKelas': instance.waliKelas,
  'isDeleted': instance.isDeleted,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
};
