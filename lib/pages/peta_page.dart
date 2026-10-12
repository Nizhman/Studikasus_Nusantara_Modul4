
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PetaPage extends StatefulWidget {
  const PetaPage({super.key});

  @override
  State<PetaPage> createState() => _PetaPageState();
}

class _PetaPageState extends State<PetaPage> {
  GoogleMapController? _mapController;

  static const LatLng _posisiAwal = LatLng(-6.9175, 107.6191);

  final List<Map<String, dynamic>> _kantorLayanan = [
    {
      'id': 'kantor_1',
      'nama': 'Kantor Layanan 1',
      'alamat': 'Lokasi contoh 1, Bandung',
      'posisi': const LatLng(-6.9175, 107.6191),
    },
    {
      'id': 'kantor_2',
      'nama': 'Kantor Layanan 2',
      'alamat': 'Lokasi contoh 2, Bandung',
      'posisi': const LatLng(-6.9147, 107.6098),
    },
    {
      'id': 'kantor_3',
      'nama': 'Kantor Layanan 3',
      'alamat': 'Lokasi contoh 3, Bandung',
      'posisi': const LatLng(-6.9250, 107.6340),
    },
  ];

  Set<Marker> get _markers {
    return _kantorLayanan.map((kantor) {
      return Marker(
        markerId: MarkerId(kantor['id'] as String),
        position: kantor['posisi'] as LatLng,
        infoWindow: InfoWindow(
          title: kantor['nama'] as String,
          snippet: kantor['alamat'] as String,
        ),
      );
    }).toSet();
  }

  void _pilihKantor(Map<String, dynamic> kantor) {
    final posisi = kantor['posisi'] as LatLng;

    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: posisi,
          zoom: 16,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peta Kantor Layanan'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: _posisiAwal,
                zoom: 13,
              ),
              markers: _markers,
              mapType: MapType.normal,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: true,
              onMapCreated: (controller) {
                _mapController = controller;
              },
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
            color: Colors.teal.shade50,
            child: const Text(
              'Daftar Kantor Layanan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _kantorLayanan.length,
              itemBuilder: (context, index) {
                final kantor = _kantorLayanan[index];

                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.teal,
                      child: Icon(
                        Icons.location_city,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(kantor['nama'] as String),
                    subtitle: Text(kantor['alamat'] as String),
                    trailing: const Icon(
                      Icons.my_location,
                      color: Colors.teal,
                    ),
                    onTap: () => _pilihKantor(kantor),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
