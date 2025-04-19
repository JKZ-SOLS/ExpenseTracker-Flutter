import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final expenseCategories = [
      {'icon': Icons.shopping_basket_outlined, 'title': 'Groceries', 'subtitle': 'Essential items'},
      {'icon': Icons.directions_car, 'title': 'Transport', 'subtitle': 'Fuel, fare, maintenance'},
      {'icon': Icons.restaurant, 'title': 'Dining', 'subtitle': 'Restaurants, takeout'},
    ];

    final incomeCategories = [
      {'icon': Icons.work_outline, 'title': 'Salary', 'subtitle': 'Regular employment'},
      {'icon': Icons.account_balance, 'title': 'Investments', 'subtitle': 'Returns & dividends'},
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Categories'),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.white70,
        currentIndex: 2, // Categories
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: 'Stats'),
          BottomNavigationBarItem(icon: Icon(Icons.local_offer), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const SizedBox(height: 8),
            const Text(
              'Expense Categories',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            ...expenseCategories.map((cat) => _buildCategoryTile(cat)),
            const SizedBox(height: 20),
            const Text(
              'Income Categories',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            ...incomeCategories.map((cat) => _buildCategoryTile(cat)),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTile(Map<String, dynamic> cat) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(cat['icon'], color: Colors.white, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(cat['title'],
                    style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                Text(cat['subtitle'],
                    style: const TextStyle(color: Colors.white60, fontSize: 13)),
              ],
            ),
          ),
          const SizedBox(width: 10),
          _iconButton(Icons.edit, () {
            // Handle edit
          }),
          const SizedBox(width: 10),
          _iconButton(Icons.delete, () {
            // Handle delete
          }),
        ],
      ),
    );
  }

  Widget _iconButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: Colors.white10,
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}
