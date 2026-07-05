import 'package:supabase_flutter/supabase_flutter.dart';

/// Union of application-level errors.
sealed class AppError {
  const AppError();
  String get message;
}

final class NetworkError extends AppError {
  final String? detail;
  const NetworkError([this.detail]);
  @override String get message => detail ?? 'Terjadi kesalahan jaringan';
}

final class AuthError extends AppError {
  final String? detail;
  const AuthError([this.detail]);
  @override String get message => detail ?? 'Gagal autentikasi';
}

final class ValidationError extends AppError {
  final String detail;
  const ValidationError(this.detail);
  @override String get message => detail;
}

final class DatabaseError extends AppError {
  final String? detail;
  const DatabaseError([this.detail]);
  @override String get message => detail ?? 'Kesalahan database';
}

final class UnknownError extends AppError {
  final Object source;
  const UnknownError(this.source);
  @override String get message => 'Terjadi kesalahan: $source';
}

/// Convert Supabase/postgrest exception → AppError
AppError mapSupabaseError(Object e) {
  return switch (e) {
    PostgrestException(:final message) => DatabaseError(message),
    AuthException(:final message) => AuthError(message),
    _ => UnknownError(e),
  };
}
