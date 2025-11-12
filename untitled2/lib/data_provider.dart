import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async'; // NOU: Adaugă acest import pentru Future.delayed

// Aceasta este funcția ASINCRONĂ.
Future<Map<String, dynamic>> loadJsonData() async {
  try {
    // NOU: Introducem o întârziere artificială de 3 secunde
    await Future.delayed(const Duration(seconds: 3));

    // 1. Așteptăm citirea conținutului fișierului JSON ca string (proces asincron)
    final String jsonString = await rootBundle.loadString('assets/data.json');

    // 2. Decodificăm string-ul JSON într-un Map Dart (proces sincron)
    final Map<String, dynamic> data = json.decode(jsonString);
    //sistem formal de Fluxuri
    //stochează datele și starea aplicației în variabile reactive
    return data;
  } catch (e) {
    // În caz de eroare la citire/decodare, afișăm și aruncăm eroarea mai departe
    print("Eroare la incarcarea datelor JSON: $e");
    rethrow;
  }
}