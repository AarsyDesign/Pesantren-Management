import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pesantren_management/features/master/provider/santri_provider.dart';

class SantriFormPage extends ConsumerStatefulWidget {
  final String? id;
  const SantriFormPage({super.key, this.id});

  @override
  ConsumerState<SantriFormPage> createState() => _SantriFormPageState();
}

class _SantriFormPageState extends ConsumerState<SantriFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nisCtrl = TextEditingController();
  final _namaCtrl = TextEditingController();
  final _alamatCtrl = TextEditingController();
  final _teleponCtrl = TextEditingController();
  String? _tanggalLahir;
  String? _jenisKelamin;
  String _status = 'aktif';
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
    ref.read(santriDetailProvider(widget.id!)).whenData((s) {
      if (s != null && mounted) {
        setState(() {
          _nisCtrl.text = s.nis;
          _namaCtrl.text = s.nama;
          _alamatCtrl.text = s.alamat ?? '';
          _teleponCtrl.text = s.telepon ?? '';
          _tanggalLahir = s.tanggalLahir;
          _jenisKelamin = s.jenisKelamin;
          _status = s.status;
        });
      }
    });
  }

  @override
  void dispose() {
    _nisCtrl.dispose();
    _namaCtrl.dispose();
    _alamatCtrl.dispose();
    _teleponCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Santri' : 'Tambah Santri'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/santri'),
        ),
      ),
      body: isEdit
          ? ref.watch(santriDetailProvider(widget.id!)).when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('Error: $e')),
                data: (s) => s == null
                    ? const Center(child: Text('Tidak ditemukan'))
                    : _form(),
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
                  controller: _nisCtrl,
                  decoration: const InputDecoration(labelText: 'NIS *'),
                  validator: (v) =>
                      v != null && v.isNotEmpty ? null : 'NIS wajib diisi',
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _namaCtrl,
                  decoration: const InputDecoration(labelText: 'Nama Lengkap *'),
                  validator: (v) =>
                      v != null && v.isNotEmpty ? null : 'Nama wajib diisi',
                ),
                const SizedBox(height: 16),
                Row(children: [
                  Expanded(
                    child: InkWell(
                      onTap: _pickDate,
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Tanggal Lahir',
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                        child: Text(_tanggalLahir ?? '-'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _jenisKelamin,
                      decoration: const InputDecoration(labelText: 'Jenis Kelamin'),
                      items: const [
                        DropdownMenuItem(value: null, child: Text('-')),
                        DropdownMenuItem(value: 'L', child: Text('Laki-laki')),
                        DropdownMenuItem(value: 'P', child: Text('Perempuan')),
                      ],
                      onChanged: (v) => setState(() => _jenisKelamin = v),
                    ),
                  ),
                ]),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _alamatCtrl,
                  decoration: const InputDecoration(labelText: 'Alamat'),
                  maxLines: 2,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _teleponCtrl,
                  decoration: const InputDecoration(labelText: 'Telepon'),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _status,
                  decoration: const InputDecoration(labelText: 'Status'),
                  items: const [
                    DropdownMenuItem(value: 'aktif', child: Text('Aktif')),
                    DropdownMenuItem(value: 'nonaktif', child: Text('Nonaktif')),
                    DropdownMenuItem(value: 'lulus', child: Text('Lulus')),
                    DropdownMenuItem(value: 'keluar', child: Text('Keluar')),
                  ],
                  onChanged: (v) => setState(() => _status = v ?? 'aktif'),
                ),
                const SizedBox(height: 32),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  OutlinedButton(
                    onPressed: () => context.go('/santri'),
                    child: const Text('Batal'),
                  ),
                  const SizedBox(width: 12),
                  FilledButton(
                    onPressed: _loading ? null : _onSubmit,
                    child: _loading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
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

  void _pickDate() async {
    final now = DateTime.now();
    final pick = await showDatePicker(
      context: context,
      initialDate: DateTime.tryParse(_tanggalLahir ?? '') ?? now,
      firstDate: DateTime(1990),
      lastDate: now,
    );
    if (pick != null) {
      setState(() => _tanggalLahir = pick.toIso8601String().split('T').first);
    }
  }

  void _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);

    bool ok;
    if (isEdit) {
      ok = await ref.read(santriListProvider().notifier).updateSantri(
            widget.id!,
            nis: _nisCtrl.text.trim(),
            nama: _namaCtrl.text.trim(),
            tanggalLahir: _tanggalLahir,
            jenisKelamin: _jenisKelamin,
            alamat: _alamatCtrl.text.trim(),
            telepon: _teleponCtrl.text.trim(),
            status: _status,
          );
    } else {
      ok = await ref.read(santriListProvider().notifier).create(
            nis: _nisCtrl.text.trim(),
            nama: _namaCtrl.text.trim(),
            tanggalLahir: _tanggalLahir,
            jenisKelamin: _jenisKelamin,
            alamat: _alamatCtrl.text.trim(),
            telepon: _teleponCtrl.text.trim(),
            status: _status,
          );
    }

    setState(() => _loading = false);
    if (ok && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(isEdit ? 'Berhasil disimpan' : 'Berhasil ditambahkan')),
      );
      context.go('/santri');
    }
  }
}