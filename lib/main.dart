import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/pengajuan_model.dart';
import 'model/chat_model.dart';
import 'navigation/kerangka_navigasi.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PengajuanModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ChatModel(),
        ),
      ],
      child: const KerangkaNavigasi(),
    ),
  );
}