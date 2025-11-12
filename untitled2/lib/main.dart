import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Importăm GetX
import 'home_screen.dart';
import 'controllers/data_controller.dart'; // Importăm Controller-ul nostru

void main() {
  // 1. OBLIGATORIU: Asigură-te că Flutter este inițializat complet
  // înainte de a apela funcții asincrone (cum ar fi citirea assets-urilor).
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Initializarea Controller-ului (folosind Get.put)
  // Acesta este injectat în memorie și va începe automat să încarce datele (din onInit).
  Get.put(DataController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 3. Schimbăm MaterialApp cu GetMaterialApp
    return GetMaterialApp(
      title: 'Doctor App UI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}