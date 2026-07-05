import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pesantren_management/features/auth/models/user.dart';
import 'package:pesantren_management/features/auth/repo/auth_repo.dart';
import 'package:pesantren_management/shared/providers/supabase_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_provider.g.dart';

final authRepoProvider = Provider<AuthRepo>((ref) => AuthRepo(ref.watch(supabaseClientProvider)));

/// Current logged-in user state.
@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  Future<UserModel?> build() async {
    final user = await ref.read(authRepoProvider).restoreSession();
    _listenToSignOut();
    return user;
  }

  void _listenToSignOut() {
    ref.read(authRepoProvider).authStateChanges().listen((authState) {
      if (authState.event == AuthChangeEvent.signedOut) {
        state = const AsyncData(null);
      }
    });
  }

  Future<bool> login(String email, String password) async {
    state = const AsyncLoading();
    final result = await ref.read(authRepoProvider).login(email, password);
    return result.fold(
      (user) {
        state = AsyncData(user);
        return true;
      },
      (error) {
        state = AsyncError(error, StackTrace.current);
        return false;
      },
    );
  }

  Future<void> logout() async {
    await ref.read(authRepoProvider).logout();
    state = const AsyncData(null);
  }

  Future<void> resetPassword(String email) async {
    await ref.read(authRepoProvider).resetPassword(email);
  }
}
