/// App-level auth state — mirrors Supabase session.
class UserModel {
  final String id;
  final String email;
  final String? nama;
  final String? tenantId;
  final String? role;

  const UserModel({
    required this.id,
    required this.email,
    this.nama,
    this.tenantId,
    this.role,
  });

  /// Build from Supabase User + user metadata
  factory UserModel.fromSupabase(dynamic user, {String? tenantId, String? role}) {
    return UserModel(
      id: user.id as String,
      email: (user.email ?? '') as String,
      nama: user.userMetadata?['nama'] as String?,
      tenantId: tenantId,
      role: role,
    );
  }

  bool get isSuperAdmin => role == 'super_admin';
  bool get isBendahara => role == 'bendahara';
  bool get isAdmin => role == 'admin';
}
