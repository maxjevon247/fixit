import 'package:flutter/material.dart';

class Marketplace extends StatelessWidget {
  // Retrieve advertisements from your database or API
  final List<Advertisement> advertisements = [];

  Marketplace({super.key}); // Populate this list with advertisement data

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Marketplace'),
      ),
      body: ListView.builder(
        itemCount: advertisements.length,
        itemBuilder: (context, index) {
          Advertisement ad = advertisements[index];
          return ListTile(
            title: Text(ad.title),
            subtitle: Text(ad.description),
            trailing: Text('\$${ad.price}'), // Display advertisement price
            onTap: () {
              // Navigate to advertisement details page or take action
              // when an advertisement is tapped
            },
          );
        },
      ),
    );
  }
}

class Advertisement {
  final String title;
  final String description;
  final double price;

  Advertisement(
      {required this.title, required this.description, required this.price});
}
