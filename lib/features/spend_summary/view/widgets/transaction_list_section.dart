import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../../../core/colors/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../controller/spend_summary_controller.dart';
import 'transaction_tile.dart';

class TransactionListSection extends StatelessWidget {
  const TransactionListSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SpendSummaryController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Section Header ──────────────────────────────────────
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppStrings.recentTransactions,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  letterSpacing: -0.2,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Get.snackbar(
                    AppStrings.allTransactions,
                    AppStrings.comingSoon,
                    backgroundColor: AppColors.card,
                    colorText: AppColors.textPrimary,
                    snackPosition: SnackPosition.TOP,
                    borderRadius: 12,
                    margin: const EdgeInsets.all(16),
                    borderColor: AppColors.borderSecondary,
                    borderWidth: 1,
                  );
                },
                child: Row(
                  children: [
                    Text(
                      AppStrings.seeAll,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryLight,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 11.sp,
                      color: AppColors.primaryLight,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 12.h),

        // ── Grouped Transactions ─────────────────────────────────
        Obx(() {
          if (controller.filteredTransactions.isEmpty) {
            return _buildEmptyState();
          }

          final grouped = controller.groupedTransactions;
          int globalIndex = 0;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: grouped.entries.map((entry) {
              final dateLabel = entry.key;
              final transactions = entry.value;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Date label — minimal, left-aligned ─────────
                  Padding(
                    padding: EdgeInsets.only(
                      left: 16.w,
                      right: 16.w,
                      top: 14.h,
                      bottom: 6.h,
                    ),
                    child: Row(
                      children: [
                        Text(
                          dateLabel,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11.5.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textHint,
                            letterSpacing: 0.2,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: AppColors.borderPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ── Tiles ────────────────────────────────────
                  ...transactions.map((tx) {
                    final tile = TransactionTile(
                      transaction: tx,
                      index: globalIndex,
                    );
                    globalIndex++;
                    return tile;
                  }),
                ],
              );
            }).toList(),
          );
        }),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 48.h),
        child: Column(
          children: [
            Icon(Iconsax.empty_wallet, size: 40.sp, color: AppColors.textHint),
            SizedBox(height: 10.h),
            Text(
              AppStrings.noTransactions,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13.sp,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
