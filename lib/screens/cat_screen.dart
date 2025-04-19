import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  // Dynamic lists for expense and income categories
  final List<Map<String, dynamic>> _expenseCategories = [
    {'icon': Icons.shopping_basket_outlined, 'title': 'Groceries', 'subtitle': 'Essential items'},
    {'icon': Icons.directions_car, 'title': 'Transport', 'subtitle': 'Fuel, fare, maintenance'},
    {'icon': Icons.restaurant, 'title': 'Dining', 'subtitle': 'Restaurants, takeout'},
  ];

  final List<Map<String, dynamic>> _incomeCategories = [
    {'icon': Icons.work_outline, 'title': 'Salary', 'subtitle': 'Regular employment'},
    {'icon': Icons.account_balance, 'title': 'Investments', 'subtitle': 'Returns & dividends'},
  ];

  // Method to add a new category
  void _addCategory(String type, String title, String subtitle) {
    setState(() {
      if (type == 'expense') {
        _expenseCategories.add({'icon': Icons.category, 'title': title, 'subtitle': subtitle});
      } else if (type == 'income') {
        _incomeCategories.add({'icon': Icons.category, 'title': title, 'subtitle': subtitle});
      }
    });
  }

  // Method to delete a category
  void _deleteCategory(String type, int index) {
    setState(() {
      if (type == 'expense') {
        _expenseCategories.removeAt(index);
      } else if (type == 'income') {
        _incomeCategories.removeAt(index);
      }
    });
  }

  // Show dialog to add a new category
  void _showAddCategoryDialog() {
    final titleController = TextEditingController();
    final subtitleController = TextEditingController();
    String selectedType = 'expense';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Category'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: selectedType,
                items: const [
                  DropdownMenuItem(value: 'expense', child: Text('Expense')),
                  DropdownMenuItem(value: 'income', child: Text('Income')),
                ],
                onChanged: (value) {
                  selectedType = value!;
                },
                decoration: const InputDecoration(labelText: 'Type'),
              ),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: subtitleController,
                decoration: const InputDecoration(labelText: 'Subtitle'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _addCategory(selectedType, titleController.text, subtitleController.text);
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Categories'),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: _showAddCategoryDialog,
        child: const Icon(Icons.add, color: Colors.white),
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
            ..._expenseCategories.asMap().entries.map((entry) {
              final index = entry.key;
              final category = entry.value;
              return _buildCategoryTile(category, 'expense', index);
            }),
            const SizedBox(height: 20),
            const Text(
              'Income Categories',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            ..._incomeCategories.asMap().entries.map((entry) {
              final index = entry.key;
              final category = entry.value;
              return _buildCategoryTile(category, 'income', index);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTile(Map<String, dynamic> cat, String type, int index) {
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
            // Handle edit (optional, can be implemented later)
          }),
          const SizedBox(width: 10),
          _iconButton(Icons.delete, () {
            _deleteCategory(type, index);
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
