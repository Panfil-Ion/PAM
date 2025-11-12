import 'package:get/get.dart';
import '../data_provider.dart'; // Importăm funcția de citire asincronă a datelor

class DataController extends GetxController {

  // 1. Variabilă Reactivă (Rx) pentru a stoca toate datele incarcate din JSON.
  // Folosim un Map gol ca valoare inițială.
  final allData = Rx<Map<String, dynamic>>({});

  // 2. Variabilă Reactivă pentru a urmari statusul incarcarii (Loading, Success, Error).
  // Statusul inițial este 'loading'.
  final dataStatus = Rx<RxStatus>(RxStatus.loading());
  @override
  void onInit() {
    super.onInit();
    // Aici inițiem procesul asincron de încărcare a datelor.
    fetchData();
  }

  void fetchData() async {
    dataStatus.value = RxStatus.loading(); // Setează starea la ÎNCARCARE
    try {
      // 3. Așteptăm rezultatul funcției ASINCRONE de citire a datelor
      final loadedData = await loadJsonData();

      allData.value = loadedData; // Actualizează datele în variabila reactivă
      dataStatus.value = RxStatus.success(); // Setează starea la SUCCES

    } catch (e) {
      // Dacă a apărut o eroare (de ex. fișierul nu a fost găsit), setează starea la EROARE
      dataStatus.value = RxStatus.error(e.toString());
      print("Eroare la incarcarea datelor: $e");
    }
  }

  // 4. Funcții ajutatoare (Getters) pentru a accesa usor sectiunile din UI
  Map<String, dynamic> get medicineFeed => allData.value['medicineFeed'] ?? {};
  Map<String, dynamic> get doctorDetails => allData.value['doctorDetails'] ?? {};

  List<dynamic> get specialities => medicineFeed['specialities'] ?? [];
  List<dynamic> get specialists => medicineFeed['specialists'] ?? [];
}