import 'package:ai_sales_manager_mobile/config/style/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextStyle {
  // adjustable fontSize
  //　automatically changes depending on screen size
  final TextStyle fontSize12sp = TextStyle(fontSize: 12.sp);
  final TextStyle fontSize14sp = TextStyle(fontSize: 14.sp);
  final TextStyle fontSize16sp = TextStyle(fontSize: 16.sp);
  final TextStyle fontSize20sp = TextStyle(fontSize: 20.sp);

  // static fontSize
  // does not change with screen size.
  static const TextStyle fontSize14 = TextStyle(fontSize: 14);
  static const TextStyle fontSize12 = TextStyle(fontSize: 12);

  // fontWeight
  static const TextStyle fontWeightNormal =
      TextStyle(fontWeight: FontWeight.normal);

  // fontColor
  static TextStyle fontColorPrimary = TextStyle(color: CustomColor.textPrimary);
}
