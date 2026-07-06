import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pesantren_management/features/master/models/wali.dart';
import 'package:pesantren_management/features/master/provider/master_provider.dart';
import 'package:pesantren_management/shared/widgets/sidebar.dart';

class WaliListPage extends ConsumerWidget {
  const WaliListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(waliListProvider());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wali Santri'),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: () => ref.read(waliListProvider().notifier).refresh()),
        ],
      ),
      drawer: const AppSidebar(),
      body: listAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (items) {
          if (items.isEmpty) {
            return const Center(child: Text('Belum ada wali'));
          }
          return ListView.separated(
            itemCount: items.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (_, i) => _row(context, ref, items[i]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/wali/new'),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _row(BuildContext context, WidgetRef ref, Wali w) {
    return ListTile(
      title: Text(w.nama),
      subtitle: Text(w.noTelp ?? w.alamat ?? ''),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(icon: const Icon(Icons.edit), onPressed: () => context.go('/wali/${w.id}/edit')),
          IconButton(icon: const Icon(Icons.delete), onPressed: () => _confirmDelete(context, ref, w)),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, Wali w) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Wali'),
        content: Text('Yakin hapus "${w.nama}"?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Batal')),
          FilledButton(
            onPressed: () async {
              Navigator.pop(ctx);
              final ok = await ref.read(waliListProvider().notifier).delete(w.id);
              if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(ok ? 'Dihapus' : 'Gagal')));
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }
}