import 'package:flutter/material.dart';
import '../app_theme.dart';
import '../models/doctor.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Hard-coded list for the lab. A real app would load this from an API.
  static const List<Doctor> doctors = [
    Doctor(
      name: 'Dr. Ama Mensah',
      specialty: 'General Practitioner',
      rating: 4.9,
      isOnline: true,
    ),
    Doctor(
      name: 'Dr. Kofi Asante',
      specialty: 'Cardiologist',
      rating: 4.8,
      isOnline: true,
    ),
    Doctor(
      name: 'Dr. Efua Boateng',
      specialty: 'Pediatrician',
      rating: 4.7,
      isOnline: false,
    ),
    Doctor(
      name: 'Dr. Yaw Owusu',
      specialty: 'Dermatologist',
      rating: 4.6,
      isOnline: true,
    ),
    Doctor(
      name: 'Dr. Akosua Darko',
      specialty: 'Psychiatrist',
      rating: 4.9,
      isOnline: false,
    ),
    Doctor(
      name: 'Dr. Selorm Adjei',
      specialty: 'Nutrition Specialist',
      rating: 4.8,
      isOnline: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Doctors'),
        backgroundColor: kPrimary,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            tooltip: 'Logout',
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login',
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 14),
            color: Colors.white,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Choose a specialist',
                  style: TextStyle(
                    color: kTextDark,
                    fontSize: 23,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Tap a doctor to start a private consultation chat.',
                  style: TextStyle(color: kMuted),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: doctors.length,
              itemBuilder: (context, index) {
                final doctor = doctors[index];
                return Card(
                  elevation: 0,
                  margin: const EdgeInsets.symmetric(vertical: 7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                    side: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    leading: CircleAvatar(
                      radius: 28,
                      backgroundColor: kPrimary.withValues(alpha: 0.12),
                      child: const Icon(Icons.person, color: kPrimary),
                    ),
                    title: Text(
                      doctor.name,
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(doctor.specialty),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                size: 16,
                                color: Colors.amber,
                              ),
                              Text(' ${doctor.rating.toStringAsFixed(1)}'),
                              const SizedBox(width: 12),
                              Icon(
                                Icons.circle,
                                size: 9,
                                color: doctor.isOnline
                                    ? Colors.green
                                    : Colors.grey,
                              ),
                              Text(
                                doctor.isOnline ? ' Online' : ' Offline',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: doctor.isOnline
                                      ? Colors.green
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    trailing: const Icon(
                      Icons.chat_bubble_outline,
                      color: kPrimary,
                    ),
                    onTap: () {
                      // Route arguments carry the selected Doctor to ChatScreen.
                      Navigator.pushNamed(context, '/chat', arguments: doctor);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
