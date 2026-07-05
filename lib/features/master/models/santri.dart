import 'package:json_annotation/json_annotation.dart';

part 'santri.g.dart';

@JsonSerializable()
class Santri {
  final String id;
  final String tenantId;
  final String nis;
  final String nama;
  final String? tanggalLahir;
  final String? jenisKelamin;
  final String? alamat;
  final String? telepon;
  final String status;
  final bool isDeleted;
  final String createdAt;
  final String updatedAt;

  const Santri({
    required this.id,
    required this.tenantId,
    required this.nis,
    required this.nama,
    this.tanggalLahir,
    this.jenisKelamin,
    this.alamat,
    this.telepon,
    required this.status,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Santri.fromJson(Map<String, dynamic> json) => _$SantriFromJson(json);

  Map<String, dynamic> toJson() => _$SantriToJson(this);

  Santri copyWith({
    String? id,
    String? tenantId,
    String? nis,
    String? nama,
    String? tanggalLahir,
    String? jenisKelamin,
    String? alamat,
    String? telepon,
    String? status,
    bool? isDeleted,
    String? createdAt,
    String? updatedAt,
  }) {
    return Santri(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      nis: nis ?? this.nis,
      nama: nama ?? this.nama,
      tanggalLahir: tanggalLahir ?? this.tanggalLahir,
      jenisKelamin: jenisKelamin ?? this.jenisKelamin,
      alamat: alamat ?? this.alamat,
      telepon: telepon ?? this.telepon,
      status: status ?? this.status,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}