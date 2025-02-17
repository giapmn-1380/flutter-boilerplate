import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';

class CustomBreakpoint {
  static bool isMobile(BuildContext context) {
    final breakPoint = Breakpoint.fromMediaQuery(context);
    return breakPoint.window == WindowSize.xsmall;
  }
}
