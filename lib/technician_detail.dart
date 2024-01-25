import 'package:fixit/technician.dart';
import 'package:flutter/material.dart';

class TechnicianDetailsScreen extends StatelessWidget {
  final Technician technician;

  const TechnicianDetailsScreen({super.key, required this.technician});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Technician Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              technician.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Expertise: ${technician.expertise}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Location: ${technician.location}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'Rating: ${technician.rating.toStringAsFixed(1)}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            const Text(
              'Skills:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: technician.skills
                  .map((skill) => Chip(
                        label: Text(skill),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 8),
            Text(
              'Availability: ${technician.isAvailable ? 'Available' : 'Not Available'}',
              style: const TextStyle(fontSize: 18),
            ),
            // Other technician details to display
          ],
        ),
      ),
    );
  }
}
