import 'package:flutter/material.dart';
import 'package:hola_mundo/routes/app_router.dart';

import 'themes/app_theme.dart'; // Importa el tema

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.lightTheme,
      title: 'Flutter - UCEVA', // Usa el tema personalizado
      routerConfig: appRouter, // Usa el router configurado
    );
  }
}
