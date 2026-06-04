import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/colors/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../controller/spend_summary_controller.dart';
import 'widgets/category_scroll_section.dart';
import 'widgets/gradient_fab.dart';
import 'widgets/header_spend_card.dart';
import 'widgets/transaction_list_section.dart';

class SpendSummaryScreen extends StatelessWidget {
  const SpendSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SpendSummaryController());

    return Scaffold(
      backgroundColor: AppColors.background,
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(context),
      floatingActionButton: const GradientFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Obx(() {
        if (controller.isLoading.value) {
          return _buildShimmer(context);
        }
        return _buildBody(context);
      }),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      centerTitle: true,
      leading: Container(
        margin: EdgeInsets.only(left: 16.w, top: 8.h, bottom: 8.h),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.borderPrimary),
        ),
        child: Icon(
          Icons.menu_rounded,
          color: AppColors.textPrimary,
          size: 20.sp,
        ),
      ),
      title: Column(
        children: [
          Text(
            AppStrings.goodMorning,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12.sp,
              color: AppColors.textSecondary,
            ),
          ),
          Text(
            AppStrings.userName,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 16.w, top: 8.h, bottom: 8.h),
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: AppColors.primaryGradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Center(
            child: Text(
              AppStrings.userInitials,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(0.5),
        child: Container(height: 0.5, color: AppColors.borderPrimary),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final body = CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(
            height: MediaQuery.of(context).padding.top + kToolbarHeight + 8.h,
          ),
        ),
        SliverToBoxAdapter(
          child: FadeIn(
            duration: const Duration(milliseconds: 500),
            child: const HeaderSpendCard(),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 20.h)),
        SliverToBoxAdapter(
          child: FadeInLeft(
            duration: const Duration(milliseconds: 450),
            delay: const Duration(milliseconds: 100),
            child: const CategoryScrollSection(),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 20.h)),
        SliverToBoxAdapter(
          child: FadeInUp(
            duration: const Duration(milliseconds: 400),
            delay: const Duration(milliseconds: 150),
            from: 20,
            child: const TransactionListSection(),
          ),
        ),
        // FAB clearance
        SliverToBoxAdapter(child: SizedBox(height: 100.h)),
      ],
    );

    // Tablet: constrain to 600px max
    if (context.isTablet) {
      return Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: body,
        ),
      );
    }
    return body;
  }

  Widget _buildShimmer(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top + kToolbarHeight + 8.h,
          ),
          // Header shimmer
          _ShimmerBox(
            height: 200.h,
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            radius: 24.r,
          ),
          SizedBox(height: 20.h),
          // Category shimmer
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: List.generate(
                4,
                (i) => Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: _ShimmerBox(width: 78.w, height: 110.h, radius: 16.r),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          // Transaction shimmer rows
          ...List.generate(
            6,
            (i) => _ShimmerBox(
              height: 72.h,
              margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
              radius: 16.r,
            ),
          ),
        ],
      ),
    );
  }
}

class _ShimmerBox extends StatefulWidget {
  final double? width;
  final double height;
  final EdgeInsets? margin;
  final double radius;

  const _ShimmerBox({
    this.width,
    required this.height,
    this.margin,
    required this.radius,
  });

  @override
  State<_ShimmerBox> createState() => _ShimmerBoxState();
}

class _ShimmerBoxState extends State<_ShimmerBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<Color?> _colorAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _colorAnim = ColorTween(
      begin: AppColors.card,
      end: AppColors.cardElevated,
    ).animate(_ctrl);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorAnim,
      builder: (_, __) => Container(
        width: widget.width,
        height: widget.height,
        margin: widget.margin,
        decoration: BoxDecoration(
          color: _colorAnim.value,
          borderRadius: BorderRadius.circular(widget.radius),
        ),
      ),
    );
  }
}
