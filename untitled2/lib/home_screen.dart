import 'package:flutter/material.dart';
import 'package:untitled2/doctor_details_screen.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileSection(),
              _buildSearchBar(),
              const SizedBox(height: 20),
              _buildMainButtons(),
              const SizedBox(height: 20),
              _buildSpecialtiesSection(context),
              const SizedBox(height: 20),
              _buildSpecialistsSection(),
            ],
          ),
        ),
      ),
    );
  }
//Construim profilul
  Widget _buildProfileSection() {
    return Container(
      // Folosim 'decoration' în loc de 'color' pentru a putea adăuga umbră
      decoration: BoxDecoration(
        color: Colors.white, // Fundal alb
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15), // Culoarea umbrei (discretă)
            spreadRadius: 1, // Extinderea umbrei
            blurRadius: 5,   // Intensitatea estompării
            offset: const Offset(0, 4), // Poziția umbrei (doar în jos)
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage('assets/psycho/cont.jpg'),
            ),
            const SizedBox(width: 10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tanvir Ahassan',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontFamily: 'Lexend',
                    fontSize: 14,
                  ),
                ),
                Text(
                  'Mirpur, Dhaka',
                  style: TextStyle(
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
//Search Bar
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                // PASUL 1: Setează fundalul la alb
                color: Colors.white,

                // PASUL 2: Adaugă marginea (border) subțire, gri
                border: Border.all(
                  color: const Color(0xffd9d9d9), // O nuanță mai deschisă de gri pentru margine
                  width: 1.0, // Grosimea liniei
                ),

                borderRadius: BorderRadius.circular(10),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                  icon: ImageIcon(
                    const AssetImage('assets/psycho/img.png'), // Calea către imaginea ta
                    size: 18, // Setează mărimea, de obicei 24
                    color: const Color(0xFFBDBDBD), // Culoarea pe care o dorești (va colora PNG-ul dacă este monocrom)
                  ), // Culoarea iconiței de căutare


                  // NOU: Aplică stilul specific pentru hintText
                  hintStyle: TextStyle(
                    fontFamily: 'Lexend', // Fontul
                    fontWeight: FontWeight.w300, // Greutate: Light (300)
                    fontSize: 14, // Mărime
                    color: Color(0xFFBDBDBD), // Culoare: Gray 4 (#BDBDBD)
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
              color: Color(0xfffffff),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0xffd9d9d9), // O nuanță mai deschisă de gri pentru margine
                width: 1.0, // Grosimea liniei
              ),
            ),
            child: IconButton(
              onPressed: () {},
              icon: ImageIcon(
                const AssetImage('assets/psycho/img_1.png'), // Calea către imaginea ta
                size: 24, // Setează mărimea, de obicei 24
                color: const Color(0xFFBDBDBD), // Culoarea pe care o dorești (va colora PNG-ul dacă este monocrom)
              ),
            ),
          ),
        ],
      ),
    );
  }
//Butoanele principale
  Widget _buildMainButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMainButton(
                'Book Appointment',
                'assets/psycho/book.png', // Calea către imaginea locală
              ),
              _buildMainButton(
                'Instant Video Consult',
                'assets/psycho/video.png', // Calea către imaginea locală
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMainButton(
                'Medicines',
                'assets/psycho/med.png', // Calea către imaginea locală
              ),
              _buildMainButton(
                'Lab Tests',
                'assets/psycho/lab.png', // Calea către imaginea locală
              ),
              _buildMainButton(
                'Emergency',
                'assets/psycho/emergency.png', // Calea către imaginea locală
              ),
            ],
          ),
        ],
      ),
    );
  }
