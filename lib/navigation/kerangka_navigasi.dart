
import 'package:flutter/material.dart';
import 'app_routes.dart';

class KerangkaNavigasi extends StatelessWidget {
  const KerangkaNavigasi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nusantara Cerdas Mobile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
        ),
      ),
      initialRoute: AppRoutes.warga,
      routes: AppRoutes.routes,
    );
  }
}
