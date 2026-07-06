// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wali_santri.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WaliSantri _$WaliSantriFromJson(Map<String, dynamic> json) => WaliSantri(
  id: json['id'] as String,
  tenantId: json['tenantId'] as String,
  waliId: json['waliId'] as String,
  santriId: json['santriId'] as String,
  hubungan: json['hubungan'] as String,
  isActive: json['isActive'] as bool? ?? true,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$WaliSantriToJson(WaliSantri instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tenantId': instance.tenantId,
      'waliId': instance.waliId,
      'santriId': instance.santriId,
      'hubungan': instance.hubungan,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt.toIso8601String(),
    };
