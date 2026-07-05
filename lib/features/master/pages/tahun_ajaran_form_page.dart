import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pesantren_management/features/master/provider/master_provider.dart';

class TahunAjaranFormPage extends ConsumerStatefulWidget {
  final String? id;
  const TahunAjaranFormPage({super.key, this.id});

  @override
  ConsumerState<TahunAjaranFormPage> createState() => _TahunAjaranFormPageState();
}

class _TahunAjaranFormPageState extends ConsumerState<TahunAjaranFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaCtrl = TextEditingController();
  DateTime? _mulai;
  DateTime? _selesai;
  bool _aktif = false;
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
    ref.read(tahunAjaranDetailProvider(widget.id!)).whenData((t) {
      if (t != null && mounted) {
        setState(() {
          _namaCtrl.text = t.nama;
          _mulai = t.mulai;
          _selesai = t.selesai;
          _aktif = t.aktif;
        });
      }
    });
  }

  @override
  void dispose() {
    _namaCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Tahun Ajaran' : 'Tambah Tahun Ajaran'),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.go('/tahun-ajaran')),
      ),
      body: isEdit
          ? ref.watch(tahunAjaranDetailProvider(widget.id!)).when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('Error: $e')),
                data: (t) => t == null ? const Center(child: Text('Tidak ditemukan')) : _form(),
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
                  decoration: const InputDecoration(labelText: 'Nama Tahun Ajaran *'),
                  validator: (v) => v != null && v.isNotEmpty ? null : 'Wajib diisi',
                ),
                const SizedBox(height: 16),
                Row(children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => _pickDate(isMulai: true),
                      child: InputDecorator(
                        decoration: const InputDecoration(labelText: 'Mulai *', suffixIcon: Icon(Icons.calendar_today)),
                        child: Text(_mulai != null ? _fmt(_mulai!) : '-'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: InkWell(
                      onTap: () => _pickDate(isMulai: false),
                      child: InputDecorator(
                        decoration: const InputDecoration(labelText: 'Selesai *', suffixIcon: Icon(Icons.calendar_today)),
                        child: Text(_selesai != null ? _fmt(_selesai!) : '-'),
                      ),
                    ),
                  ),
                ]),
                const SizedBox(height: 16),
                CheckboxListTile(
                  title: const Text('Tahun Ajaran Aktif'),
                  value: _aktif,
                  onChanged: (v) => setState(() => _aktif = v ?? false),
                ),
                const SizedBox(height: 32),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  OutlinedButton(onPressed: () => context.go('/tahun-ajaran'), child: const Text('Batal')),
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

  String _fmt(DateTime d) => '${d.day}/${d.month}/${d.year}';

  void _pickDate({required bool isMulai}) async {
    final pick = await showDatePicker(
      context: context,
      initialDate: isMulai ? _mulai ?? DateTime.now() : _selesai ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );
    if (pick != null) {
      setState(() {
        if (isMulai) _mulai = pick;
        else _selesai = pick;
      });
    }
  }

  void _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_mulai == null || _selesai == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Tanggal wajib diisi')));
      return;
    }
    setState(() => _loading = true);

    bool ok;
    if (isEdit) {
      ok = await ref.read(tahunAjaranListProvider().notifier).updateItem(
            widget.id!,
            nama: _namaCtrl.text.trim(),
            mulai: _mulai,
            selesai: _selesai,
            aktif: _aktif,
          );
    } else {
      ok = await ref.read(tahunAjaranListProvider().notifier).create(
            nama: _namaCtrl.text.trim(),
            mulai: _mulai!,
            selesai: _selesai!,
            aktif: _aktif,
          );
    }

    setState(() => _loading = false);
    if (ok && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(isEdit ? 'Berhasil disimpan' : 'Berhasil ditambahkan')));
      context.go('/tahun-ajaran');
    }
  }
}