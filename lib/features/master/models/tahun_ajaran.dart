import 'package:json_annotation/json_annotation.dart';

part 'tahun_ajaran.g.dart';

@JsonSerializable()
class TahunAjaran {
  final String id;
  final String tenantId;
  final String nama;
  final DateTime mulai;
  final DateTime selesai;
  final bool aktif;
  final DateTime createdAt;
  final DateTime updatedAt;

  TahunAjaran({
    required this.id,
    required this.tenantId,
    required this.nama,
    required this.mulai,
    required this.selesai,
    required this.aktif,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TahunAjaran.fromJson(Map<String, dynamic> json) =>
      _$TahunAjaranFromJson(json);

  Map<String, dynamic> toJson() => _$TahunAjaranToJson(this);

  TahunAjaran copyWith({
    String? id,
    String? tenantId,
    String? nama,
    DateTime? mulai,
    DateTime? selesai,
    bool? aktif,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      TahunAjaran(
        id: id ?? this.id,
        tenantId: tenantId ?? this.tenantId,
        nama: nama ?? this.nama,
        mulai: mulai ?? this.mulai,
        selesai: selesai ?? this.selesai,
        aktif: aktif ?? this.aktif,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
}