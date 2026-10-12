
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';

import '../model/pengajuan_model.dart';

class StatistikPage extends StatelessWidget {
  const StatistikPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PengajuanModel>(
      builder: (context, model, child) {
        final daftarPengajuan = model.daftarPengajuan;

        final total = model.jumlahPengajuan;
        final selesai = model.jumlahSelesai;
        final menunggu = total - selesai;

        final persentase = total == 0
            ? 0.0
            : (selesai / total) * 100;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Statistik Pengajuan'),
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Ringkasan Pengajuan Layanan',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Data berdasarkan pengajuan layanan yang tercatat.',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 16),

                // Kartu statistik
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.45,
                  children: [
                    _KartuStatistik(
                      judul: 'Total Pengajuan',
                      jumlah: total.toString(),
                      warna: Colors.blue,
                      ikon: Icons.assignment,
                    ),
                    _KartuStatistik(
                      judul: 'Menunggu Diproses',
                      jumlah: menunggu.toString(),
                      warna: Colors.orange,
                      ikon: Icons.pending_actions,
                    ),
                    _KartuStatistik(
                      judul: 'Selesai',
                      jumlah: selesai.toString(),
                      warna: Colors.green,
                      ikon: Icons.check_circle_outline,
                    ),
                    _KartuStatistik(
                      judul: 'Penyelesaian',
                      jumlah: '${persentase.toStringAsFixed(1)}%',
                      warna: Colors.teal,
                      ikon: Icons.trending_up,
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                const Text(
                  'Grafik Status Pengajuan',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Perbandingan pengajuan yang menunggu dan selesai.',
                ),
                const SizedBox(height: 20),

                // Grafik status
                SizedBox(
                  height: 260,
                  child: BarChart(
                    BarChartData(
                      minY: 0,
                      maxY: (total > 0 ? total : 1).toDouble() * 1.2,
                      alignment: BarChartAlignment.spaceAround,
                      gridData: const FlGridData(show: true),
                      borderData: FlBorderData(show: false),
                      barTouchData: BarTouchData(enabled: true),
                      titlesData: FlTitlesData(
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 38,
                            interval: _intervalGrafik(total),
                            getTitlesWidget: (value, meta) {
                              return Text(
                                value.toInt().toString(),
                                style: const TextStyle(fontSize: 11),
                              );
                            },
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 42,
                            getTitlesWidget: (value, meta) {
                              String label;

                              switch (value.toInt()) {
                                case 0:
                                  label = 'Menunggu';
                                  break;
                                case 1:
                                  label = 'Selesai';
                                  break;
                                default:
                                  return const SizedBox.shrink();
                              }

                              return Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  label,
                                  style: const TextStyle(fontSize: 11),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      barGroups: [
                        _buatBatang(
                          0,
                          menunggu,
                          Colors.orange,
                        ),
                        _buatBatang(
                          1,
                          selesai,
                          Colors.green,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Persentase penyelesaian
                const Text(
                  'Progres Penyelesaian',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: persentase / 100,
                    minHeight: 12,
                    backgroundColor: Colors.grey.shade200,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '$selesai dari $total pengajuan telah selesai '
                  '(${persentase.toStringAsFixed(1)}%).',
                ),

                const SizedBox(height: 28),

                const Text(
                  'Jumlah Pengajuan per Layanan',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),

                if (daftarPengajuan.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Icon(
                            Icons.insert_chart_outlined,
                            size: 48,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 12),
                          Text(
                            'Belum ada pengajuan layanan.',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  ..._buatRingkasanLayanan(daftarPengajuan),

                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }

  static double _intervalGrafik(int total) {
    if (total <= 0) return 1;
    return (total * 1.2 / 4).clamp(1.0, double.infinity);
  }

  static BarChartGroupData _buatBatang(
    int x,
    int jumlah,
    Color warna,
  ) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: jumlah.toDouble(),
          color: warna,
          width: 36,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(5),
          ),
        ),
      ],
    );
  }

  static List<Widget> _buatRingkasanLayanan(
    List<Pengajuan> daftarPengajuan,
  ) {
    final Map<String, int> jumlahLayanan = {};

    for (final pengajuan in daftarPengajuan) {
      jumlahLayanan.update(
        pengajuan.layanan,
        (jumlah) => jumlah + 1,
        ifAbsent: () => 1,
      );
    }

    final layananTerurut = jumlahLayanan.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return layananTerurut.map((item) {
      return Card(
        margin: const EdgeInsets.only(bottom: 10),
        child: ListTile(
          leading: const CircleAvatar(
            backgroundColor: Color(0xFFE0F2F1),
            child: Icon(
              Icons.miscellaneous_services,
              color: Colors.teal,
            ),
          ),
          title: Text(item.key),
          subtitle: Text('${item.value} pengajuan'),
          trailing: Text(
            '${(item.value / daftarPengajuan.length * 100).toStringAsFixed(1)}%',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
        ),
      );
    }).toList();
  }
}

class _KartuStatistik extends StatelessWidget {
  final String judul;
  final String jumlah;
  final Color warna;
  final IconData ikon;

  const _KartuStatistik({
    required this.judul,
    required this.jumlah,
    required this.warna,
    required this.ikon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(
              ikon,
              color: warna,
              size: 28,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    judul,
                    style: const TextStyle(fontSize: 11),
                  ),
                  const SizedBox(height: 5),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      jumlah,
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: warna,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
