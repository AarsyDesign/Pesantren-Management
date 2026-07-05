import 'package:intl/intl.dart';

extension IntFormatting on int {
  /// Format Rupiah tanpa desimal: 200000 → "Rp 200.000"
  String toRupiah() {
    final f = NumberFormat('#,###', 'id_ID');
    return 'Rp ${f.format(this)}';
  }
}

extension DateTimeFormatting on DateTime {
  /// 2026-07-05 → "5 Juli 2026"
  String toTanggal() {
    return DateFormat('d MMMM y', 'id_ID').format(this);
  }

  /// 2026-07-05 → "05/07/2026"
  String toTanggalPendek() {
    return DateFormat('dd/MM/yyyy', 'id_ID').format(this);
  }

  /// Nama bulan: "Juli"
  String namaBulan() {
    return DateFormat('MMMM', 'id_ID').format(this);
  }
}
