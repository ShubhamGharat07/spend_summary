import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/colors/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../controller/spend_summary_controller.dart';
import 'category_chip.dart';

class CategoryScrollSection extends StatelessWidget {
  const CategoryScrollSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SpendSummaryController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Section Header ───────────────────────────────────────
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppStrings.categories,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 12.h),

        // ── Horizontal Scroll ────────────────────────────────────
        Obx(() {
          return SizedBox(
            height: 118.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              clipBehavior: Clip.none,
              padding: EdgeInsets.only(
                left: 16.w,
                right: 8.w,
                top: 2.h,
                bottom: 4.h,
              ),
              itemCount: controller.categories.length,
              itemBuilder: (ctx, i) {
                final cat = controller.categories[i];
                return Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: Obx(
                    () => CategoryChip(
                      category: cat,
                      isSelected: controller.selectedCategory.value == cat.name,
                      onTap: () => controller.selectCategory(cat.name),
                    ),
                  ),
                );
              },
            ),
          );
        }),
      ],
    );
  }
}
