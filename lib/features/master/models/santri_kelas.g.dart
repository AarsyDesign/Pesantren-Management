// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'santri_kelas.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SantriKelas _$SantriKelasFromJson(Map<String, dynamic> json) => SantriKelas(
  id: json['id'] as String,
  tenantId: json['tenantId'] as String,
  tahunAjaranId: json['tahunAjaranId'] as String,
  santriId: json['santriId'] as String,
  kelasId: json['kelasId'] as String,
  tanggalMasuk: DateTime.parse(json['tanggalMasuk'] as String),
  tanggalKeluar: json['tanggalKeluar'] == null
      ? null
      : DateTime.parse(json['tanggalKeluar'] as String),
  status: json['status'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$SantriKelasToJson(SantriKelas instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tenantId': instance.tenantId,
      'tahunAjaranId': instance.tahunAjaranId,
      'santriId': instance.santriId,
      'kelasId': instance.kelasId,
      'tanggalMasuk': instance.tanggalMasuk.toIso8601String(),
      'tanggalKeluar': instance.tanggalKeluar?.toIso8601String(),
      'status': instance.status,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
