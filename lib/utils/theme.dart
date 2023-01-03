// ignore_for_file: avoid_classes_with_only_static_members

import 'package:flutter/material.dart';
import 'package:spiccato/utils/palette.dart';

class AppThemes {
  static ThemeData get light {
    return ThemeData(
      navigationRailTheme: const NavigationRailThemeData(
        backgroundColor: Palette.background700,
        elevation: 1.0,
        selectedIconTheme: IconThemeData(color: Palette.background400),
        unselectedIconTheme: IconThemeData(color: Palette.primary200),
        useIndicator: true,
        indicatorColor: Palette.primary400,
        labelType: NavigationRailLabelType.all,
        unselectedLabelTextStyle: TextStyle(color: Palette.primary200, fontFamily: 'IBM', fontWeight: FontWeight.w300),
        selectedLabelTextStyle: TextStyle(color: Palette.primary400, fontFamily: 'IBM', fontWeight: FontWeight.w400),
      ),
    );
  }
}
