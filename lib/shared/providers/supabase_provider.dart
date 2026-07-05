import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pesantren_management/supabase_client.dart';

part 'supabase_provider.g.dart';

@riverpod
SupabaseClient supabaseClient(SupabaseClientRef ref) => supabase;

// Name the provider the same as the function
