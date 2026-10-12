
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/pengajuan_model.dart';

class RincianLayananPage extends StatefulWidget {
  const RincianLayananPage({super.key});

  @override
  State<RincianLayananPage> createState() =>
      _RincianLayananPageState();
}

class _RincianLayananPageState extends State<RincianLayananPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _namaController =
      TextEditingController();

  final TextEditingController _emailController =
      TextEditingController();

  String? _sesiKunjungan;
  bool _setujuDataPribadi = false;

  final List<String> _pilihanSesi = [
    'Pagi (08.00-10.00)',
    'Siang (10.00-12.00)',
    'Sore (13.00-15.00)',
  ];

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _tampilkanPesan(String pesan, {bool berhasil = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(pesan),
        backgroundColor: berhasil ? Colors.green : Colors.redAccent,
      ),
    );
  }

  void _kirimPengajuan() {
    // Validasi nama, email, dan sesi kunjungan.
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Validasi persetujuan penggunaan data pribadi.
    if (!_setujuDataPribadi) {
      _tampilkanPesan(
        'Anda harus menyetujui penggunaan data pribadi.',
      );
      return;
    }

    final String nama = _namaController.text.trim();
    final String email = _emailController.text.trim();
    final String sesi = _sesiKunjungan!;

    // Simpan data sesuai parameter PengajuanModel.
    context.read<PengajuanModel>().tambahPengajuan(
      nama: nama,
      email: email,
      layanan: 'Layanan Warga',
      sesi: sesi,
    );

    _tampilkanPesan(
      'Pengajuan berhasil dikirim.',
      berhasil: true,
    );

    // Kosongkan formulir setelah berhasil.
    _formKey.currentState!.reset();
    _namaController.clear();
    _emailController.clear();

    setState(() {
      _sesiKunjungan = null;
      _setujuDataPribadi = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulir Pengajuan'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pengajuan Layanan Warga',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Lengkapi data berikut untuk mengajukan layanan publik.',
              ),
              const SizedBox(height: 24),

              // Nama lengkap
              const Text(
                'Nama Lengkap',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _namaController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  hintText: 'Masukkan nama lengkap',
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama lengkap wajib diisi.';
                  }

                  if (value.trim().length < 3) {
                    return 'Nama minimal 3 karakter.';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 18),

              // Email
              const Text(
                'Email',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'nama@email.com',
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  final email = value?.trim() ?? '';

                  if (email.isEmpty) {
                    return 'Email wajib diisi.';
                  }

                  final polaEmail =
                      RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

                  if (!polaEmail.hasMatch(email)) {
                    return 'Masukkan alamat email yang valid.';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 18),

              // Sesi kunjungan
              const Text(
                'Sesi Kunjungan',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                initialValue: _sesiKunjungan,
                isExpanded: true,
                decoration: const InputDecoration(
                  hintText: 'Pilih sesi kunjungan',
                  prefixIcon: Icon(Icons.access_time),
                  border: OutlineInputBorder(),
                ),
                items: _pilihanSesi.map((sesi) {
                  return DropdownMenuItem<String>(
                    value: sesi,
                    child: Text(sesi),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _sesiKunjungan = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Pilih sesi kunjungan.';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 18),

              // Persetujuan penggunaan data pribadi
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                value: _setujuDataPribadi,
                onChanged: (value) {
                  setState(() {
                    _setujuDataPribadi = value ?? false;
                  });
                },
                title: const Text(
                  'Saya menyetujui penggunaan data pribadi '
                  'untuk keperluan pengajuan layanan.',
                ),
              ),
              const SizedBox(height: 20),

              // Tombol kirim
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _kirimPengajuan,
                  icon: const Icon(Icons.send),
                  label: const Text('Kirim Pengajuan'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
