// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tahun_ajaran.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TahunAjaran _$TahunAjaranFromJson(Map<String, dynamic> json) => TahunAjaran(
  id: json['id'] as String,
  tenantId: json['tenantId'] as String,
  nama: json['nama'] as String,
  mulai: DateTime.parse(json['mulai'] as String),
  selesai: DateTime.parse(json['selesai'] as String),
  aktif: json['aktif'] as bool,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$TahunAjaranToJson(TahunAjaran instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tenantId': instance.tenantId,
      'nama': instance.nama,
      'mulai': instance.mulai.toIso8601String(),
      'selesai': instance.selesai.toIso8601String(),
      'aktif': instance.aktif,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
