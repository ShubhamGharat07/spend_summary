import 'package:intl/intl.dart';

class TransactionModel {
  final String id;
  final String title;
  final String subtitle;
  final double amount;
  final bool isExpense;
  final String category;
  final DateTime dateTime;

  const TransactionModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.isExpense,
    required this.category,
    required this.dateTime,
  });

  String get formattedAmount => isExpense
      ? '-₹${NumberFormat('#,##,###').format(amount)}'
      : '+₹${NumberFormat('#,##,###').format(amount)}';

  String get formattedTime => DateFormat('hh:mm a').format(dateTime);
  String get formattedDate => DateFormat('dd MMM').format(dateTime);
}
