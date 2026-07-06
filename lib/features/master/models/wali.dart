import 'package:json_annotation/json_annotation.dart';

part 'wali.g.dart';

@JsonSerializable()
class Wali {
  final String id;
  final String tenantId;
  final String nama;
  final String? noTelp;
  final String? alamat;
  final DateTime createdAt;

  const Wali({
    required this.id,
    required this.tenantId,
    required this.nama,
    this.noTelp,
    this.alamat,
    required this.createdAt,
  });

  factory Wali.fromJson(Map<String, dynamic> json) => _$WaliFromJson(json);
  Map<String, dynamic> toJson() => _$WaliToJson(this);

  Wali copyWith({
    String? nama,
    String? noTelp,
    String? alamat,
  }) {
    return Wali(
      id: id,
      tenantId: tenantId,
      nama: nama ?? this.nama,
      noTelp: noTelp ?? this.noTelp,
      alamat: alamat ?? this.alamat,
      createdAt: createdAt,
    );
  }
}