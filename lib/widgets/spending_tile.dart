import 'package:flutter/material.dart';

class SpendingTile extends StatelessWidget {
  final String category;
  final String amount;
  final double percent;

  const SpendingTile({
    super.key,
    required this.category,
    required this.amount,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.green.withOpacity(0.2),
            child: const Icon(Icons.shopping_bag, color: Colors.green),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(category, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(amount, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text('${(percent * 100).toStringAsFixed(0)}%', style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}
