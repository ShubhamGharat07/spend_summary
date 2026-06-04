import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../../../core/colors/app_colors.dart';
import '../../../../core/constants/app_strings.dart';

class GradientFAB extends StatefulWidget {
  const GradientFAB({super.key});

  @override
  State<GradientFAB> createState() => _GradientFABState();
}

class _GradientFABState extends State<GradientFAB> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        Get.snackbar(
          AppStrings.addExpense,
          AppStrings.comingSoon,
          backgroundColor: AppColors.card,
          colorText: AppColors.textPrimary,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.all(16),
          borderRadius: 16,
          duration: const Duration(seconds: 2),
          borderColor: AppColors.borderSecondary,
          borderWidth: 1,
          icon: Icon(
            Iconsax.add_circle,
            color: AppColors.primaryLight,
            size: 20.sp,
          ),
        );
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.92 : 1.0,
        duration: const Duration(milliseconds: 150),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: 58.w,
          height: 58.w,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: AppColors.fabGradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(18.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.40),
                blurRadius: _isPressed ? 10 : 20,
                offset: Offset(0, _isPressed ? 4 : 8),
              ),
              BoxShadow(
                color: AppColors.primary.withOpacity(0.20),
                blurRadius: _isPressed ? 20 : 40,
                offset: Offset(0, _isPressed ? 8 : 16),
              ),
            ],
          ),
          child: Icon(Icons.add_rounded, color: Colors.white, size: 28.sp),
        ),
      ),
    );
  }
}
