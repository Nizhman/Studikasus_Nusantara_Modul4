
import 'package:flutter/foundation.dart';

class PesanChat {
  final String teks;
  final bool dariWarga;
  final DateTime waktu;

  PesanChat({
    required this.teks,
    required this.dariWarga,
    required this.waktu,
  });
}

class ChatModel extends ChangeNotifier {
  final List<PesanChat> _pesan = [
    PesanChat(
      teks: 'Halo, ada yang bisa kami bantu?',
      dariWarga: false,
      waktu: DateTime.now(),
    ),
  ];

  List<PesanChat> get daftarPesan => List.unmodifiable(_pesan);

  void kirimPesan(String teks) {
    if (teks.trim().isEmpty) return;

    _pesan.add(
      PesanChat(
        teks: teks.trim(),
        dariWarga: true,
        waktu: DateTime.now(),
      ),
    );

    notifyListeners();
  }

  void balasPetugas(String teks) {
    if (teks.trim().isEmpty) return;

    _pesan.add(
      PesanChat(
        teks: teks.trim(),
        dariWarga: false,
        waktu: DateTime.now(),
      ),
    );

    notifyListeners();
  }
}
