import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'marketplace.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await PaystackSdk.initialize(publicKey: 'your_paystack_public_key');
  runApp(const DeviceRepairApp());
}

class DeviceRepairApp extends StatelessWidget {
  const DeviceRepairApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Device Repair',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TechnicianListScreen(),
    );
  }
}

class TechnicianListScreen extends StatelessWidget {
  const TechnicianListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Technicians'),
      ),
      body: const Center(
        child: Text('List of Technicians'),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Drawer Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Users'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const UsersPage()));
              },
            ),
            ListTile(
              title: const Text('Technicians'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                //Navigator.push(context, MaterialPageRoute(builder: (context) => Technician()));
              },
            ),
            ListTile(
              title: const Text('Marketplace'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Marketplace()));
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text('Home Page'),
      ),
    );
  }
}

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: const Center(
        child: Text('Users Page'),
      ),
    );
  }
}
