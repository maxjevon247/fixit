import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Technician extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Technicians'),
      ),
      body: const Center(
        child: Text('Technicians Page'),
      ),
    );
  }

  final String id;
  final String name;
  final String expertise;
  final String location;
  final double rating;
  final List<String> skills;
  final bool isAvailable;
// Other necessary fields

  const Technician({super.key, 
    required this.id,
    required this.name,
    required this.expertise,
    required this.location,
    required this.rating,
    required this.skills,
    required this.isAvailable,
    // Other necessary fields as per your requirements
  });
}

// class TechnicianService {
//   final CollectionReference technicians =
//       FirebaseFirestore.instance.collection('technicians');
//
//   Future<List<Map<String, dynamic>>> getTechnicians() async {
//     List<Map<String, dynamic>> technicianList = [];
//
//     try {
//       QuerySnapshot querySnapshot = await technicians.get();
//       querySnapshot.docs.forEach((doc) {
//         technicianList.add(doc.data());
//       });
//       return technicianList;
//     } catch (e) {
//       print("Error fetching technicians: $e");
//       return [];
//     }
//   }
//
//   static List<Technician> filterByLocation(
//       List<Technician> technicians, String location) {
//     return technicians
//         .where((technician) => technician.location == location)
//         .toList();
//   }
// }

class TechnicianService {
  final CollectionReference techniciansCollection =
      FirebaseFirestore.instance.collection('technicians');

  Future<List<Technician>> getTechnicians() async {
    List<Technician> technicians = [];

    try {
      QuerySnapshot querySnapshot = await techniciansCollection.get();

      for (var doc in querySnapshot.docs) {
        technicians.add(Technician(
          id: doc.id,
          name: doc['name'],
          expertise: doc['expertise'],
          location: doc['location'],
          skills: doc['skills'],
          isAvailable: doc['online'],
          rating: doc['rating'].toDouble(),
          // Add more fields as needed
        ));
      }
    } catch (e) {
      print('Error fetching technicians: $e');
    }

    return technicians;
  }

  // Function to filter technicians by location
  List<Technician> filterByLocation(
      List<Technician> technicians, String location) {
    return technicians
        .where((technician) => technician.location == location)
        .toList();
  }
}
