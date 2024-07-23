import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    ColorScheme lightColorScheme = const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF009688),
      surfaceTint: Color(0xff006a64),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff9df2e9),
      onPrimaryContainer: Color(0xff00201e),
      secondary: Color(0xFFFF9800),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffcce8e4),
      onSecondaryContainer: Color(0xff051f1d),
      tertiary: Color(0xff48617a),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffcfe5ff),
      onTertiaryContainer: Color(0xff001d33),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      surface: Color(0xfff4fbf9),
      onSurface: Color(0xff161d1c),
      onSurfaceVariant: Color(0xff3f4947),
      outline: Color(0xff6f7977),
      outlineVariant: Color(0xffbec9c6),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3231),
      inversePrimary: Color(0xff81d5cd),
      primaryFixed: Color(0xff9df2e9),
      onPrimaryFixed: Color(0xff00201e),
      primaryFixedDim: Color(0xff81d5cd),
      onPrimaryFixedVariant: Color(0xff00504b),
      secondaryFixed: Color(0xffcce8e4),
      onSecondaryFixed: Color(0xff051f1d),
      secondaryFixedDim: Color(0xffb0ccc8),
      onSecondaryFixedVariant: Color(0xff324b49),
      tertiaryFixed: Color(0xffcfe5ff),
      onTertiaryFixed: Color(0xff001d33),
      tertiaryFixedDim: Color(0xffafc9e7),
      onTertiaryFixedVariant: Color(0xff304962),
      surfaceDim: Color(0xffd5dbd9),
      surfaceBright: Color(0xfff4fbf9),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f3),
      surfaceContainer: Color(0xffe9efed),
      surfaceContainerHigh: Color(0xffe3e9e8),
      surfaceContainerHighest: Color(0xffdde4e2),
    );
    return ThemeData(
        colorScheme: lightColorScheme,
        appBarTheme: AppBarTheme(
            backgroundColor: lightColorScheme.surface,
            titleTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: lightColorScheme.onSurface,
                fontSize: 16),
            iconTheme: IconThemeData(color: lightColorScheme.onSurface)));
  }

  static ThemeData get darkTheme {
    ColorScheme darkColorScheme = const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff81d5cd),
      surfaceTint: Color(0xff81d5cd),
      onPrimary: Color(0xff003734),
      primaryContainer: Color(0xff00504b),
      onPrimaryContainer: Color(0xff9df2e9),
      secondary: Color(0xffb0ccc8),
      onSecondary: Color(0xff1c3532),
      secondaryContainer: Color(0xff324b49),
      onSecondaryContainer: Color(0xffcce8e4),
      tertiary: Color(0xffafc9e7),
      onTertiary: Color(0xff18324a),
      tertiaryContainer: Color(0xff304962),
      onTertiaryContainer: Color(0xffcfe5ff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff0e1514),
      onSurface: Color(0xffdde4e2),
      onSurfaceVariant: Color(0xffbec9c6),
      outline: Color(0xff899391),
      outlineVariant: Color(0xff3f4947),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdde4e2),
      inversePrimary: Color(0xff006a64),
      primaryFixed: Color(0xff9df2e9),
      onPrimaryFixed: Color(0xff00201e),
      primaryFixedDim: Color(0xff81d5cd),
      onPrimaryFixedVariant: Color(0xff00504b),
      secondaryFixed: Color(0xffcce8e4),
      onSecondaryFixed: Color(0xff051f1d),
      secondaryFixedDim: Color(0xffb0ccc8),
      onSecondaryFixedVariant: Color(0xff324b49),
      tertiaryFixed: Color(0xffcfe5ff),
      onTertiaryFixed: Color(0xff001d33),
      tertiaryFixedDim: Color(0xffafc9e7),
      onTertiaryFixedVariant: Color(0xff304962),
      surfaceDim: Color(0xff0e1514),
      surfaceBright: Color(0xff343a39),
      surfaceContainerLowest: Color(0xff090f0f),
      surfaceContainerLow: Color(0xff161d1c),
      surfaceContainer: Color(0xff1a2120),
      surfaceContainerHigh: Color(0xff252b2a),
      surfaceContainerHighest: Color(0xff2f3635),
    );
    return ThemeData(
        colorScheme: darkColorScheme,
        appBarTheme: AppBarTheme(
            backgroundColor: darkColorScheme.surface,
            titleTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: darkColorScheme.onSurface,
                fontSize: 16),
            iconTheme: IconThemeData(color: darkColorScheme.onSurface)));
  }
}
