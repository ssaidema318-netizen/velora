import 'package:flutter/material.dart';

/// Lightweight, dependency-free responsive helpers for Velora.
///
/// The design mockups were built against a 375 x 812 reference screen
/// (a standard phone). These helpers scale spacing, fonts and sizes
/// relative to that baseline so the same numbers that look right on a
/// phone stay balanced on small phones, big phones and tablets instead
/// of being hard-coded pixel values.
class Responsive {
  Responsive._();

  static const double _referenceWidth = 375;
  static const double _referenceHeight = 812;

  /// Breakpoint above which we treat the device as a tablet.
  static const double tabletBreakpoint = 600;
}

extension ResponsiveContext on BuildContext {
  Size get _screenSize => MediaQuery.sizeOf(this);

  double get screenWidth => _screenSize.width;
  double get screenHeight => _screenSize.height;

  /// True when running on a tablet-sized viewport.
  bool get isTablet => screenWidth >= Responsive.tabletBreakpoint;

  /// Scales a width-based value (spacing, icon size, container width)
  /// relative to the 375-wide reference design, clamped so it never
  /// shrinks or grows to an unusable size.
  double w(double value) {
    final scale = (screenWidth / Responsive._referenceWidth).clamp(0.8, 1.6);
    return value * scale;
  }

  /// Scales a height-based value relative to the reference design.
  double h(double value) {
    final scale = (screenHeight / Responsive._referenceHeight).clamp(0.8, 1.6);
    return value * scale;
  }

  /// Scales a font size relative to the reference design width, with a
  /// tighter clamp so text stays legible without overflowing on
  /// small screens or looking oversized on tablets.
  double sp(double value) {
    final scale = (screenWidth / Responsive._referenceWidth).clamp(0.85, 1.3);
    return value * scale;
  }

  /// Percentage of the current screen width (0-100).
  double wp(double percent) => screenWidth * (percent / 100);

  /// Percentage of the current screen height (0-100).
  double hp(double percent) => screenHeight * (percent / 100);

  /// Returns [phone] on normal screens and [tablet] on tablet-sized
  /// screens, so widgets can pick sensible values (e.g. grid column
  /// count) for either without an ad-hoc MediaQuery check.
  T responsive<T>({required T phone, required T tablet}) =>
      isTablet ? tablet : phone;
}
