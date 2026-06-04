import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/colors/app_colors.dart';
import '../../model/category_model.dart';

class CategoryChip extends StatelessWidget {
  final CategoryModel category;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        width: 82.w,
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.borderPrimary,
            width: isSelected ? 1.5 : 1.0,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.22),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ── Icon — flat, no gradient bg when selected ────────
            AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withOpacity(0.18)
                    : _iconBgColor(category.gradientColors),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                category.icon,
                color: isSelected ? Colors.white : category.gradientColors.last,
                size: 18.sp,
              ),
            ),

            SizedBox(height: 8.h),

            // ── Name ─────────────────────────────────────────────
            Text(
              category.name,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : AppColors.textSecondary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 3.h),

            // ── Amount ───────────────────────────────────────────
            Text(
              category.formattedAmount,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
                color: isSelected
                    ? Colors.white.withOpacity(0.90)
                    : AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Soft tinted background for the icon — no bright gradient
  Color _iconBgColor(List<Color> gradient) {
    return gradient.first.withOpacity(0.10);
  }
}
