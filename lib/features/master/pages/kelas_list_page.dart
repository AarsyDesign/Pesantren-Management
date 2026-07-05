import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pesantren_management/features/master/models/kelas.dart';
import 'package:pesantren_management/features/master/provider/master_provider.dart';
import 'package:pesantren_management/shared/widgets/async_value_widget.dart';
import 'package:pesantren_management/shared/widgets/sidebar.dart';

class KelasListPage extends ConsumerStatefulWidget {
  final String? tahunAjaranId;
  const KelasListPage({super.key, this.tahunAjaranId});

  @override
  ConsumerState<KelasListPage> createState() => _KelasListPageState();
}

class _KelasListPageState extends ConsumerState<KelasListPage> {
  @override
  Widget build(BuildContext context) {
    final listAsync = ref.watch(kelasListProvider(tahunAjaranId: widget.tahunAjaranId));

    return Scaffold(
      appBar: AppBar(title: const Text('Kelas')),
      drawer: const AppSidebar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                FilledButton.icon(
                  onPressed: () => context.go('/kelas/new${widget.tahunAjaranId != null ? '?tahunAjaranId=${widget.tahunAjaranId}' : ''}'),
                  icon: const Icon(Icons.add),
                  label: const Text('Tambah'),
                ),
              ],
            ),
          ),
          Expanded(
            child: AsyncValueWidget<List<Kelas>>(
              value: listAsync,
              data: (items) {
                if (items.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.class_, size: 64, color: Colors.grey),
                        SizedBox(height: 12),
                        Text('Belum ada kelas', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  );
                }
                return ListView.separated(
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (_, i) => _row(items[i]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(Kelas k) {
    return ListTile(
      title: Text(k.nama),
      subtitle: Text('Kapasitas: ${k.kapasitas}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(icon: const Icon(Icons.edit), onPressed: () => context.go('/kelas/${k.id}/edit')),
          IconButton(icon: const Icon(Icons.delete), onPressed: () => _confirmDelete(k)),
        ],
      ),
    );
  }

  void _confirmDelete(Kelas k) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Kelas'),
        content: Text('Yakin hapus "${k.nama}"?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Batal')),
          FilledButton(
            onPressed: () async {
              Navigator.pop(ctx);
              final ok = await ref.read(kelasListProvider(tahunAjaranId: widget.tahunAjaranId).notifier).delete(k.id);
              if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(ok ? 'Dihapus' : 'Gagal')));
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }
}