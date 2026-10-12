
import 'package:flutter/material.dart';
import '../navigation/app_routes.dart';

class WargaPage extends StatelessWidget {
  const WargaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nusantara Cerdas'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Selamat Datang, Warga!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Akses layanan publik dengan mudah melalui '
              'Nusantara Cerdas Mobile.',
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 24),

            // Kartu pengajuan layanan
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.assignment_outlined,
                      size: 42,
                      color: Colors.teal,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Pengajuan Layanan',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Ajukan layanan publik dan isi data '
                      'yang diperlukan.',
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.rincianLayanan,
                          );
                        },
                        child: const Text('Buat Pengajuan'),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Akses fitur lainnya
            const Text(
              'Fitur Layanan',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            _menuFitur(
              context,
              ikon: Icons.chat_bubble_outline,
              judul: 'Chat Layanan',
              deskripsi: 'Komunikasi dengan layanan warga',
              route: AppRoutes.chat,
            ),
            _menuFitur(
              context,
              ikon: Icons.map_outlined,
              judul: 'Peta Kantor',
              deskripsi: 'Lihat lokasi kantor pelayanan',
              route: AppRoutes.peta,
            ),
            _menuFitur(
              context,
              ikon: Icons.bar_chart,
              judul: 'Statistik',
              deskripsi: 'Lihat statistik pengajuan',
              route: AppRoutes.statistik,
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuFitur(
    BuildContext context, {
    required IconData ikon,
    required String judul,
    required String deskripsi,
    required String route,
  }) {
    return Card(
      child: ListTile(
        leading: Icon(ikon, color: Colors.teal, size: 30),
        title: Text(judul),
        subtitle: Text(deskripsi),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.pushNamed(context, route);
        },
      ),
    );
  }
}
