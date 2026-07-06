import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pesantren_management/features/master/models/wali.dart';
import 'package:pesantren_management/features/master/provider/master_provider.dart';
import 'package:pesantren_management/shared/widgets/sidebar.dart';

class WaliFormPage extends ConsumerStatefulWidget {
  final String? id;
  const WaliFormPage({super.key, this.id});

  @override
  ConsumerState<WaliFormPage> createState() => _WaliFormPageState();
}

class _WaliFormPageState extends ConsumerState<WaliFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaCtrl = TextEditingController();
  final _noTelpCtrl = TextEditingController();
  final _alamatCtrl = TextEditingController();
  bool _loading = false;

  bool get isEdit => widget.id != null;

  @override
  void initState() {
    super.initState();
    if (isEdit) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _loadData());
    }
  }

  void _loadData() {
    ref.read(waliDetailProvider(widget.id!)).whenData((w) {
      if (w != null && mounted) {
        setState(() {
          _namaCtrl.text = w.nama;
          _noTelpCtrl.text = w.noTelp ?? '';
          _alamatCtrl.text = w.alamat ?? '';
        });
      }
    });
  }

  @override
  void dispose() {
    _namaCtrl.dispose();
    _noTelpCtrl.dispose();
    _alamatCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Wali' : 'Tambah Wali'),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.go('/wali')),
      ),
      drawer: const AppSidebar(),
      body: isEdit
          ? ref.watch(waliDetailProvider(widget.id!)).when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('Error: $e')),
                data: (w) => w == null ? const Center(child: Text('Tidak ditemukan')) : _form(),
              )
          : _form(),
    );
  }

  Widget _form() {
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
                  decoration: const InputDecoration(labelText: 'Nama Wali *'),
                  validator: (v) => v != null && v.isNotEmpty ? null : 'Wajib diisi',
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _noTelpCtrl,
                  decoration: const InputDecoration(labelText: 'No Telp'),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _alamatCtrl,
                  decoration: const InputDecoration(labelText: 'Alamat'),
                  maxLines: 3,
                ),
                const SizedBox(height: 32),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  OutlinedButton(onPressed: () => context.go('/wali'), child: const Text('Batal')),
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
      ok = await ref.read(waliListProvider().notifier).updateItem(
            widget.id!,
            nama: _namaCtrl.text.trim(),
            noTelp: _noTelpCtrl.text.trim().isNotEmpty ? _noTelpCtrl.text.trim() : null,
            alamat: _alamatCtrl.text.trim().isNotEmpty ? _alamatCtrl.text.trim() : null,
          );
    } else {
      ok = await ref.read(waliListProvider().notifier).create(
            nama: _namaCtrl.text.trim(),
            noTelp: _noTelpCtrl.text.trim().isNotEmpty ? _noTelpCtrl.text.trim() : null,
            alamat: _alamatCtrl.text.trim().isNotEmpty ? _alamatCtrl.text.trim() : null,
          );
    }

    setState(() => _loading = false);
    if (ok && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(isEdit ? 'Berhasil disimpan' : 'Berhasil ditambahkan')));
      context.go('/wali');
    }
  }
}