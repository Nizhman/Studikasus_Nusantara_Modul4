
import 'package:flutter/material.dart';

import '../pages/warga_page.dart';
import '../pages/rincian_layanan_page.dart';
import '../pages/chat_page.dart';
import '../pages/peta_page.dart';
import '../pages/statistik_page.dart';

class AppRoutes {
  static const String warga = '/';
  static const String rincianLayanan = '/rincian-layanan';
  static const String chat = '/chat';
  static const String peta = '/peta';
  static const String statistik = '/statistik';

  static final Map<String, WidgetBuilder> routes = {
    warga: (context) => const WargaPage(),
    rincianLayanan: (context) => const RincianLayananPage(),
    chat: (context) => const ChatPage(),
    peta: (context) => const PetaPage(),
    statistik: (context) => const StatistikPage(),
  };
}
