import 'package:json_annotation/json_annotation.dart';

part 'wali_santri.g.dart';

@JsonSerializable()
class WaliSantri {
  final String id;
  final String tenantId;
  final String waliId;
  final String santriId;
  final String hubungan; // ayah, ibu, wali
  final bool isActive;
  final DateTime createdAt;

  const WaliSantri({
    required this.id,
    required this.tenantId,
    required this.waliId,
    required this.santriId,
    required this.hubungan,
    this.isActive = true,
    required this.createdAt,
  });

  factory WaliSantri.fromJson(Map<String, dynamic> json) => _$WaliSantriFromJson(json);
  Map<String, dynamic> toJson() => _$WaliSantriToJson(this);
}