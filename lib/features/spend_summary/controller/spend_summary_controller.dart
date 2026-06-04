import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_strings.dart';
import '../../../data/mock_data.dart';
import '../model/category_model.dart';
import '../model/transaction_model.dart';

class SpendSummaryController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // ── Observables ────────────────────────────────────────────────
  final RxList<TransactionModel> allTransactions = <TransactionModel>[].obs;
  final RxList<TransactionModel> filteredTransactions =
      <TransactionModel>[].obs;
  final RxList<CategoryModel> categories = <CategoryModel>[].obs;
  final RxString selectedCategory = AppStrings.all.obs;
  final RxDouble totalSpend = 0.0.obs;
  final RxDouble percentChange = 0.0.obs;
  final RxBool isLoading = true.obs;
  final RxList<double> chartData = <double>[].obs;

  // ── Animation ──────────────────────────────────────────────────
  late AnimationController counterAnimController;
  late Animation<double> counterAnimation;

  @override
  void onInit() {
    super.onInit();
    counterAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    counterAnimation = CurvedAnimation(
      parent: counterAnimController,
      curve: Curves.easeOutCubic,
    );
    _loadData();
  }

  void _loadData() async {
    await Future.delayed(const Duration(milliseconds: 400));

    allTransactions.assignAll(MockData.transactions);
    filteredTransactions.assignAll(MockData.transactions);
    categories.assignAll(MockData.categories);
    totalSpend.value = MockData.totalMonthlySpend;
    percentChange.value = MockData.percentChange;
    chartData.assignAll(MockData.spendChartData);

    isLoading.value = false;
    counterAnimController.forward();
  }

  void selectCategory(String categoryName) {
    selectedCategory.value = categoryName;
    if (categoryName == AppStrings.all) {
      filteredTransactions.assignAll(allTransactions);
    } else {
      filteredTransactions.assignAll(
        allTransactions.where((t) => t.category == categoryName).toList(),
      );
    }
  }

  // Groups transactions by date label for section headers
  Map<String, List<TransactionModel>> get groupedTransactions {
    final Map<String, List<TransactionModel>> grouped = {};
    final now = DateTime.now();

    for (final transaction in filteredTransactions) {
      final date = transaction.dateTime;
      String label;

      final todayStr = DateFormat('yyyyMMdd').format(now);
      final txStr = DateFormat('yyyyMMdd').format(date);
      final yesterdayStr = DateFormat(
        'yyyyMMdd',
      ).format(now.subtract(const Duration(days: 1)));

      if (txStr == todayStr) {
        label = AppStrings.today;
      } else if (txStr == yesterdayStr) {
        label = AppStrings.yesterday;
      } else {
        label = DateFormat('dd MMMM').format(date);
      }

      grouped.putIfAbsent(label, () => []).add(transaction);
    }
    return grouped;
  }

  @override
  void onClose() {
    counterAnimController.dispose();
    super.onClose();
  }
}
