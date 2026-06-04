import 'package:get/get.dart';
import '../features/spend_summary/view/spend_summary_screen.dart';

class AppPages {
  AppPages._();

  static const initial = '/spend-summary';

  static final routes = [
    GetPage(
      name: '/spend-summary',
      page: () => const SpendSummaryScreen(),
      transition: Transition.fadeIn,
    ),
  ];
}
