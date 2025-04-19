enum TransactionCategory {
  food,
  transport,
  entertainment,
  shopping,
  bills,
  other
}

class Transaction {
  final TransactionCategory category;
  final String description;
  final double amount;
  final DateTime date;

  Transaction({
    required this.category,
    required this.description,
    required this.amount,
    required this.date,
  });
}