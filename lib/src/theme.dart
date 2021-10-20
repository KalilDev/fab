import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Overrides the default [ButtonStyle] of its [TextButton] descendants.
///
/// See also:
///
///  * [FABThemeData], which is used to configure this theme.
///  * [TextButton.defaultStyleOf], which returns the default [ButtonStyle]
///    for text buttons.
///  * [TextButton.styleFrom], which converts simple values into a
///    [ButtonStyle] that's consistent with [TextButton]'s defaults.
///  * [ThemeData.textButtonTheme], which can be used to override the default
///    [ButtonStyle] for [TextButton]s below the overall [Theme].
class FABTheme extends InheritedTheme {
  /// Create a [FABTheme].
  ///
  /// The [data] parameter must not be null.
  const FABTheme({
    Key? key,
    required this.data,
    required Widget child,
  })  : assert(data != null),
        super(key: key, child: child);

  /// The configuration of this theme.
  final FABThemeData data;

  /// The closest instance of this class that encloses the given context.
  ///
  /// If there is no enclosing [FABTheme] widget, then
  /// [ThemeData.textButtonTheme] is used.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// TextButtonTheme theme = TextButtonTheme.of(context);
  /// ```
  static FABThemeData of(BuildContext context) {
    final FABTheme? buttonTheme =
        context.dependOnInheritedWidgetOfExactType<FABTheme>();
    return buttonTheme?.data ?? const FABThemeData();
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return FABTheme(data: data, child: child);
  }

  @override
  bool updateShouldNotify(FABTheme oldWidget) => data != oldWidget.data;
}

/// A [ButtonStyle] that overrides the default appearance of
/// [TextButton]s when it's used with [TextButtonTheme] or with the
/// overall [Theme]'s [ThemeData.textButtonTheme].
///
/// The [style]'s properties override [TextButton]'s default style,
/// i.e.  the [ButtonStyle] returned by [TextButton.defaultStyleOf]. Only
/// the style's non-null property values or resolved non-null
/// [MaterialStateProperty] values are used.
///
/// See also:
///
///  * [TextButtonTheme], the theme which is configured with this class.
///  * [TextButton.defaultStyleOf], which returns the default [ButtonStyle]
///    for text buttons.
///  * [TextButton.styleFrom], which converts simple values into a
///    [ButtonStyle] that's consistent with [TextButton]'s defaults.
///  * [MaterialStateProperty.resolve], "resolve" a material state property
///    to a simple value based on a set of [MaterialState]s.
///  * [ThemeData.textButtonTheme], which can be used to override the default
///    [ButtonStyle] for [TextButton]s below the overall [Theme].
@immutable
class FABThemeData with Diagnosticable {
  /// Creates a [FABThemeData].
  ///
  /// The [style] may be null.
  const FABThemeData({this.style});

  /// Overrides for [TextButton]'s default style.
  ///
  /// Non-null properties or non-null resolved [MaterialStateProperty]
  /// values override the [ButtonStyle] returned by
  /// [TextButton.defaultStyleOf].
  ///
  /// If [style] is null, then this theme doesn't override anything.
  final ButtonStyle? style;

  /// Linearly interpolate between two text button themes.
  static FABThemeData? lerp(FABThemeData? a, FABThemeData? b, double t) {
    assert(t != null);
    if (a == null && b == null) return null;
    return FABThemeData(
      style: ButtonStyle.lerp(a?.style, b?.style, t),
    );
  }

  @override
  int get hashCode {
    return style.hashCode;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is FABThemeData && other.style == style;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        DiagnosticsProperty<ButtonStyle>('style', style, defaultValue: null));
  }
}
