import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pesantren_management/features/master/models/santri.dart';
import 'package:pesantren_management/features/master/provider/santri_provider.dart';
import 'package:pesantren_management/shared/widgets/async_value_widget.dart';
import 'package:pesantren_management/shared/widgets/sidebar.dart';

class SantriListPage extends ConsumerStatefulWidget {
  const SantriListPage({super.key});

  @override
  ConsumerState<SantriListPage> createState() => _SantriListPageState();
}

class _SantriListPageState extends ConsumerState<SantriListPage> {
  final _searchCtrl = TextEditingController();
  String? _selectedStatus;

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final listAsync = ref.watch(santriListProvider(
      search: _searchCtrl.text.trim().isEmpty ? null : _searchCtrl.text.trim(),
      status: _selectedStatus,
    ));

    return Scaffold(
      appBar: AppBar(title: const Text('Data Santri')),
      drawer: const AppSidebar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(children: [
              Expanded(
                child: TextField(
                  controller: _searchCtrl,
                  decoration: const InputDecoration(
                    hintText: 'Cari NIS atau nama...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (_) => ref.invalidate(santriListProvider(
                    search: _searchCtrl.text.trim().isEmpty
                        ? null
                        : _searchCtrl.text.trim(),
                    status: _selectedStatus,
                  )),
                ),
              ),
              const SizedBox(width: 12),
              DropdownButton<String?>(
                value: _selectedStatus,
                hint: const Text('Status'),
                items: const [
                  DropdownMenuItem(value: null, child: Text('Semua')),
                  DropdownMenuItem(value: 'aktif', child: Text('Aktif')),
                  DropdownMenuItem(value: 'nonaktif', child: Text('Nonaktif')),
                  DropdownMenuItem(value: 'lulus', child: Text('Lulus')),
                  DropdownMenuItem(value: 'keluar', child: Text('Keluar')),
                ],
                onChanged: (v) {
                  setState(() => _selectedStatus = v);
                  ref.invalidate(santriListProvider(
                    search: _searchCtrl.text.trim().isEmpty
                        ? null
                        : _searchCtrl.text.trim(),
                    status: v,
                  ));
                },
              ),
              const SizedBox(width: 12),
              FilledButton.icon(
                onPressed: () => context.go('/santri/new'),
                icon: const Icon(Icons.add),
                label: const Text('Tambah'),
              ),
            ]),
          ),
          Expanded(
            child: AsyncValueWidget<List<Santri>>(
              value: listAsync,
              data: (santris) {
                if (santris.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.inbox, size: 64, color: Colors.grey),
                        SizedBox(height: 12),
                        Text('Belum ada data santri',
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  );
                }
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('NIS')),
                        DataColumn(label: Text('Nama')),
                        DataColumn(label: Text('JK')),
                        DataColumn(label: Text('Status')),
                        DataColumn(label: Text('Aksi')),
                      ],
                      rows: santris.map((s) => _row(s)).toList(),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  DataRow _row(Santri s) {
    return DataRow(
      cells: [
        DataCell(Text(s.nis)),
        DataCell(
          InkWell(
            onTap: () => context.go('/santri/${s.id}'),
            child: Text(s.nama,
                style: const TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.blue)),
          ),
        ),
        DataCell(Text(s.jenisKelamin ?? '-')),
        DataCell(_statusChip(s.status)),
        DataCell(Row(mainAxisSize: MainAxisSize.min, children: [
          IconButton(
            icon: const Icon(Icons.edit, size: 20),
            onPressed: () => context.go('/santri/${s.id}/edit'),
          ),
          IconButton(
            icon: const Icon(Icons.delete, size: 20),
            onPressed: () => _confirmDelete(s),
          ),
        ])),
      ],
    );
  }

  Widget _statusChip(String status) {
    final color = switch (status) {
      'aktif' => Colors.green,
      'nonaktif' => Colors.grey,
      'lulus' => Colors.blue,
      'keluar' => Colors.red,
      _ => Colors.grey,
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color),
      ),
      child: Text(status, style: TextStyle(color: color, fontSize: 12)),
    );
  }

  void _confirmDelete(Santri s) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Santri'),
        content: Text('Yakin hapus "${s.nama}" (NIS: ${s.nis})?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Batal')),
          FilledButton(
            onPressed: () async {
              Navigator.pop(ctx);
              final ok = await ref.read(santriListProvider().notifier).delete(s.id);
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(ok ? 'Dihapus' : 'Gagal')),
                );
              }
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }
}