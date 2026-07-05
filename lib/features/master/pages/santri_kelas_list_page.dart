import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pesantren_management/features/master/models/santri_kelas.dart';
import 'package:pesantren_management/features/master/provider/master_provider.dart';
import 'package:pesantren_management/shared/widgets/async_value_widget.dart';
import 'package:pesantren_management/shared/widgets/sidebar.dart';

class SantriKelasListPage extends ConsumerStatefulWidget {
  final String? tahunAjaranId;
  final String? kelasId;
  const SantriKelasListPage({super.key, this.tahunAjaranId, this.kelasId});

  @override
  ConsumerState<SantriKelasListPage> createState() => _SantriKelasListPageState();
}

class _SantriKelasListPageState extends ConsumerState<SantriKelasListPage> {
  @override
  Widget build(BuildContext context) {
    final listAsync = ref.watch(santriKelasListProvider(
      tahunAjaranId: widget.tahunAjaranId,
      kelasId: widget.kelasId,
    ));

    return Scaffold(
      appBar: AppBar(title: const Text('Rombel Santri')),
      drawer: const AppSidebar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                FilledButton.icon(
                  onPressed: () => context.go('/santri-kelas/enroll${_queryParams()}'),
                  icon: const Icon(Icons.person_add),
                  label: const Text('Tambah Santri'),
                ),
              ],
            ),
          ),
          Expanded(
            child: AsyncValueWidget<List<SantriKelas>>(
              value: listAsync,
              data: (items) {
                if (items.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.group, size: 64, color: Colors.grey),
                        SizedBox(height: 12),
                        Text('Belum ada data rombel', style: TextStyle(color: Colors.grey)),
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

  String _queryParams() {
    final params = <String>[];
    if (widget.tahunAjaranId != null) params.add('tahunAjaranId=${widget.tahunAjaranId}');
    if (widget.kelasId != null) params.add('kelasId=${widget.kelasId}');
    return params.isEmpty ? '' : '?${params.join('&')}';
  }

  Widget _row(SantriKelas sk) {
    return ListTile(
      title: Text('Santri #${sk.santriId}'),
      subtitle: Text('Kelas: ${sk.kelasId} • ${sk.status}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(icon: const Icon(Icons.swap_horiz), onPressed: () => _transferDialog(sk)),
          IconButton(icon: const Icon(Icons.logout), onPressed: () => _dropDialog(sk)),
          IconButton(icon: const Icon(Icons.delete), onPressed: () => _confirmDelete(sk)),
        ],
      ),
    );
  }

  void _transferDialog(SantriKelas sk) {
    final ctrl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Pindah Kelas'),
        content: TextField(
          controller: ctrl,
          decoration: const InputDecoration(labelText: 'Kelas ID Baru'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Batal')),
          FilledButton(
            onPressed: () async {
              Navigator.pop(ctx);
              final ok = await ref.read(santriKelasListProvider().notifier).transfer(sk.id, newKelasId: ctrl.text);
              if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(ok ? 'Dipindah' : 'Gagal')));
            },
            child: const Text('Pindah'),
          ),
        ],
      ),
    );
  }

  void _dropDialog(SantriKelas sk) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Keluar Santri'),
        content: Text('Keluarkan santri ini dari kelas?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Batal')),
          FilledButton(
            onPressed: () async {
              Navigator.pop(ctx);
              final ok = await ref.read(santriKelasListProvider().notifier).drop(sk.id);
              if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(ok ? 'Dikeluarkan' : 'Gagal')));
            },
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(SantriKelas sk) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Rombel'),
        content: Text('Yakin hapus data ini?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Batal')),
          FilledButton(
            onPressed: () async {
              Navigator.pop(ctx);
              final ok = await ref.read(santriKelasListProvider().notifier).delete(sk.id);
              if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(ok ? 'Dihapus' : 'Gagal')));
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }
}