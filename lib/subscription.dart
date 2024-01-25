import 'package:flutter/material.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  // Implement UI to display subscription plans
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subscription Plans'),
      ),
      body: ListView(
        children: [
          SubscriptionPlan(
            name: 'Basic',
            price: 10.99,
            duration: 'Month',
            onTap: () {
              // Initiate subscription payment for 'Basic' plan
              // Implement payment logic using Stripe or other payment processor
            },
          ),
          SubscriptionPlan(
            name: 'Pro',
            price: 19.99,
            duration: 'Month',
            onTap: () {
              // Initiate subscription payment for 'Pro' plan
              // Implement payment logic using Stripe or other payment processor
            },
          ),
          // Add more subscription plans
        ],
      ),
    );
  }
}

class SubscriptionPlan extends StatelessWidget {
  final String name;
  final double price;
  final String duration;
  final VoidCallback onTap;

  const SubscriptionPlan({super.key, 
    required this.name,
    required this.price,
    required this.duration,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      subtitle: Text('\$$price / $duration'),
      onTap: onTap,
    );
  }
}
