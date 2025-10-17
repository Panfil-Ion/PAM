// doctor_details_screen.dart

import 'package:flutter/material.dart';

class DoctorDetailsScreen extends StatelessWidget {
  final String specialty;

  // Constructorul DoctorDetailsScreen rămâne la fel
  const DoctorDetailsScreen({super.key, required this.specialty});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context, specialty),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDoctorProfile(context),
            _buildTabNavigation(),
            _buildAppointmentSection(),
            _buildTimingSection(),
            _buildLocationSection(),
            const SizedBox(height: 40),
          ],
        ),
      ),
      // Adăugați aici butonul de 'Book Now' dacă este necesar (nu este vizibil complet în imaginea furnizată)
    );
  }

  // --- WIDGETS AUXILIARE ---

  // 1. AppBar Custom (Cardiologist)
  PreferredSize _buildAppBar(BuildContext context, String title) {
    // Definește înălțimea App Bar-ului (de obicei 56.0 + înălțimea status bar-ului)
    const double kToolbarHeight = 56.0;

    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Fundalul alb
          // Aici adăugăm Box Shadow-ul tău
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        // Construim AppBar-ul fără elevație (ca să nu adauge încă o umbră)
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0, // Eliminăm elevația implicită

          // Alinierea titlului la stânga
          centerTitle: false,

          // Săgeata de Back Personalizată
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const ImageIcon(
              AssetImage('assets/psycho/back_arrow.png'),
              size: 12,
              color: Colors.black,
            ),
          ),

          // Titlul
          title: Text(
            title, // E.g., "Cardiologist"
            style: const TextStyle(
              fontFamily: 'Lexend',
              fontWeight: FontWeight.w500,
              fontSize: 15,
              color: Color(0xFF374151),
            ),
          ),

          // Acțiunile (Iconițele)
          actions: [
            IconButton(
              onPressed: () {},
              icon: const ImageIcon(
                AssetImage('assets/psycho/star.png'),
                size: 18,
                color: Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const ImageIcon(
                AssetImage('assets/psycho/settings.png'),
                size: 18,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }


  Widget _buildVerticalDivider() {
    return Container(
      // Proprietățile preluate din imaginea de detalii (vectorul dintre statistici)
      width: 1,
      height: 32, // Înălțimea barei este de 32px
      color: const Color(0xFFC2C9D0).withOpacity(0.35), // Culoarea gri, 35% opacitate
    );
  }
  // 2. Secțiunea de Profil (Dr. Emma Kathrin)
  Widget _buildDoctorProfile(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatarul Doctorului
              const CircleAvatar(
                radius: 40,

                backgroundImage: AssetImage('assets/psycho/emma.jpg'),
              ),
              const SizedBox(width: 15),
              // Detalii Textuale
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Dr. Emma Kathrin',
                    style: TextStyle(
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    specialty, // E.g., Cardiologist
                    style: const TextStyle(
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Color(0xFF357A7B), // Primary Color
                    ),
                  ),
                  const Text(
                    'MBBS', // Titlul academic
                    style: TextStyle(
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                      color: Color(0xff8c8c8c),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Statistici (Rating, Years, Patients)
          Row(
            // Folosim MainAxisAlignment.spaceAround pentru a centra separatorul
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(Icons.star, '4.3', 'Rating & Review'),

              // ADĂUGĂ Separatorul 1
              _buildVerticalDivider(),

              _buildStatItem(Icons.work, '14', 'Years of work'),

              // ADĂUGĂ Separatorul 2
              _buildVerticalDivider(),

              _buildStatItem(Icons.people_alt, '125', 'No. of patients'),
            ],
          ),
        ],
      ),
    );
  }

  // Widget auxiliar pentru item-urile de statistică
  Widget _buildStatItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: Colors.amber), // Steaua este galbenă/chihlimbar
            const SizedBox(width: 4),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          ],
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  // 3. Secțiunea de Navigare (Info, History, Review)
  // doctor_details_screen.dart

  Widget _buildTabNavigation() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Container(
        // Proprietăți preluate din SegmentedPicker (imaginea ae4d8a.png)
        width: double.infinity, // Ocupă toată lățimea
        height: 32, // Înălțimea fixă
        padding: const EdgeInsets.all(2.0), // Padding interior de 2px
        decoration: BoxDecoration(
          // Culoare de fundal (Fill Color/Light/Tertiary - #767680 cu 12% opacitate)
          color: const Color(0xFF767680).withOpacity(0.12),
          borderRadius: BorderRadius.circular(8.91), // Raza
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Acestea sunt butoanele/Opțiunile
            _buildPillButton('Info', isSelected: true),
            _buildPillButton('History', isSelected: false),
            _buildPillButton('Review', isSelected: false),
          ],
        ),
      ),
    );
  }


