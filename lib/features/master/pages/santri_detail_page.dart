import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pesantren_management/features/master/models/santri.dart';
import 'package:pesantren_management/features/master/provider/santri_provider.dart';
import 'package:pesantren_management/shared/widgets/async_value_widget.dart';

class SantriDetailPage extends ConsumerWidget {
  final String id;
  const SantriDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(santriDetailProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Santri'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/santri'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.go('/santri/$id/edit'),
          ),
        ],
      ),
      body: AsyncValueWidget<Santri?>(
        value: detailAsync,
        data: (s) {
          if (s == null) {
            return const Center(child: Text('Santri tidak ditemukan'));
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 48,
                      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                      child: Text(
                        s.nama.isNotEmpty ? s.nama[0].toUpperCase() : '?',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(s.nama,
                        style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: 4),
                    Text('NIS: ${s.nis}',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.grey[600],
                            )),
                    const SizedBox(height: 24),
                    _DetailCard(s: s),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _DetailCard extends StatelessWidget {
  final Santri s;
  const _DetailCard({required this.s});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _row('Jenis Kelamin', s.jenisKelamin ?? '-'),
            const Divider(),
            _row('Tanggal Lahir', s.tanggalLahir ?? '-'),
            const Divider(),
            _row('Alamat', s.alamat ?? '-'),
            const Divider(),
            _row('Telepon', s.telepon ?? '-'),
            const Divider(),
            _row('Status', s.status),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          width: 120,
          child: Text(label, style: const TextStyle(color: Colors.grey)),
        ),
        Expanded(child: Text(value, style: const TextStyle(fontWeight: FontWeight.w500))),
      ]),
    );
  }
}