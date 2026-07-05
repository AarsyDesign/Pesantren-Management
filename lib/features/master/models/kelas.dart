import 'package:json_annotation/json_annotation.dart';

part 'kelas.g.dart';

@JsonSerializable()
class Kelas {
  final String id;
  final String tenantId;
  final String tahunAjaranId;
  final String nama;
  final int? tingkat;
  final String? waliKelas;
  final bool isDeleted;
  final String createdAt;
  final String updatedAt;

  const Kelas({
    required this.id,
    required this.tenantId,
    required this.tahunAjaranId,
    required this.nama,
    this.tingkat,
    this.waliKelas,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Kelas.fromJson(Map<String, dynamic> json) => _$KelasFromJson(json);

  Map<String, dynamic> toJson() => _$KelasToJson(this);
}