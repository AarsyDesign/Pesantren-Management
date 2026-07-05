import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pesantren_management/features/master/models/tahun_ajaran.dart';
import 'package:pesantren_management/features/master/provider/master_provider.dart';
import 'package:pesantren_management/shared/widgets/async_value_widget.dart';
import 'package:pesantren_management/shared/widgets/sidebar.dart';

class TahunAjaranListPage extends ConsumerStatefulWidget {
  const TahunAjaranListPage({super.key});

  @override
  ConsumerState<TahunAjaranListPage> createState() => _TahunAjaranListPageState();
}

class _TahunAjaranListPageState extends ConsumerState<TahunAjaranListPage> {
  @override
  Widget build(BuildContext context) {
    final listAsync = ref.watch(tahunAjaranListProvider());

    return Scaffold(
      appBar: AppBar(title: const Text('Tahun Ajaran')),
      drawer: const AppSidebar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                FilledButton.icon(
                  onPressed: () => context.go('/tahun-ajaran/new'),
                  icon: const Icon(Icons.add),
                  label: const Text('Tambah'),
                ),
              ],
            ),
          ),
          Expanded(
            child: AsyncValueWidget<List<TahunAjaran>>(
              value: listAsync,
              data: (items) {
                if (items.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.calendar_today, size: 64, color: Colors.grey),
                        SizedBox(height: 12),
                        Text('Belum ada tahun ajaran', style: TextStyle(color: Colors.grey)),
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

  Widget _row(TahunAjaran t) {
    final dateRange = '${_fmt(t.mulai)} – ${_fmt(t.selesai)}';
    return ListTile(
      title: Text(t.nama),
      subtitle: Text(dateRange),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (t.aktif)
            const Chip(label: Text('Aktif'), backgroundColor: Colors.green, labelStyle: TextStyle(color: Colors.white)),
          IconButton(icon: const Icon(Icons.edit), onPressed: () => context.go('/tahun-ajaran/${t.id}/edit')),
          IconButton(icon: const Icon(Icons.delete), onPressed: () => _confirmDelete(t)),
        ],
      ),
    );
  }

  String _fmt(DateTime d) => '${d.day}/${d.month}/${d.year}';

  void _confirmDelete(TahunAjaran t) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Tahun Ajaran'),
        content: Text('Yakin hapus "${t.nama}"?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Batal')),
          FilledButton(
            onPressed: () async {
              Navigator.pop(ctx);
              final ok = await ref.read(tahunAjaranListProvider().notifier).delete(t.id);
              if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(ok ? 'Dihapus' : 'Gagal')));
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }
}