
import 'package:flutter/foundation.dart';

class Pengajuan {
  final int id;
  final String nama;
  final String email;
  final String layanan;
  final String sesi;
  final DateTime tanggal;
  bool selesai;

  Pengajuan({
    required this.id,
    required this.nama,
    required this.email,
    required this.layanan,
    required this.sesi,
    required this.tanggal,
    this.selesai = false,
  });
}

class PengajuanModel extends ChangeNotifier {
  final List<Pengajuan> _daftarPengajuan = [];

  List<Pengajuan> get daftarPengajuan =>
      List.unmodifiable(_daftarPengajuan);

  int _idBerikutnya = 1;

  void tambahPengajuan({
    required String nama,
    required String email,
    required String layanan,
    required String sesi,
  }) {
    _daftarPengajuan.add(
      Pengajuan(
        id: _idBerikutnya++,
        nama: nama,
        email: email,
        layanan: layanan,
        sesi: sesi,
        tanggal: DateTime.now(),
      ),
    );

    notifyListeners();
  }

  void tandaiSelesai(int id) {
    final index = _daftarPengajuan.indexWhere(
      (pengajuan) => pengajuan.id == id,
    );

    if (index != -1 && !_daftarPengajuan[index].selesai) {
      _daftarPengajuan[index].selesai = true;
      notifyListeners();
    }
  }

  int jumlahPerLayanan(String layanan) {
    return _daftarPengajuan
        .where((pengajuan) => pengajuan.layanan == layanan)
        .length;
  }

  int get jumlahPengajuan => _daftarPengajuan.length;

  int get jumlahSelesai =>
      _daftarPengajuan.where((pengajuan) => pengajuan.selesai).length;
}
