import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/colors/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../controller/spend_summary_controller.dart';

class HeaderSpendCard extends StatelessWidget {
  const HeaderSpendCard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SpendSummaryController>();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: AppColors.headerGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: const Color(0x40FFFFFF), width: 1.0),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.25),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(20.w),
      child: Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Top Row: label + % badge ──────────────────────────
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left — label + animated amount
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.thisMonth,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white70,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      AnimatedBuilder(
                        animation: controller.counterAnimation,
                        builder: (_, __) {
                          final value =
                              controller.totalSpend.value *
                              controller.counterAnimation.value;
                          return Text(
                            '₹${value.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d)(?=(\d{2})+(\d)(?!\d))'), (m) => '${m[1]},')}',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 34.sp,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              letterSpacing: -0.5,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                // Right — % change badge
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: controller.percentChange.value > 0
                            ? Colors.red.withOpacity(0.20)
                            : Colors.green.withOpacity(0.20),
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: controller.percentChange.value > 0
                              ? Colors.red.withOpacity(0.50)
                              : Colors.green.withOpacity(0.50),
                          width: 0.8,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            controller.percentChange.value > 0
                                ? Icons.arrow_upward_rounded
                                : Icons.arrow_downward_rounded,
                            size: 12.sp,
                            color: controller.percentChange.value > 0
                                ? Colors.redAccent
                                : Colors.greenAccent,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            '${controller.percentChange.value.toStringAsFixed(1)}%',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w700,
                              color: controller.percentChange.value > 0
                                  ? Colors.redAccent
                                  : Colors.greenAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      AppStrings.vsLastMonth,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11.sp,
                        color: Colors.white54,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 16.h),

            // ── Divider ───────────────────────────────────────────
            Container(height: 0.5, color: Colors.white24),

            SizedBox(height: 14.h),

            // ── Sparkline Row ─────────────────────────────────────
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.spent,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11.sp,
                        color: Colors.white54,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      '₹37,160',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  width: 120.w,
                  height: 48.h,
                  child: LineChart(
                    LineChartData(
                      titlesData: const FlTitlesData(show: false),
                      gridData: const FlGridData(show: false),
                      borderData: FlBorderData(show: false),
                      minY: 0,
                      lineTouchData: const LineTouchData(enabled: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots: controller.chartData
                              .asMap()
                              .entries
                              .map((e) => FlSpot(e.key.toDouble(), e.value))
                              .toList(),
                          isCurved: true,
                          curveSmoothness: 0.35,
                          color: Colors.white,
                          barWidth: 2.0,
                          isStrokeCapRound: true,
                          dotData: const FlDotData(show: false),
                          belowBarData: BarAreaData(
                            show: true,
                            gradient: LinearGradient(
                              colors: [
                                Colors.white.withOpacity(0.25),
                                Colors.white.withOpacity(0.0),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 14.h),

            // ── Divider ───────────────────────────────────────────
            Container(height: 0.5, color: Colors.white24),

            SizedBox(height: 14.h),

            // ── Stat Pills Row ────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _StatPill(label: AppStrings.avgPerDay, value: '₹1,238'),
                _VerticalDivider(),
                _StatPill(label: AppStrings.transactions, value: '57'),
                _VerticalDivider(),
                _StatPill(label: AppStrings.budgetLeft, value: '₹12,840'),
              ],
            ),
          ],
        );
      }),
    );
  }
}

class _StatPill extends StatelessWidget {
  final String label;
  final String value;

  const _StatPill({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 11.sp,
            color: Colors.white54,
          ),
        ),
        SizedBox(height: 3.h),
        Text(
          value,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(width: 0.5, height: 28.h, color: Colors.white24);
  }
}
