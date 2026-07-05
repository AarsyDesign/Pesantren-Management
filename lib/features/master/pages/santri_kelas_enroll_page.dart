import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pesantren_management/features/master/provider/master_provider.dart';

class SantriKelasEnrollPage extends ConsumerStatefulWidget {
  final String? tahunAjaranId;
  final String? kelasId;
  const SantriKelasEnrollPage({super.key, this.tahunAjaranId, this.kelasId});

  @override
  ConsumerState<SantriKelasEnrollPage> createState() => _SantriKelasEnrollPageState();
}

class _SantriKelasEnrollPageState extends ConsumerState<SantriKelasEnrollPage> {
  final _formKey = GlobalKey<FormState>();
  String? _santriId;
  String? _kelasId;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Santri ke Kelas'),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.go('/santri-kelas')),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DropdownButtonFormField<String>(
                    value: _santriId,
                    decoration: const InputDecoration(labelText: 'Santri *'),
                    items: const [],
                    onChanged: (v) => setState(() => _santriId = v),
                    validator: (v) => v != null ? null : 'Pilih santri',
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _kelasId ?? widget.kelasId,
                    decoration: const InputDecoration(labelText: 'Kelas *'),
                    items: const [],
                    onChanged: (v) => setState(() => _kelasId = v),
                    validator: (v) => v != null ? null : 'Pilih kelas',
                  ),
                  const SizedBox(height: 32),
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    OutlinedButton(onPressed: () => context.go('/santri-kelas'), child: const Text('Batal')),
                    const SizedBox(width: 12),
                    FilledButton(
                      onPressed: _loading ? null : _onSubmit,
                      child: _loading
                          ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                          : const Text('Tambah'),
                    ),
                  ]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_santriId == null || _kelasId == null) return;
    setState(() => _loading = true);

    final ok = await ref.read(santriKelasListProvider().notifier).enroll(
      tahunAjaranId: widget.tahunAjaranId!,
      santriId: _santriId!,
      kelasId: _kelasId!,
    );

    setState(() => _loading = false);
    if (ok && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Berhasil ditambahkan')));
      context.go('/santri-kelas');
    }
  }
}