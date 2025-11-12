import 'package:flutter/material.dart';
import 'package:get/get.dart'; // NOU: Import GetX
import 'package:untitled2/doctor_details_screen.dart';
import 'controllers/data_controller.dart'; // NOU: Import Controller

// Accesăm controller-ul global o singură dată
final DataController controller = Get.find();

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Folosim Obx pentru a OBSERVA (Obx = Observer) schimbarile de stare din controller
    return Obx(() {

      // 1. GESTIONAREA STĂRII (Loading, Error)
      if (controller.dataStatus.value.isLoading) {
        // Afișează indicator de încărcare cât timp datele se citesc asincron
        return const Scaffold(
            body: Center(child: CircularProgressIndicator()));
      }
      if (controller.dataStatus.value.isError) {
        // Afișează mesaj de eroare dacă citirea a eșuat
        return Scaffold(
            body: Center(
                child: Text(
                  'Eroare la incarcarea datelor: ${controller.dataStatus.value.errorMessage}',
                  textAlign: TextAlign.center,
                )
            )
        );
      }

      // 2. EXTRAGEREA DATELOR DUPĂ ÎNCĂRCAREA CU SUCCES
      final userData = controller.medicineFeed['user'] ?? {};
      final List<dynamic> actions = controller.medicineFeed['actions'] ?? [];
      final List<dynamic> specialities = controller.specialities;
      final List<dynamic> specialists = controller.specialists;

      // 3. AFIȘEAZĂ UI-UL PROPRIU-ZIS cu date dinamice
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Pasăm datele extrase
                _buildProfileSection(userData),
                _buildSearchBar(),
                const SizedBox(height: 20),
                _buildMainButtons(actions), // Pasăm acțiunile
                const SizedBox(height: 20),
                _buildSpecialtiesSection(context, specialities), // Pasăm specialitățile
                const SizedBox(height: 20),
                _buildSpecialistsSection(specialists), // Pasăm specialiștii
              ],
            ),
          ),
        ),
      );
    });
  }

//---------------------------------------------------------
// FUNCȚII AUXILIARE MODIFICATE PENTRU A FOLOSI DATE DIN CONTROLLER
//---------------------------------------------------------

// Construim profilul - primește datele de utilizator
  Widget _buildProfileSection(Map<String, dynamic> userData) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Row(
          children: [
            // UTILIZĂM DATA: Calea imaginii din JSON
            CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage(userData['profile_image'] ?? 'assets/default.jpg'),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // UTILIZĂM DATA: Numele din JSON
                Text(
                  userData['name'] ?? 'Utilizator',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontFamily: 'Lexend',
                    fontSize: 14,
                  ),
                ),
                // UTILIZĂM DATA: Locația din JSON
                Text(
                  userData['location'] ?? 'Locație',
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                    fontFamily: 'Lexend',
                    fontSize: 11,
                  ),
                ),
              ],
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none),
            ),
          ],
        ),
      ),
    );
  }

// Search Bar (Rămâne neschimbat, nu folosește date dinamice)
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: const Color(0xffd9d9d9),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                  icon: ImageIcon(
                    AssetImage('assets/psycho/img.png'),
                    size: 18,
                    color: Color(0xFFBDBDBD),
                  ),
                  hintStyle: TextStyle(
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                    color: Color(0xFFBDBDBD),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: const Color(0xffffffff), // Corectat: Color(0xfffffff) -> const Color(0xffffffff)
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0xffd9d9d9),
                width: 1.0,
              ),
            ),
            child: IconButton(
              onPressed: () {},
              icon: const ImageIcon(
                AssetImage('assets/psycho/img_1.png'),
                size: 24,
                color: Color(0xFFBDBDBD),
              ),
            ),
          ),
        ],
      ),
    );
  }

// Butoanele principale - primește lista de acțiuni
  Widget _buildMainButtons(List<dynamic> actions) {
    if (actions.isEmpty) return const SizedBox.shrink();

    // Presupunem că există cel puțin 5 acțiuni conform JSON-ului
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          // Rândul 1 (primele 2 acțiuni)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMainButton(
                actions[0]['title'],
                actions[0]['image'],
              ),
              _buildMainButton(
                actions[1]['title'],
                actions[1]['image'],
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Rândul 2 (acțiunile rămase)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: actions
                .skip(2) // Sarim peste primele 2
                .map<Widget>((action) => _buildMainButton(
                action['title'], action['image']))
                .toList(),
          ),
        ],
      ),
    );
  }