//
  Widget _buildMainButton(String text, String imageUrl) {
    return Expanded(
      child: Padding(
        // Padding-ul din jurul cardului rămâne (4.0)
        padding: const EdgeInsets.all(4.0),
        child: Container(
          // Setări de stil preluate din Rectangle 18030
          decoration: BoxDecoration(
            // Fundalul cardului: #E1F8F8 (culoarea din design)
            color: const Color(0xFFE1F8F8),

            // Raza (Radius): 10px
            borderRadius: BorderRadius.circular(10),

            // Bordura: 1px, culoare #F1F1F1 (din design)
            border: Border.all(
              color: const Color(0xFFF1F1F1),
              width: 1.0,
            ),

            // Umbra eliminată, deoarece bordura și culorile nu o necesită.
          ),
          child: Column(
            // Textul și Imaginea sunt aliniate în Column
            children: [
              // Imaginea (Rectangle 18030)
              ClipRRect(
                // Rotunjim doar colțurile de sus, deoarece textul acoperă colțurile de jos
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: Image.asset( // Folosește Image.asset pentru imagini locale
                  imageUrl,
                  // Lățimea imaginii este width: 159px, dar o lăsăm 'double.infinity' pentru Expanded
                  width: double.infinity,
                  // Înălțimea imaginii este height: 127px
                  height: 127,
                  fit: BoxFit.cover,
                ),
              ),

              // Secțiunea Text (Rectangle 18033)
              Container(
                // Setează înălțimea textului: height: 31px
                height: 31,
                width: double.infinity,
                decoration: const BoxDecoration(
                  // Fundal alb pentru zona de text: #FFFFFF
                  color: Colors.white,
                  // Rotunjim doar colțurile de jos (Bottom-right 10px, Bottom-left 10px)
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Center( // Centrarea Textului pe verticală și orizontală
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      // Fontul specificat: Inter
                      fontFamily: 'Inter',
                      // Greutate: 400 (Regular)
                      fontWeight: FontWeight.w400,
                      // Mărime: 11px
                      fontSize: 11,
                      // Line Height: 12px (nu necesită setare dacă textul este centrat și înălțimea e fixă)
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
//Sectiunile pentru specialitati
  Widget _buildSpecialtiesSection(BuildContext context) {
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
            children: [
              // MODIFICARE 2: Acum 'context' este definit și poate fi pasat
              _buildSpecialtyItem(context, 'assets/psycho/eye.png', 'Eye Specialist'),
              _buildSpecialtyItem(context, 'assets/psycho/dentist.png', 'Dentist'),
              _buildSpecialtyItem(context, 'assets/psycho/cardio.png', 'Cardiologist'),
              _buildSpecialtyItem(context, 'assets/psycho/pulmono.png', 'Pulmonologist'),
              _buildSpecialtyItem(context, 'assets/psycho/psycho.png', 'Psychiatrist'),
            ],
          ),
        ),
      ],
    );
  }

  // Noul tip de argument: 'imagePath' este String acum
  // Modificăm funcția _buildSpecialtyItem din home_screen.dart
  Widget _buildSpecialtyItem(BuildContext context, String imagePath, String text) {
    // Folosim InkWell pentru a adăuga interactivitate și efect vizual
    return InkWell(
      onTap: () {
        // Navigăm la ecranul de detalii al doctorului
        Navigator.push(
          context, // Acum 'context' este disponibil
          MaterialPageRoute(
            // Eliminăm 'const' și folosim variabila 'text' pentru specialitatea corectă
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
                // ... (stilurile de culoare și bordură rămân la fel)
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
//creare sectiune pentru specialisti
  Widget _buildSpecialistsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Textul 'Specialists'
              const Text(
                'Specialists',
                style: TextStyle(
                  fontFamily: 'Lexend',
                  // Greutate: 600 (SemiBold)
                  fontWeight: FontWeight.w600,
                  // Mărime: 16px
                  fontSize: 16,
                  // Culoare: #171318 (Negru aproape pur)
                  color: Color(0xFF171318),
                ),
              ),

              // Textul 'View all >'
              TextButton(
                onPressed: () {},
                child: const Text(
                  'View all >',
                  style: TextStyle(
                    fontFamily: 'Lexend',
                    // Greutate: 400 (Regular)
                    fontWeight: FontWeight.w400,
                    // Mărime: 13px
                    fontSize: 13,
                    // Culoare: #357A7B (Primary Color)
                    color: Color(0xFF357A7B),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            // Ajustăm padding-ul orizontal pentru a se potrivi cu layout-ul
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: [
              // Vom folosi imagini locale (presupunând că le ai) sau le poți înlocui.
              _buildSpecialistCard('assets/psycho/dr_a.png', 'General Practioners'),
              // Adaugă padding orizontal de 16px între carduri
              const SizedBox(width: 16),
              _buildSpecialistCard('assets/psycho/dr_b.png', 'General Practioners'),
            ],
          ),
        ),
      ],
    );
  }
//crearea cardurilor pentru specialisti
  Widget _buildSpecialistCard(String imagePath, String specialty) {
    // Padul orizontal de 16px între carduri este gestionat în ListView (sau ar trebui)
    return Padding(
      padding: const EdgeInsets.only(right: 16.0), // Adăugăm padding la dreapta pentru a spația cardurile
      child: Container(
        width: 188, // Lățime: 188px
        height: 250, // Înălțime totală (opțional, deoarece Column o va calcula)
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16), // Raza: 16px
          border: Border.all( // Bordura: 1px, #E4E4E7
            color: const Color(0xFFE4E4E7),
            width: 1.0,
          ),
          // Eliminăm boxShadow-ul vechi
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                // Fundalul Imaginii (BG-Image)
                Container(
                  width: 188,
                  height: 140, // Înălțime: 140px
                  decoration: BoxDecoration(
                    color: const Color(0xFFE4E4E7), // Culoare: #E4E4E7
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16), // Raza Top-left: 16px
                      topRight: Radius.circular(16), // Raza Top-right: 16px
                    ),
                  ),
                ),

                // Imaginea Doctorului (o vom plasa deasupra BG-Image)
                // Presupunem că imaginea are un fundal transparent sau decupat
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: Image.asset(
                    imagePath,
                    height: 140, // Aceeași înălțime ca BG-Image
                    width: double.infinity,
                    fit: BoxFit.cover, // Poate fi 'fit: BoxFit.contain' dacă imaginea e decupată
                  ),
                ),

                // Butonul "Favorite" (Button-Love)
                Positioned(
                  top: 12, // Top: 12px
                  left: 12, // Right: 12px (188 - 12 - 32 = 144)
                  child: Container(
                    width: 32, // Lățime: 32px
                    height: 32, // Înălțime: 32px
                    padding: const EdgeInsets.all(8), // Padding: 8px (pentru a centra inima)
                    decoration: BoxDecoration(
                      color: Colors.white, // Fundal alb
                      shape: BoxShape.circle, // Raza: 32px (se face cerc)
                      border: Border.all( // Bordura: 1px, #E4E4E7
                        color: const Color(0xFFE4E4E7),
                        width: 1.0,
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.favorite_border,
                        color: Color(0xFF71717A), // Culoare inima (Greyscale / 200)
                        size: 14, // Mărime ajustată pentru a se încadra în padding-ul de 8px
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Textul Specialității ('General Practitioners')
            Padding(
              padding: const EdgeInsets.only(left: 12.0, top: 12.0, bottom: 8.0),
              child: Text(
                specialty,
                style: const TextStyle(
                  fontFamily: 'Plus Jakarta Sans', // Fontul din design
                  fontWeight: FontWeight.w400, // Greutate: 400 (Regular)
                  fontSize: 12, // Mărime: 12px
                  color: Color(0xFF71717A), // Culoare: Greyscale/500 (#71717A)
                ),
              ),
            ),
            // Aici s-ar adăuga alte etichete (Label, Label, Label) dacă ar fi necesar
          ],
        ),
      ),
    );
  }
}