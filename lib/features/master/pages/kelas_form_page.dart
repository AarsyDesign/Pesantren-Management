import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pesantren_management/features/master/provider/master_provider.dart';

class KelasFormPage extends ConsumerStatefulWidget {
  final String? id;
  final String? tahunAjaranId;
  const KelasFormPage({super.key, this.id, this.tahunAjaranId});

  @override
  ConsumerState<KelasFormPage> createState() => _KelasFormPageState();
}

class _KelasFormPageState extends ConsumerState<KelasFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaCtrl = TextEditingController();
  final _kapasitasCtrl = TextEditingController(text: '30');
  String? _waliId;
  bool _loading = false;

  bool get isEdit => widget.id != null;
  String get tahunAjaranId => widget.tahunAjaranId ?? '';

  @override
  void initState() {
    super.initState();
    if (isEdit) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _loadData());
    }
  }

  void _loadData() {
    ref.read(kelasDetailProvider(widget.id!)).whenData((k) {
      if (k != null && mounted) {
        setState(() {
          _namaCtrl.text = k.nama;
          _kapasitasCtrl.text = k.kapasitas.toString();
          _waliId = k.waliId;
        });
      }
    });
  }

  @override
  void dispose() {
    _namaCtrl.dispose();
    _kapasitasCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Kelas' : 'Tambah Kelas'),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.go('/kelas')),
      ),
      body: isEdit
          ? ref.watch(kelasDetailProvider(widget.id!)).when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('Error: $e')),
                data: (k) => k == null ? const Center(child: Text('Tidak ditemukan')) : _form(),
              )
          : _form(),
    );
  }

  Widget _form() {
    if (tahunAjaranId.isEmpty && !isEdit) {
      return const Center(child: Text('Tahun Ajaran harus dipilih'));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _namaCtrl,
                  decoration: const InputDecoration(labelText: 'Nama Kelas *'),
                  validator: (v) => v != null && v.isNotEmpty ? null : 'Wajib diisi',
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _kapasitasCtrl,
                  decoration: const InputDecoration(labelText: 'Kapasitas'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _waliId,
                  decoration: const InputDecoration(labelText: 'Wali Kelas'),
                  items: const [
                    DropdownMenuItem(value: null, child: Text('-')),
                    DropdownMenuItem(value: '1', child: Text('Ust. Ahmad')),
                    DropdownMenuItem(value: '2', child: Text('Ust. Budi')),
                  ],
                  onChanged: (v) => setState(() => _waliId = v),
                ),
                const SizedBox(height: 32),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  OutlinedButton(onPressed: () => context.go('/kelas'), child: const Text('Batal')),
                  const SizedBox(width: 12),
                  FilledButton(
                    onPressed: _loading ? null : _onSubmit,
                    child: _loading
                        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                        : Text(isEdit ? 'Simpan' : 'Tambah'),
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);

    bool ok;
    if (isEdit) {
      ok = await ref.read(kelasListProvider(tahunAjaranId: tahunAjaranId).notifier).updateItem(
            widget.id!,
            nama: _namaCtrl.text.trim(),
            waliId: _waliId,
            kapasitas: int.tryParse(_kapasitasCtrl.text) ?? 30,
          );
    } else {
      ok = await ref.read(kelasListProvider(tahunAjaranId: tahunAjaranId).notifier).create(
            tahunAjaranId: tahunAjaranId,
            nama: _namaCtrl.text.trim(),
            waliId: _waliId,
            kapasitas: int.tryParse(_kapasitasCtrl.text) ?? 30,
          );
    }

    setState(() => _loading = false);
    if (ok && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(isEdit ? 'Berhasil disimpan' : 'Berhasil ditambahkan')));
      context.go('/kelas');
    }
  }
}