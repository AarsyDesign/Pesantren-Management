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
  waliId: json['waliId'] as String?,
  kapasitas: (json['kapasitas'] as num).toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$KelasToJson(Kelas instance) => <String, dynamic>{
  'id': instance.id,
  'tenantId': instance.tenantId,
  'tahunAjaranId': instance.tahunAjaranId,
  'nama': instance.nama,
  'waliId': instance.waliId,
  'kapasitas': instance.kapasitas,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};
