import 'package:flutter/material.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Statistics',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
            ),
            _statCard('Total Income', 'PKR 50,000', Icons.arrow_downward, Colors.green),
            _statCard('Total Expense', 'PKR 30,000', Icons.arrow_upward, Colors.red),
            _statCard('Savings', 'PKR 20,000', Icons.savings, Colors.blue),
            // TODO: Add pie chart later
          ],
        ),
      ),
    );
  }

  Widget _statCard(String title, String amount, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.white70)),
              Text(amount, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          )
        ],
      ),
    );
  }
}
