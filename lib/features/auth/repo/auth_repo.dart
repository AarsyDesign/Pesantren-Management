import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pesantren_management/core/error.dart';
import 'package:pesantren_management/core/result.dart';
import 'package:pesantren_management/features/auth/models/user.dart';

class AuthRepo {
  final SupabaseClient _client;

  AuthRepo(this._client);

  Future<Result<UserModel, AppError>> login(String email, String password) async {
    try {
      final res = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (res.user == null) {
        return const Err(AuthError('User tidak ditemukan'));
      }
      return Ok(UserModel.fromSupabase(res.user));
    } on AuthException catch (e) {
      return Err(AuthError(e.message));
    } catch (e) {
      return Err(mapSupabaseError(e));
    }
  }

  Future<void> logout() async {
    await _client.auth.signOut();
  }

  Future<UserModel?> restoreSession() async {
    final user = _client.auth.currentUser;
    if (user == null) return null;
    return UserModel.fromSupabase(user);
  }

  Stream<AuthState> authStateChanges() => _client.auth.onAuthStateChange;

  Future<Result<void, AppError>> resetPassword(String email) async {
    try {
      await _client.auth.resetPasswordForEmail(email);
      return const Ok(null);
    } on AuthException catch (e) {
      return Err(AuthError(e.message));
    }
  }
}
