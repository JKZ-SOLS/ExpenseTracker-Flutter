import 'package:flutter/material.dart';
import '../widgets/balance_card.dart';
import '../widgets/transaction_tile.dart';
import '../widgets/spending_tile.dart';
import '../utils/app_colors.dart';
import 'add_transaction.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _onTabTapped(BuildContext context, int index) {
    final routes = ['/home', '/stats', '/categories', '/settings'];

    if (ModalRoute.of(context)?.settings.name != routes[index]) {
      Navigator.pushNamedAndRemoveUntil(context, routes[index], (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color green = AppColors.green;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 36, 36, 36),
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              '../../assets/icons/T.png',
              height: 40,
            ),
            const Text(
              '   My',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(width: 6),
            const Text(
              'Wallet',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
      body: const HomeContent(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: green,
        unselectedItemColor: Colors.white,
        currentIndex: 0, // Optional: set dynamically if needed
        onTap: (index) => _onTabTapped(context, index),
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: 'Stats'),
          BottomNavigationBarItem(icon: Icon(Icons.local_offer), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    const Color green = AppColors.green;
    const Color darkCard = AppColors.darkCard;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Balance & income/expense cards
          Row(
            children: [
              const Expanded(
                flex: 2,
                child: BalanceCard(
                  title: 'Balance',
                  value: 'Rs 15,000',
                  icon: Icons.attach_money,
                  iconColor: green,
                  backgroundColor: darkCard,
                  text: green,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AddTransactionScreen(isIncome: true),
                          ),
                        );
                      },
                      child: const BalanceCard(
                        title: 'Income',
                        value: 'Rs 15,000',
                        icon: Icons.arrow_upward,
                        iconColor: darkCard,
                        backgroundColor: Color.fromARGB(255, 0, 149, 20),
                        small: true,
                        text: darkCard,
                      ),
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AddTransactionScreen(isIncome: false),
                          ),
                        );
                      },
                      child: const BalanceCard(
                        title: 'Expenses',
                        value: 'Rs 0',
                        icon: Icons.arrow_downward,
                        iconColor: darkCard,
                        backgroundColor: Color.fromARGB(255, 0, 149, 20),
                        small: true,
                        text: darkCard,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Recent Transactions",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text("View All", style: TextStyle(color: green)),
            ],
          ),
          const SizedBox(height: 8),
          const TransactionTile(
            title: 'monthly',
            date: 'Apr 11, 2025 · 05:00 AM',
            amount: '+ Rs 15,000',
            icon: Icons.attach_money,
            amountColor: green,
          ),

          const SizedBox(height: 24),

          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Monthly Spending",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text("See Details", style: TextStyle(color: green)),
            ],
          ),
          const SizedBox(height: 8),
          const SpendingTile(category: 'Groceries', amount: 'Rs 0', percent: 0),
          const SpendingTile(category: 'Transport', amount: 'Rs 0', percent: 0),
          const SpendingTile(category: 'Dining', amount: 'Rs 0', percent: 0),
        ],
      ),
    );
  }
}
