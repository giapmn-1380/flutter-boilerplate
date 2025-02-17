import 'package:ai_sales_manager_mobile/config/style/custom_color.dart';
import 'package:flutter/material.dart';

class CustomShape {
  static const radius8 = Radius.circular(8);
  static const radius6 = Radius.circular(6);
  static final borderRadius0 = BorderRadius.circular(0);
  static final borderRadius4 = BorderRadius.circular(4);
  static final borderRadius6 = BorderRadius.circular(6);
  static final borderRadius8 = BorderRadius.circular(8);


  static const borderRadiusTopLeft10 =
      BorderRadius.only(topLeft: Radius.circular(10));

  static const appBarShapeTopRadius10 = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(10),
      topRight: Radius.circular(10),
    ),
  );

  static final buttonShapeRadius4 = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(4),
  );
  static final buttonShapeRadius8 = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8),
  );
  static final buttonShapeRadius10 = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
  );

  static final boxShadowRadius1 = BoxShadow(
    color: CustomColor.shadow.withOpacity(0.06),
    blurRadius: 6,
    offset: const Offset(0, 1),
  );
}