// Widget auxiliar pentru butoanele-pill
  Widget _buildPillButton(String text, {required bool isSelected}) {
    return Expanded( // Folosim Expanded pentru a distribui spațiul egal
      child: Container(
        alignment: Alignment.center,
        height: double.infinity, // Ocupă înălțimea maximă a părintelui (32px)
        decoration: isSelected
            ? BoxDecoration(
          color: Colors.white, // Fundal alb când este selectat
          borderRadius: BorderRadius.circular(6.93), // Raza colțurilor (SegmentedPicker-option)
          // Adaugă umbra subtilă
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04), // 4% opacitate (din imaginea ae4dc7.png)
              offset: const Offset(0, 3), // Umbră doar în jos
              blurRadius: 1, // Blur de 1
              spreadRadius: 0, // Spread de 0
            ),
          ],
        )
            : null, // Fără fundal sau umbră când nu este selectat
        child: Text(
          text,
          style: TextStyle(
            // Culoarea textului este #000000 (Negru)
            color: Colors.black,
            // Greutate diferită în funcție de selecție
            fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
            fontSize: 14,
            fontFamily: 'Lexend',
          ),
        ),
      ),
    );
  }

  // 4. Secțiunea de Programări (In-Clinic Appointment)
  Widget _buildAppointmentSection() {
    // Culoarea din design: #E2F7F8
    const Color appointmentBgColor = Color(0xFFE2F7F8);
    return Padding(
      // Adăugăm padding-ul orizontal de 16px aici, pentru a imita Frame-ul exterior
      padding: const EdgeInsets.symmetric(horizontal: 16.0),

      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Containerul care aplică fundalul și rotunjirea de sus
        Container(
          width: double.infinity,
          // Proprietăți din Rectangle 18045 (imaginea b8645c.png)
          decoration: const BoxDecoration(
            color: appointmentBgColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), // Top-left 10px
              topRight: Radius.circular(10), // Top-right 10px
            ),
          ),

          child: Padding(
            // Padding-ul orizontal rămâne 16, dar cel vertical este ajustat pentru a se potrivi
            // Dimensiunea totală a containerului Rectangle 18045 este 48px înălțime.
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'In-Clinic Appointment',
                  style: TextStyle(
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    // Textul este Negru
                    color: Colors.black,
                  ),
                ),
                // Prețul
                const Text(
                  '৳1,000',
                  style: TextStyle(
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Color(0xFF357A7B), // Primary Color
                  ),
                ),
              ],
            ),
          ),
        ), // Sfârșitul Container-ului de Fundal

        // Deoarece secțiunea de mai sus nu mai are padding orizontal de 16px,
        // trebuie să ne asigurăm că secțiunea '_buildHospitalDetails' are padding-ul ei

        // Detalii Spital
        _buildHospitalDetails(),

        // Secțiunea de zile (Today, Tomorrow, 17 Oct)
        _buildDaySelection(),

        // Sloturi Orar
        _buildTimeSlots(),
      ],
    ),
    );
  }

  Widget _buildHospitalDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Evercare Hospital Ltd.',
            style: TextStyle(
              fontFamily: 'Lexend',
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Boshundhora, Dhaka\n20 mins or less wait time',
                style: TextStyle(
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  '2 More clinic',
                  style: TextStyle(
                    fontFamily: 'Lexend',
                    fontSize: 12,
                    color: Color(0xFF357A7B),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }



  Widget _buildDaySelection() {
    // În design, această secțiune pare să fie separată de o linie subțire.
    // Adăugăm o linie (Divider) și ne asigurăm că Padding-ul este corect.
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Folosim Spacer între elemente pentru a nu folosi MainAxisAlignment.spaceBetween
              // pentru a permite alinierile din stânga și dreapta.
              _buildDayPill('Today', '(No Slot)', isSelected: true),
              const Spacer(),
              _buildDayPill('Tomorrow', '(20 Slot)', isSelected: false),
              const Spacer(),
              _buildDayPill('17 Oct', '(10 Slot)', isSelected: false),
            ],
          ),
        ),

        // Linia subțire (Divider) sub zile, așa cum se vede în imaginea 9fca29.png
        const Divider(
          color: Colors.grey, // Culoare subțire
          height: 1,
          thickness: 0.5,
          indent: 16, // Începe la 16px de la stânga
          endIndent: 16, // Se termină la 16px de la dreapta
        ),
      ],
    );
  }

  Widget _buildDayPill(String day, String slot, {required bool isSelected}) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8.0),
      margin: const EdgeInsets.only(right: 15.0),
      decoration: isSelected
          ? const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFF357A7B), // Linia de selecție
            width: 2.0,
          ),
        ),
      )
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            day,
            style: TextStyle(
              fontFamily: 'Lexend',
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              fontSize: 14,
              color: isSelected ? const Color(0xFF357A7B) : Colors.black,
            ),
          ),
          Text(
            slot,
            style: TextStyle(
              fontFamily: 'Lexend',
              fontWeight: FontWeight.w400,
              fontSize: 10,
              color: isSelected ? const Color(0xFF357A7B) : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSlots() {
    return SizedBox(
      height: 70,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
        children: [
          _buildTimePill('06:00 - 06:30', isSelected: true),
          _buildTimePill('06:30 - 07:00', isSelected: true),
          _buildTimePill('07:00 - 07:30', isSelected: true),
          // ... alte sloturi
        ],
      ),
    );
  }

  Widget _buildTimePill(String time, {required bool isSelected}) {
    return Container(
      margin: const EdgeInsets.only(right: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFE2F7F8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        time,
        style: TextStyle(
          color: const Color(0xFF357A7B),
          fontFamily: 'Lexend',
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }


  // 5. Secțiunea de Timp (Timing)
  Widget _buildTimingSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Timing',
            style: TextStyle(
              fontFamily: 'Lexend',
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 80,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildTimeCard('Monday', '09:00 AM - 05:00 PM'),
                _buildTimeCard('Monday', '09:00 AM - 05:00 PM'), // Duplicat pentru a umple spațiul
                _buildTimeCard('Tuesday', '09:00 AM - 05:00 PM'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeCard(String day, String time) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE4E4E7), width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(day, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
          const SizedBox(height: 4),
          Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  // 6. Secțiunea de Locație (Location)
  Widget _buildLocationSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Location',
            style: TextStyle(
              fontFamily: 'Lexend',
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 70, // Ajustăm înălțimea
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildLocationCard('Shahbag', 'BSSMU - Bangaband...', isSelected: true),
                _buildLocationCard('Boshundhora', 'Evercare Hospital Ltd.', isSelected: false),
                _buildLocationCard('Badda', 'Apollo Hospital', isSelected: false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationCard(String location, String details, {required bool isSelected}) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFD6F2F2) : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isSelected ? const Color(0xFF357A7B) : const Color(0xFFE4E4E7),
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            location,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: isSelected ? const Color(0xFF357A7B) : Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            details,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}