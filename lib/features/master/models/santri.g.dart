// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'santri.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Santri _$SantriFromJson(Map<String, dynamic> json) => Santri(
  id: json['id'] as String,
  tenantId: json['tenantId'] as String,
  nis: json['nis'] as String,
  nama: json['nama'] as String,
  tanggalLahir: json['tanggalLahir'] as String?,
  jenisKelamin: json['jenisKelamin'] as String?,
  alamat: json['alamat'] as String?,
  telepon: json['telepon'] as String?,
  status: json['status'] as String,
  isDeleted: json['isDeleted'] as bool,
  createdAt: json['createdAt'] as String,
  updatedAt: json['updatedAt'] as String,
);

Map<String, dynamic> _$SantriToJson(Santri instance) => <String, dynamic>{
  'id': instance.id,
  'tenantId': instance.tenantId,
  'nis': instance.nis,
  'nama': instance.nama,
  'tanggalLahir': instance.tanggalLahir,
  'jenisKelamin': instance.jenisKelamin,
  'alamat': instance.alamat,
  'telepon': instance.telepon,
  'status': instance.status,
  'isDeleted': instance.isDeleted,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
};
