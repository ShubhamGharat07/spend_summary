import 'package:flutter/material.dart';

class CategoryModel {
  final String id;
  final String name;
  final double totalAmount;
  final int transactionCount;
  final List<Color> gradientColors;
  final IconData icon;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.totalAmount,
    required this.transactionCount,
    required this.gradientColors,
    required this.icon,
  });

  String get formattedAmount {
    if (totalAmount >= 1000) {
      return '₹${(totalAmount / 1000).toStringAsFixed(1)}k';
    }
    return '₹${totalAmount.toStringAsFixed(0)}';
  }
}
