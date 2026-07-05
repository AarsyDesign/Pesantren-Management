import 'package:json_annotation/json_annotation.dart';

part 'santri_kelas.g.dart';

@JsonSerializable()
class SantriKelas {
  final String id;
  final String tenantId;
  final String tahunAjaranId;
  final String santriId;
  final String kelasId;
  final DateTime tanggalMasuk;
  final DateTime? tanggalKeluar;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  SantriKelas({
    required this.id,
    required this.tenantId,
    required this.tahunAjaranId,
    required this.santriId,
    required this.kelasId,
    required this.tanggalMasuk,
    this.tanggalKeluar,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SantriKelas.fromJson(Map<String, dynamic> json) =>
      _$SantriKelasFromJson(json);

  Map<String, dynamic> toJson() => _$SantriKelasToJson(this);

  SantriKelas copyWith({
    String? id,
    String? tenantId,
    String? tahunAjaranId,
    String? santriId,
    String? kelasId,
    DateTime? tanggalMasuk,
    DateTime? tanggalKeluar,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      SantriKelas(
        id: id ?? this.id,
        tenantId: tenantId ?? this.tenantId,
        tahunAjaranId: tahunAjaranId ?? this.tahunAjaranId,
        santriId: santriId ?? this.santriId,
        kelasId: kelasId ?? this.kelasId,
        tanggalMasuk: tanggalMasuk ?? this.tanggalMasuk,
        tanggalKeluar: tanggalKeluar ?? this.tanggalKeluar,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
}