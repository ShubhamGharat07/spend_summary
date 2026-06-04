import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SizeConfig {
  SizeConfig._();

  static const double designWidth = 390.0;
  static const double designHeight = 844.0;

  static double get h1 => 32.sp;
  static double get h2 => 24.sp;
  static double get h3 => 20.sp;
  static double get h4 => 18.sp;
  static double get h5 => 16.sp;
  static double get body => 14.sp;
  static double get caption => 12.sp;
  static double get micro => 10.sp;

  static double get spacingXS => 4.h;
  static double get spacingS => 8.h;
  static double get spacingM => 16.h;
  static double get spacingL => 24.h;
  static double get spacingXL => 32.h;

  static double get radiusS => 8.r;
  static double get radiusM => 12.r;
  static double get radiusL => 16.r;
  static double get radiusXL => 24.r;
  static double get radiusFull => 100.r;
}

extension ResponsiveExt on BuildContext {
  bool get isTablet => MediaQuery.of(this).size.width >= 600;
  bool get isLargeTablet => MediaQuery.of(this).size.width >= 900;
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
}
