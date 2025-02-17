import 'package:flutter_boilerplate/config/style/custom_color.dart';
import 'package:flutter/material.dart';

extension TextStyleExtension on TextStyle {
  TextStyle bold() => copyWith(fontWeight: FontWeight.w700);

  TextStyle white() => copyWith(color: CustomColor.white);
}
