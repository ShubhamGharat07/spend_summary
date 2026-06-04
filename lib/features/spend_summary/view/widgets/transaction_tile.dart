import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../../../core/colors/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../model/transaction_model.dart';

class TransactionTile extends StatelessWidget {
  final TransactionModel transaction;
  final int index;

  const TransactionTile({
    super.key,
    required this.transaction,
    required this.index,
  });

  List<Color> _getCategoryGradient(String category) {
    switch (category) {
      case AppStrings.food:
        return AppColors.foodGradient;
      case AppStrings.travel:
        return AppColors.travelGradient;
      case AppStrings.shopping:
        return AppColors.shoppingGradient;
      case AppStrings.entertainment:
        return AppColors.entertainmentGradient;
      case AppStrings.health:
        return AppColors.healthGradient;
      case AppStrings.bills:
        return AppColors.billsGradient;
      case AppStrings.transport:
        return AppColors.transportGradient;
      default:
        return AppColors.othersGradient;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case AppStrings.food:
        return Iconsax.cake;
      case AppStrings.travel:
        return Iconsax.airplane;
      case AppStrings.shopping:
        return Iconsax.bag_2;
      case AppStrings.entertainment:
        return Iconsax.music;
      case AppStrings.health:
        return Iconsax.heart;
      case AppStrings.bills:
        return Iconsax.receipt;
      case AppStrings.transport:
        return Iconsax.car;
      default:
        return Iconsax.category_2;
    }
  }

  @override
  Widget build(BuildContext context) {
    final gradient = _getCategoryGradient(transaction.category);

    return FadeInUp(
      delay: Duration(milliseconds: 35 * (index % 12)),
      duration: const Duration(milliseconds: 360),
      from: 14,
      child: GestureDetector(
        onTap: () {
          Get.snackbar(
            transaction.title,
            '${transaction.formattedAmount}  •  ${transaction.category}',
            backgroundColor: AppColors.card,
            colorText: AppColors.textPrimary,
            snackPosition: SnackPosition.TOP,
            margin: const EdgeInsets.all(16),
            borderRadius: 12,
            duration: const Duration(seconds: 2),
            borderColor: AppColors.borderSecondary,
            borderWidth: 1,
            icon: Icon(
              Iconsax.receipt_1,
              color: AppColors.primaryLight,
              size: 20.sp,
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 3.5.h),
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: AppColors.borderPrimary, width: 1.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // ── Icon — small, tinted, no heavy gradient ───────
              Container(
                width: 42.w,
                height: 42.w,
                decoration: BoxDecoration(
                  color: gradient.first.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  _getCategoryIcon(transaction.category),
                  color: gradient.last,
                  size: 19.sp,
                ),
              ),

              SizedBox(width: 12.w),

              // ── Title + subtitle ──────────────────────────────
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction.title,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13.5.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.1,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      '${transaction.category}  ·  ${transaction.formattedTime}',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textHint,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(width: 8.w),

              // ── Amount — clean, no icon badge ─────────────────
              Text(
                transaction.formattedAmount,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: transaction.isExpense
                      ? AppColors.expense
                      : AppColors.income,
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