// Funcție auxiliară pentru buton (Rămâne la fel)
  Widget _buildMainButton(String text, String imageUrl) {
    // ... (Codul rămâne același, folosește text și imageUrl primite)
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFE1F8F8),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color(0xFFF1F1F1),
              width: 1.0,
            ),
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: Image.asset(
                  imageUrl,
                  width: double.infinity,
                  height: 127,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                height: 31,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Center(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 11,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// Sectiunile pentru specialitati - primește lista de specialități
  Widget _buildSpecialtiesSection(BuildContext context, List<dynamic> specialities) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Specialities most relevant to you',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 100,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            // GENERĂM LISTA DE ELEMENTE DINAMIC
            children: specialities
                .map<Widget>((s) => _buildSpecialtyItem(
                context,
                s['icon'], // Icon din JSON
                s['name'] // Nume din JSON
            ))
                .toList(),
          ),
        ),
      ],
    );
  }

// Element specialitate (Rămâne la fel, folosește datele primite)
  Widget _buildSpecialtyItem(BuildContext context, String imagePath, String text) {
    return InkWell(
      onTap: () {
        // Navigăm la ecranul de detalii al doctorului
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DoctorDetailsScreen(specialty: text),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Container(
              height: 54,
              width: 54,
              decoration: BoxDecoration(
                color: const Color(0xFFD6F2F2),
                borderRadius: BorderRadius.circular(27),
              ),
              child: Center(
                child: ImageIcon(
                  AssetImage(imagePath),
                  size: 23,
                  color: const Color(0xFF357A7B),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              text,
              style: const TextStyle(
                fontFamily: 'Lexend',
                fontWeight: FontWeight.w500,
                fontSize: 11,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

// creare sectiune pentru specialisti - primește lista de specialiști
  Widget _buildSpecialistsSection(List<dynamic> specialists) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Specialists',
                style: TextStyle(
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Color(0xFF171318),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'View all >',
                  style: TextStyle(
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    color: Color(0xFF357A7B),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 220,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            // GENERĂM LISTA DE CARDURI DINAMIC
            children: specialists
                .map<Widget>((s) => _buildSpecialistCard(s)) // Pasăm Map-ul doctorului
                .toList(),
          ),
        ),
      ],
    );
  }

// crearea cardurilor pentru specialisti - primește Map-ul specialistului
  Widget _buildSpecialistCard(Map<String, dynamic> specialistData) {
    final String imagePath = specialistData['image'] ?? 'assets/default.jpg';
    final String specialty = specialistData['speciality'] ?? 'Specialitate necunoscută';
    final String name = specialistData['name'] ?? 'Nume necunoscut';
    final double rating = specialistData['rating'] ?? 0.0;

    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Container(
        width: 188,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFE4E4E7),
            width: 1.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                // Fundalul Imaginii
                Container(
                  width: 188,
                  height: 140,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE4E4E7),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                ),
                // Imaginea Doctorului (folosește calea din JSON)
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: Image.asset(
                    imagePath,
                    height: 140,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                // Butonul "Favorite" (Rămâne la fel)
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    width: 32,
                    height: 32,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFE4E4E7),
                        width: 1.0,
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.favorite_border,
                        color: Color(0xFF71717A),
                        size: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Textul Specialității
            Padding(
              padding: const EdgeInsets.only(left: 12.0, top: 12.0, bottom: 2.0),
              child: Text(
                specialty,
                style: const TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Color(0xFF71717A),
                ),
              ),
            ),
            // Numele Doctorului
            Padding(
              padding: const EdgeInsets.only(left: 12.0, bottom: 4.0),
              child: Text(
                name,
                style: const TextStyle(
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Color(0xFF171318),
                ),
              ),
            ),
            // Rating-ul
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 14),
                  const SizedBox(width: 4),
                  Text(
                    rating.toStringAsFixed(1),
                    style: const TextStyle(fontSize: 12, color: Color(0xFF71717A)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}