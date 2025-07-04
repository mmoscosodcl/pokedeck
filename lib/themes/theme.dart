import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xffb3071b),
      surfaceTint: Color(0xffbc1320),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffd72b30),
      onPrimaryContainer: Color(0xfffff4f2),
      secondary: Color(0xffa23c38),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xfffd8179),
      onSecondaryContainer: Color(0xff731919),
      tertiary: Color(0xff0c4784),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff2f5f9d),
      onTertiaryContainer: Color(0xffc4d9ff),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffff8f7),
      onSurface: Color(0xff281716),
      onSurfaceVariant: Color(0xff5c403d),
      outline: Color(0xff906f6c),
      outlineVariant: Color(0xffe4bdba),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff3e2c2a),
      inversePrimary: Color(0xffffb3ad),
      primaryFixed: Color(0xffffdad7),
      onPrimaryFixed: Color(0xff410004),
      primaryFixedDim: Color(0xffffb3ad),
      onPrimaryFixedVariant: Color(0xff930012),
      secondaryFixed: Color(0xffffdad7),
      onSecondaryFixed: Color(0xff410004),
      secondaryFixedDim: Color(0xffffb3ad),
      onSecondaryFixedVariant: Color(0xff832523),
      tertiaryFixed: Color(0xffd5e3ff),
      onTertiaryFixed: Color(0xff001c3b),
      tertiaryFixedDim: Color(0xffa7c8ff),
      onTertiaryFixedVariant: Color(0xff0c4784),
      surfaceDim: Color(0xfff1d3d0),
      surfaceBright: Color(0xfffff8f7),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff0ef),
      surfaceContainer: Color(0xffffe9e7),
      surfaceContainerHigh: Color(0xffffe2df),
      surfaceContainerHighest: Color(0xfffadcd9),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff73000c),
      surfaceTint: Color(0xffbc1320),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffd2272d),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff6c1315),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffb64a45),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff00366a),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff2f5f9d),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff8f7),
      onSurface: Color(0xff1c0d0c),
      onSurfaceVariant: Color(0xff49302d),
      outline: Color(0xff684b49),
      outlineVariant: Color(0xff856563),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff3e2c2a),
      inversePrimary: Color(0xffffb3ad),
      primaryFixed: Color(0xffd2272d),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xffad0018),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xffb64a45),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff963330),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff406ead),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff235593),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffddc0bd),
      surfaceBright: Color(0xfffff8f7),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff0ef),
      surfaceContainer: Color(0xffffe2df),
      surfaceContainerHigh: Color(0xfff4d6d3),
      surfaceContainerHighest: Color(0xffe9cbc8),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff600008),
      surfaceTint: Color(0xffbc1320),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff970013),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff5d070c),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff862725),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff002c58),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff114986),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff8f7),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff3e2624),
      outlineVariant: Color(0xff5e4240),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff3e2c2a),
      inversePrimary: Color(0xffffb3ad),
      primaryFixed: Color(0xff970013),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff6d000b),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff862725),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff670f12),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff114986),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff003364),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffcfb2b0),
      surfaceBright: Color(0xfffff8f7),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffffedeb),
      surfaceContainer: Color(0xfffadcd9),
      surfaceContainerHigh: Color(0xffebcecb),
      surfaceContainerHighest: Color(0xffddc0bd),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffb3ad),
      surfaceTint: Color(0xffffb3ad),
      onPrimary: Color(0xff68000a),
      primaryContainer: Color(0xffd72b30),
      onPrimaryContainer: Color(0xfffff4f2),
      secondary: Color(0xffffb3ad),
      onSecondary: Color(0xff630d10),
      secondaryContainer: Color(0xff832523),
      onSecondaryContainer: Color(0xffff9992),
      tertiary: Color(0xffa7c8ff),
      onTertiary: Color(0xff003060),
      tertiaryContainer: Color(0xff2f5f9d),
      onTertiaryContainer: Color(0xffc4d9ff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff1e0f0e),
      onSurface: Color(0xfffadcd9),
      onSurfaceVariant: Color(0xffe4bdba),
      outline: Color(0xffab8885),
      outlineVariant: Color(0xff5c403d),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfffadcd9),
      inversePrimary: Color(0xffbc1320),
      primaryFixed: Color(0xffffdad7),
      onPrimaryFixed: Color(0xff410004),
      primaryFixedDim: Color(0xffffb3ad),
      onPrimaryFixedVariant: Color(0xff930012),
      secondaryFixed: Color(0xffffdad7),
      onSecondaryFixed: Color(0xff410004),
      secondaryFixedDim: Color(0xffffb3ad),
      onSecondaryFixedVariant: Color(0xff832523),
      tertiaryFixed: Color(0xffd5e3ff),
      onTertiaryFixed: Color(0xff001c3b),
      tertiaryFixedDim: Color(0xffa7c8ff),
      onTertiaryFixedVariant: Color(0xff0c4784),
      surfaceDim: Color(0xff1e0f0e),
      surfaceBright: Color(0xff483433),
      surfaceContainerLowest: Color(0xff190a09),
      surfaceContainerLow: Color(0xff281716),
      surfaceContainer: Color(0xff2c1b1a),
      surfaceContainerHigh: Color(0xff372524),
      surfaceContainerHighest: Color(0xff43302e),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffd2ce),
      surfaceTint: Color(0xffffb3ad),
      onPrimary: Color(0xff540006),
      primaryContainer: Color(0xffff5450),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffffd2ce),
      onSecondary: Color(0xff540107),
      secondaryContainer: Color(0xffe36d66),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffcbddff),
      onTertiary: Color(0xff00264d),
      tertiaryContainer: Color(0xff6692d4),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff1e0f0e),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xfffcd3cf),
      outline: Color(0xffcfa9a6),
      outlineVariant: Color(0xffab8885),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfffadcd9),
      inversePrimary: Color(0xff950013),
      primaryFixed: Color(0xffffdad7),
      onPrimaryFixed: Color(0xff2d0002),
      primaryFixedDim: Color(0xffffb3ad),
      onPrimaryFixedVariant: Color(0xff73000c),
      secondaryFixed: Color(0xffffdad7),
      onSecondaryFixed: Color(0xff2d0002),
      secondaryFixedDim: Color(0xffffb3ad),
      onSecondaryFixedVariant: Color(0xff6c1315),
      tertiaryFixed: Color(0xffd5e3ff),
      onTertiaryFixed: Color(0xff001129),
      tertiaryFixedDim: Color(0xffa7c8ff),
      onTertiaryFixedVariant: Color(0xff00366a),
      surfaceDim: Color(0xff1e0f0e),
      surfaceBright: Color(0xff54403e),
      surfaceContainerLowest: Color(0xff100504),
      surfaceContainerLow: Color(0xff2a1918),
      surfaceContainer: Color(0xff352322),
      surfaceContainerHigh: Color(0xff412e2c),
      surfaceContainerHighest: Color(0xff4d3937),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffecea),
      surfaceTint: Color(0xffffb3ad),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffffaea7),
      onPrimaryContainer: Color(0xff220001),
      secondary: Color(0xffffecea),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffffaea7),
      onSecondaryContainer: Color(0xff220001),
      tertiary: Color(0xffeaf0ff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffa0c4ff),
      onTertiaryContainer: Color(0xff000b1e),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff1e0f0e),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffffecea),
      outlineVariant: Color(0xffe0bab6),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xfffadcd9),
      inversePrimary: Color(0xff950013),
      primaryFixed: Color(0xffffdad7),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffffb3ad),
      onPrimaryFixedVariant: Color(0xff2d0002),
      secondaryFixed: Color(0xffffdad7),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffffb3ad),
      onSecondaryFixedVariant: Color(0xff2d0002),
      tertiaryFixed: Color(0xffd5e3ff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffa7c8ff),
      onTertiaryFixedVariant: Color(0xff001129),
      surfaceDim: Color(0xff1e0f0e),
      surfaceBright: Color(0xff604b49),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff2c1b1a),
      surfaceContainer: Color(0xff3e2c2a),
      surfaceContainerHigh: Color(0xff4a3735),
      surfaceContainerHighest: Color(0xff564240),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
