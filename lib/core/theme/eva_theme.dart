import 'package:flutter/material.dart';

class EvaPalette {
  const EvaPalette({
    required this.dark,
    required this.bg,
    required this.ink,
    required this.muted,
    required this.faint,
    required this.glass,
    required this.line,
    required this.primary,
    required this.secondary,
    required this.accent,
    required this.success,
    required this.warning,
    required this.onPrimary,
    required this.successInk,
    required this.warningInk,
    required this.shadow,
  });

  final bool dark;
  final Color bg;
  final Color ink;
  final Color muted;
  final Color faint;
  final Color glass;
  final Color line;
  final Color primary;
  final Color secondary;
  final Color accent;
  final Color success;
  final Color warning;
  final Color onPrimary;
  final Color successInk;
  final Color warningInk;
  final Color shadow;

  static const darkTheme = EvaPalette(
    dark: true,
    bg: Color(0xFF07060E),
    ink: Color(0xFFF6F3FF),
    muted: Color(0xFFA39BB8),
    faint: Color(0xFF6F6886),
    glass: Color.fromRGBO(255, 255, 255, 0.075),
    line: Color.fromRGBO(255, 255, 255, 0.14),
    primary: Color(0xFF6C5CE7),
    secondary: Color(0xFFA29BFE),
    accent: Color(0xFFFD79A8),
    success: Color(0xFF00B894),
    warning: Color(0xFFFDCB6E),
    onPrimary: Color(0xFFF8F6FF),
    successInk: Color(0xFF7DFFDF),
    warningInk: Color(0xFFFDCB6E),
    shadow: Color.fromRGBO(0, 0, 0, 0.45),
  );

  static const lightTheme = EvaPalette(
    dark: false,
    bg: Color(0xFFF4F0FB),
    ink: Color(0xFF1B1630),
    muted: Color(0xFF5C5670),
    faint: Color(0xFF8A849C),
    glass: Color.fromRGBO(255, 255, 255, 0.72),
    line: Color.fromRGBO(108, 92, 231, 0.16),
    primary: Color(0xFF5B4AD6),
    secondary: Color(0xFF7A72E0),
    accent: Color(0xFFD45388),
    success: Color(0xFF0A8F72),
    warning: Color(0xFFC9922A),
    onPrimary: Color(0xFFFFFFFF),
    successInk: Color(0xFF06785F),
    warningInk: Color(0xFF8A6410),
    shadow: Color.fromRGBO(88, 72, 150, 0.16),
  );
}

EvaPalette evaOf(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark ? EvaPalette.darkTheme : EvaPalette.lightTheme;
}

class EvaType {
  const EvaType._();

  static TextStyle display(double size, Color color, {FontWeight weight = FontWeight.w500, double height = 1.05}) {
    return TextStyle(
      fontFamily: 'Fraunces',
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      letterSpacing: -0.7,
    );
  }

  static TextStyle ui(
    double size,
    Color color, {
    FontWeight weight = FontWeight.w400,
    double height = 1.35,
    double tracking = 0,
  }) {
    return TextStyle(
      fontFamily: 'Outfit',
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
      letterSpacing: tracking,
    );
  }
}

ThemeData evaTheme(EvaPalette palette) {
  final scheme = ColorScheme(
    brightness: palette.dark ? Brightness.dark : Brightness.light,
    primary: palette.primary,
    onPrimary: palette.onPrimary,
    secondary: palette.secondary,
    onSecondary: palette.ink,
    error: palette.accent,
    onError: Colors.white,
    surface: palette.bg,
    onSurface: palette.ink,
  );
  return ThemeData(
    useMaterial3: true,
    brightness: palette.dark ? Brightness.dark : Brightness.light,
    colorScheme: scheme,
    scaffoldBackgroundColor: palette.bg,
    splashFactory: NoSplash.splashFactory,
    hoverColor: Colors.transparent,
    highlightColor: Colors.transparent,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: palette.accent,
      selectionColor: palette.primary.withValues(alpha: 0.28),
    ),
    fontFamily: 'Outfit',
  );
}

class EvaScrollBehavior extends MaterialScrollBehavior {
  const EvaScrollBehavior();

  @override
  Widget buildScrollbar(BuildContext context, Widget child, ScrollableDetails details) => child;

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());
  }
}
