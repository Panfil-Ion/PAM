import 'package:flutter/material.dart';
import 'package:get/get.dart'; // NOU: Import GetX
import 'controllers/data_controller.dart'; // NOU: Import Controller

// Accesăm controller-ul global
final DataController controller = Get.find();

class DoctorDetailsScreen extends StatelessWidget {
  // Păstrăm specialitatea doar pentru contextul de navigare (titlu)
  final String specialty;

  const DoctorDetailsScreen({super.key, required this.specialty});

  @override
  Widget build(BuildContext context) {
    // Folosim Obx pentru a reacționa dacă datele din controller s-ar schimba
    return Obx(() {

      // Verificare stare (Loading/Error)
      if (controller.dataStatus.value.isLoading) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }
      if (controller.dataStatus.value.isError) {
        return Scaffold(body: Center(child: Text('Eroare la incarcarea detaliilor doctorului.')));
      }

      // EXTRAGEREA DATELOR DIN CONTROLLER
      final doctorDetails = controller.doctorDetails;
      final doctorData = doctorDetails['doctor'] ?? {};
      final appointmentData = doctorDetails['appointment'] ?? {};
      final List<dynamic> timingList = doctorDetails['timing'] ?? [];
      final List<dynamic> locationsList = doctorDetails['locations'] ?? [];

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(context, doctorData['speciality'] ?? specialty),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDoctorProfile(context, doctorData), // Folosește datele dinamice
              _buildTabNavigation(doctorDetails['tabs'] ?? []), // Folosește tab-urile dinamice
              _buildAppointmentSection(appointmentData), // Folosește datele de programare
              _buildTimingSection(timingList), // Folosește orarul dinamic
              _buildLocationSection(locationsList), // Folosește locațiile dinamice
              const SizedBox(height: 40),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomBar(),
      );
    });
  }

  // ----------------------------------------------------------------------------------
  // WIDGETS AUXILIARE MODIFICATE PENTRU A FOLOSI DATE DINAMICE
  // ----------------------------------------------------------------------------------

  PreferredSize _buildAppBar(BuildContext context, String title) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(56.0),
      child: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const ImageIcon(AssetImage('assets/psycho/back_arrow.png')),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          title, // Titlul dinamic (specialitatea)
          style: const TextStyle(
            fontFamily: 'Lexend',
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Color(0xFF171318),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_border, color: Color(0xFFBDBDBD)),
          ),
        ],
      ),
    );
  }

  // Modificat: _buildDoctorProfile primește datele doctorului
  Widget _buildDoctorProfile(BuildContext context, Map<String, dynamic> doctorData) {
    // Extragerea valorilor și gestionarea valorilor nule (fallback)
    final String name = doctorData['name'] ?? 'N/A';
    final String speciality = doctorData['speciality'] ?? 'N/A';
    final String qualification = doctorData['qualification'] ?? 'N/A';
    final String profileImage = doctorData['profile_image'] ?? 'assets/default.jpg';
    final double rating = (doctorData['rating'] as num?)?.toDouble() ?? 0.0;
    final int reviewsCount = doctorData['reviews_count'] ?? 0;
    final int yearsOfExperience = doctorData['years_of_experience'] ?? 0;
    final int patientsTreated = doctorData['patients_treated'] ?? 0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatarul Doctorului
              CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage(profileImage),
              ),
              const SizedBox(width: 15),
              // Detalii Textuale
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Color(0xFF171318),
                    ),
                  ),
                  Text(
                    speciality,
                    style: const TextStyle(
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Color(0xFF71717A),
                    ),
                  ),
                  Text(
                    qualification,
                    style: const TextStyle(
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Color(0xFF71717A),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Statistici
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(Icons.star, rating.toStringAsFixed(1), 'Rating ($reviewsCount Review)'),
              _buildVerticalDivider(),
              _buildStatItem(Icons.work, yearsOfExperience.toString(), 'Years of work'),
              _buildVerticalDivider(),
              _buildStatItem(Icons.people_alt, patientsTreated.toString(), 'No. of patients'),
            ],
          ),
        ],
      ),
    );
  }

  // Modificat: _buildTabNavigation primește lista de tab-uri
  Widget _buildTabNavigation(List<dynamic> tabs) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: tabs.asMap().entries.map((entry) {
          final index = entry.key;
          final String tabText = entry.value;
          // Selectăm primul tab ("Info") ca implicit
          final bool isSelected = index == 0;
          return _buildPillButton(tabText, isSelected: isSelected);
        }).toList(),
      ),
    );
  }

  // Modificat: _buildAppointmentSection primește datele de programare
  Widget _buildAppointmentSection(Map<String, dynamic> appointmentData) {
    final hospitalData = appointmentData['hospital'] ?? {};
    final List<dynamic> availableDays = appointmentData['available_days'] ?? [];

    // Extragem sloturile din prima zi cu sloturi disponibile (sau un Map gol)
    final List<dynamic> timeSlots = availableDays.firstWhere(
            (day) => (day['slots'] as List).isNotEmpty,
        orElse: () => {'slots': []}
    )['slots'] ?? [];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Containerul de Preț
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
            decoration: BoxDecoration(
              color: const Color(0xFFE1F8F8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  appointmentData['type'] ?? 'Tip programare',
                  style: const TextStyle(
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color(0xFF171318),
                  ),
                ),
                Text(
                  '${appointmentData['currency'] ?? '৳'}${appointmentData['fee'] ?? 'N/A'}',
                  style: const TextStyle(
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Color(0xFF357A7B),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          // Detalii Spital
          _buildHospitalDetails(hospitalData),
          const SizedBox(height: 15),
          // Secțiunea de zile
          _buildDaySelection(availableDays),
          // Sloturi Orar
          _buildTimeSlots(timeSlots),
        ],
      ),
    );
  }

  // Modificat: Functie ajutatoare pentru detalii spital
  Widget _buildHospitalDetails(Map<String, dynamic> hospitalData) {
    final List<dynamic> moreClinics = hospitalData['more_clinics'] ?? [];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hospitalData['name'] ?? 'Nume Spital',
            style: const TextStyle(
              fontFamily: 'Lexend',
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Color(0xFF171318),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${hospitalData['location'] ?? 'Locație N/A'}\n${hospitalData['wait_time'] ?? 'Timp N/A'}',
                style: const TextStyle(
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  color: Color(0xFF71717A),
                ),
              ),
              if (moreClinics.isNotEmpty)
                TextButton(
                  onPressed: () {},
                  child: Text(
                    '${moreClinics.length} More clinic',
                    style: const TextStyle(
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
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

  // Modificat: _buildDaySelection primeste lista de zile
  Widget _buildDaySelection(List<dynamic> availableDays) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: availableDays.asMap().entries.map((entry) {
              final index = entry.key;
              final dayData = entry.value;
              final String day = dayData['day'];
              final int slotCount = (dayData['slots'] as List).length;
              final String slotText = slotCount > 0 ? '($slotCount Slot)' : '(No Slot)';
              final bool isSelected = index == 1; // Selectam "Tomorrow" by default

              return Expanded(
                child: _buildDayPill(day, slotText, isSelected: isSelected),
              );
            }).toList(),
          ),
        ),
        const Divider(color: Color(0xFFE4E4E7), height: 1, thickness: 1),
      ],
    );
  }

  // Modificat: _buildTimeSlots primeste lista de sloturi
  Widget _buildTimeSlots(List<dynamic> timeSlots) {
    if (timeSlots.isEmpty) return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
      child: Text('No time slots available for selected day.', style: TextStyle(color: Colors.red)),
    );

    return SizedBox(
      height: 70,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
        children: timeSlots.asMap().entries.map<Widget>((entry) {
          final isSelected = entry.key == 0; // Selectăm primul slot by default
          return _buildTimePill(entry.value, isSelected: isSelected);
        }).toList(),
      ),
    );
  }

  // Modificat: _buildTimingSection primeste lista de orare
  Widget _buildTimingSection(List<dynamic> timingList) {
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
              color: Color(0xFF171318),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 80,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: timingList.map<Widget>((item) =>
                  _buildTimeCard(item['day'], item['time'])
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // Modificat: _buildLocationSection primeste lista de locatii
  Widget _buildLocationSection(List<dynamic> locationsList) {
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
              color: Color(0xFF171318),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 70,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: locationsList.asMap().entries.map((entry) {
                final index = entry.key;
                final location = entry.value;
                final bool isSelected = index == 0; // Selectam prima locatie by default
                return _buildLocationCard(
                    location['area'],
                    location['hospital'],
                    isSelected: isSelected
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------------------------------------
  // WIDGETS AUXILIARE (RĂMÂN NESCHIMBATE, doar pentru structură)
  // ----------------------------------------------------------------------------------

  Widget _buildVerticalDivider() {
    return Container(
      width: 1,
      height: 35,
      color: const Color(0xFFE4E4E7),
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16, color: const Color(0xFF357A7B)),
            const SizedBox(width: 5),
            Text(
              value,
              style: const TextStyle(
                fontFamily: 'Lexend',
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Color(0xFF171318),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Lexend',
            fontWeight: FontWeight.w400,
            fontSize: 11,
            color: Color(0xFF71717A),
          ),
        ),
      ],
    );
  }

  Widget _buildPillButton(String text, {required bool isSelected}) {
    final Color backgroundColor = isSelected ? const Color(0xFF357A7B) : Colors.white;
    final Color textColor = isSelected ? Colors.white : const Color(0xFF71717A);
    final Border border = isSelected ? Border.all(color: const Color(0xFF357A7B), width: 1) : Border.all(color: const Color(0xFFE4E4E7), width: 1);

    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
          border: border,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'Lexend',
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDayPill(String day, String slot, {required bool isSelected}) {
    final Color backgroundColor = isSelected ? const Color(0xFF357A7B) : Colors.white;
    final Color dayColor = isSelected ? Colors.white : const Color(0xFF171318);
    final Color slotColor = isSelected ? Colors.white.withOpacity(0.7) : const Color(0xFF71717A);
    final Border border = isSelected ? Border.all(color: const Color(0xFF357A7B), width: 1) : Border.all(color: const Color(0xFFE4E4E7), width: 1);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: border,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            day,
            style: TextStyle(
              fontFamily: 'Lexend',
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: dayColor,
            ),
          ),
          Text(
            slot,
            style: TextStyle(
              fontFamily: 'Lexend',
              fontWeight: FontWeight.w400,
              fontSize: 10,
              color: slotColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimePill(String time, {required bool isSelected}) {
    final Color backgroundColor = isSelected ? const Color(0xFFE1F8F8) : Colors.white;
    final Color textColor = isSelected ? const Color(0xFF357A7B) : const Color(0xFF71717A);
    final Border border = isSelected ? Border.all(color: const Color(0xFF357A7B), width: 1) : Border.all(color: const Color(0xFFE4E4E7), width: 1);

    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: border,
      ),
      child: Center(
        child: Text(
          time,
          style: TextStyle(
            fontFamily: 'Lexend',
            fontWeight: FontWeight.w500,
            fontSize: 13,
            color: textColor,
          ),
        ),
      ),
    );
  }

  Widget _buildTimeCard(String day, String time) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE4E4E7), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            day,
            style: const TextStyle(
              fontFamily: 'Lexend',
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Color(0xFF171318),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            time,
            style: const TextStyle(
              fontFamily: 'Lexend',
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: Color(0xFF71717A),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationCard(String location, String details, {required bool isSelected}) {
    final Color backgroundColor = isSelected ? const Color(0xFFE1F8F8) : Colors.white;
    final Color borderColor = isSelected ? const Color(0xFF357A7B) : const Color(0xFFE4E4E7);

    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            location,
            style: TextStyle(
              fontFamily: 'Lexend',
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: isSelected ? const Color(0xFF357A7B) : const Color(0xFF171318),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            details,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(
              fontFamily: 'Lexend',
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: Color(0xFF71717A),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF357A7B),
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          'Book Now',
          style: TextStyle(
            fontFamily: 'Lexend',
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}