import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:interintel/config/app_config.dart';

class AppThemes {
  static const int light = 0;
  static const int dark = 1;
}

final themeCollection = ThemeCollection(
  themes: {
    AppThemes.light: ThemeData(
        primaryColor: InterIntel.themeColor, primarySwatch: Colors.cyan),
    AppThemes.dark: ThemeData.dark(),
  },
  fallbackTheme: ThemeData.light(),
);
