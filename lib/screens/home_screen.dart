import 'package:flutter/material.dart';
import '../widgets/balance_card.dart';
import '../widgets/transaction_tile.dart';
import '../widgets/spending_tile.dart';
import '../utils/app_colors.dart';
import 'add_transaction.dart';
import 'stats_screen.dart';
import 'cat_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeContent(),
    const StatsScreen(),
  const CategoryScreen(),
  const SettingsScreen(),];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.white70,
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Header
          const Text(
            'Welcome Back!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Balance & Income/Expense Cards
          Row(
            children: [
              const Expanded(
                flex: 2,
                child: BalanceCard(
                  title: 'Balance',
                  value: 'Rs 0',
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
                        backgroundColor: Color.fromARGB(255, 149, 0, 0),
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

          // Recent Transactions
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recent Transactions",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                "View All",
                style: TextStyle(color: green),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const TransactionTile(
            title: 'Monthly Salary',
            date: 'Apr 11, 2025 · 05:00 AM',
            amount: '+ Rs 0',
            icon: Icons.attach_money,
            amountColor: green,
          ),

          const SizedBox(height: 24),

          // Monthly Spending
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Monthly Spending",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                "See Details",
                style: TextStyle(color: green),
              ),
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
