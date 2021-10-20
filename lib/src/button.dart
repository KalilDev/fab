import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/rendering.dart';

import 'theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class _DefaultHeroTag {
  const _DefaultHeroTag();
}

class _FABChild extends StatelessWidget {
  final Widget child;
  final String? tooltip;
  final Object? heroTag;

  const _FABChild({
    Key? key,
    required this.child,
    required this.tooltip,
    required this.heroTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var child = this.child;
    if (tooltip != null) {
      child = Tooltip(
        message: tooltip,
        child: child,
      );
    }
    if (heroTag != null) {
      child = Hero(
        tag: heroTag!,
        child: child,
      );
    }
    return child;
  }
}

/// An implementation of the [FloatingActionButton] widget which uses
/// [ButtonStyleButton], allowing for greater flexibility.
class FAB extends ButtonStyleButton {
  final bool mini;
  final bool isExtended;
  FAB({
    Key? key,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHover,
    ValueChanged<bool>? onFocusChange,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool autofocus = false,
    Clip clipBehavior = Clip.none,
    String? tooltip,
    Object? heroTag = const _DefaultHeroTag(),
    this.mini = false,
    this.isExtended = false,
    required Widget child,
  }) : super(
          key: key,
          onPressed: onPressed,
          onLongPress: onLongPress,
          onHover: onHover,
          onFocusChange: onFocusChange,
          style: style,
          focusNode: focusNode,
          autofocus: autofocus,
          clipBehavior: clipBehavior,
          child: _FABChild(
            child: child,
            tooltip: tooltip,
            heroTag: heroTag,
          ),
        );

  FAB.small({
    Key? key,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHover,
    ValueChanged<bool>? onFocusChange,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool autofocus = false,
    Clip clipBehavior = Clip.none,
    String? tooltip,
    Object? heroTag = const _DefaultHeroTag(),
    required Widget child,
  })  : mini = true,
        isExtended = false,
        super(
          key: key,
          onPressed: onPressed,
          onLongPress: onLongPress,
          onHover: onHover,
          onFocusChange: onFocusChange,
          style: style,
          focusNode: focusNode,
          autofocus: autofocus,
          clipBehavior: clipBehavior,
          child: _FABChild(
            child: child,
            tooltip: tooltip,
            heroTag: heroTag,
          ),
        );

  factory FAB.large({
    Key? key,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHover,
    ValueChanged<bool>? onFocusChange,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool autofocus,
    Clip clipBehavior,
    String? tooltip,
    Object? heroTag,
    required Widget child,
  }) = _LargeFAB;

  factory FAB.extended({
    Key? key,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHover,
    ValueChanged<bool>? onFocusChange,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool? autofocus,
    Clip? clipBehavior,
    Widget? icon,
    bool isExtended,
    String? tooltip,
    Object? heroTag,
    required Widget label,
  }) = _ExpandedFAB;

  static ButtonStyle styleFrom({
    Color? foregroundColor,
    Color? backgroundColor,
    Color? shadowColor,
    double? elevation,
    TextStyle? textStyle,
    EdgeInsetsGeometry? padding,
    Size? minimumSize,
    Size? fixedSize,
    Size? maximumSize,
    BorderSide? side,
    MouseCursor? enabledMouseCursor,
    MouseCursor? disabledMouseCursor,
    VisualDensity? visualDensity,
    MaterialTapTargetSize? tapTargetSize,
    Duration? animationDuration,
    bool? enableFeedback,
    AlignmentGeometry? alignment,
    InteractiveInkFeatureFactory? splashFactory,
    bool isExtended = false,
  }) {
    final MaterialStateProperty<MouseCursor>? mouseCursor =
        (enabledMouseCursor == null && disabledMouseCursor == null)
            ? null
            : _TextButtonDefaultMouseCursor(
                enabledMouseCursor!, disabledMouseCursor!);

    return ButtonStyle(
      textStyle: ButtonStyleButton.allOrNull<TextStyle>(textStyle),
      backgroundColor: ButtonStyleButton.allOrNull<Color>(backgroundColor),
      foregroundColor: ButtonStyleButton.allOrNull<Color>(foregroundColor),
      //overlayColor: overlayColor,
      shadowColor: ButtonStyleButton.allOrNull<Color>(shadowColor),
      elevation: _FABDefaultElevation(),
      padding: ButtonStyleButton.allOrNull<EdgeInsetsGeometry>(padding),
      minimumSize: ButtonStyleButton.allOrNull<Size>(minimumSize),
      fixedSize: ButtonStyleButton.allOrNull<Size>(fixedSize),
      maximumSize: ButtonStyleButton.allOrNull<Size>(maximumSize),
      side: ButtonStyleButton.allOrNull<BorderSide>(side),
      shape: _FABDefaultShape(isExtended),
      mouseCursor: mouseCursor,
      visualDensity: visualDensity,
      tapTargetSize: tapTargetSize,
      animationDuration: animationDuration,
      enableFeedback: enableFeedback,
      alignment: alignment,
      splashFactory: splashFactory,
    );
  }

  @override
  ButtonStyle defaultStyleOf(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    final EdgeInsetsGeometry scaledPadding = ButtonStyleButton.scaledPadding(
      const EdgeInsets.all(8),
      const EdgeInsets.symmetric(horizontal: 8),
      const EdgeInsets.symmetric(horizontal: 4),
      MediaQuery.maybeOf(context)?.textScaleFactor ?? 1,
    );

    final padding = scaledPadding;

    return styleFrom(
      foregroundColor: colorScheme.onSecondary,
      backgroundColor: colorScheme.secondary,
      shadowColor: theme.shadowColor,
      elevation: 0,
      textStyle: theme.textTheme.button!.copyWith(letterSpacing: 1.2),
      isExtended: isExtended,
      padding: padding,
      minimumSize: const Size.square(40),
      fixedSize: mini
          ? const Size.square(40)
          : isExtended || this is _ExpandedFAB
              ? const Size.fromHeight(48)
              : const Size.square(56),
      maximumSize: Size.infinite,
      enabledMouseCursor: SystemMouseCursors.click,
      disabledMouseCursor: SystemMouseCursors.forbidden,
      visualDensity: theme.visualDensity,
      tapTargetSize: theme.materialTapTargetSize,
      animationDuration: kThemeChangeDuration,
      enableFeedback: true,
      alignment: Alignment.center,
      splashFactory: InkRipple.splashFactory,
    );
  }

  @override
  ButtonStyle? themeStyleOf(BuildContext context) {
    return FABTheme.of(context).style;
  }
}

@immutable
class _FABDefaultShape extends MaterialStateProperty<OutlinedBorder> {
  final bool isExtended;

  _FABDefaultShape(this.isExtended);

  @override
  OutlinedBorder resolve(Set<MaterialState> states) =>
      isExtended ? const StadiumBorder() : const CircleBorder();
}

@immutable
class _FABDefaultElevation extends MaterialStateProperty<double> {
  @override
  double resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.pressed)) {
      return 12;
    }
    if (states.contains(MaterialState.focused)) {
      return 8;
    }
    if (states.contains(MaterialState.hovered)) {
      return 8;
    }
    if (states.contains(MaterialState.disabled)) {
      return 6;
    }
    return 6;
  }
}

@immutable
class _TextButtonDefaultOverlay extends MaterialStateProperty<Color?> {
  _TextButtonDefaultOverlay(this.primary);

  final Color primary;

  @override
  Color? resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.hovered))
      return primary.withOpacity(0.04);
    if (states.contains(MaterialState.focused) ||
        states.contains(MaterialState.pressed))
      return primary.withOpacity(0.12);
    return null;
  }

  @override
  String toString() {
    return '{hovered: ${primary.withOpacity(0.04)}, focused,pressed: ${primary.withOpacity(0.12)}, otherwise: null}';
  }
}

@immutable
class _TextButtonDefaultMouseCursor extends MaterialStateProperty<MouseCursor>
    with Diagnosticable {
  _TextButtonDefaultMouseCursor(this.enabledCursor, this.disabledCursor);

  final MouseCursor enabledCursor;
  final MouseCursor disabledCursor;

  @override
  MouseCursor resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled)) return disabledCursor;
    return enabledCursor;
  }
}

class _LargeFAB extends FAB {
  _LargeFAB({
    Key? key,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHover,
    ValueChanged<bool>? onFocusChange,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool autofocus = false,
    Clip clipBehavior = Clip.none,
    String? tooltip,
    Object? heroTag = const _DefaultHeroTag(),
    required Widget child,
  }) : super(
          key: key,
          onPressed: onPressed,
          onLongPress: onLongPress,
          onHover: onHover,
          onFocusChange: onFocusChange,
          style: style,
          focusNode: focusNode,
          autofocus: autofocus ?? false,
          clipBehavior: clipBehavior ?? Clip.none,
          tooltip: tooltip,
          heroTag: heroTag,
          isExtended: false,
          mini: false,
          child: IconTheme.merge(
            data: const IconThemeData(size: 36.0),
            child: child!,
          ),
        );

  @override
  ButtonStyle defaultStyleOf(BuildContext context) {
    final size = Size.square(96);
    return super.defaultStyleOf(context).copyWith(
          fixedSize: MaterialStateProperty.all<Size>(size),
        );
  }
}

class _LargeFABChild extends StatelessWidget {
  final Widget child;
  const _LargeFABChild({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _ExpandedFAB extends FAB {
  final bool _hasIcon;
  _ExpandedFAB({
    Key? key,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHover,
    ValueChanged<bool>? onFocusChange,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool? autofocus,
    Clip? clipBehavior,
    Widget? icon,
    String? tooltip,
    Object? heroTag = const _DefaultHeroTag(),
    bool isExtended = true,
    required Widget label,
  })  : assert(label != null),
        _hasIcon = icon != null,
        super(
          key: key,
          onPressed: onPressed,
          onLongPress: onLongPress,
          onHover: onHover,
          onFocusChange: onFocusChange,
          style: style,
          focusNode: focusNode,
          autofocus: autofocus ?? false,
          clipBehavior: clipBehavior ?? Clip.none,
          tooltip: tooltip,
          heroTag: heroTag,
          isExtended: isExtended,
          child: _ExpandedFABChild(
            icon: icon,
            label: label,
            isExtended: isExtended,
          ),
        );

  @override
  ButtonStyle defaultStyleOf(BuildContext context) {
    final padding = _hasIcon && isExtended
        ? EdgeInsetsDirectional.only(start: 16.0, end: 20.0)
        : EdgeInsetsDirectional.only(start: 20.0, end: 20.0);
    return super.defaultStyleOf(context).copyWith(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(padding),
        );
  }
}

class _ExpandedFABChild extends StatelessWidget {
  const _ExpandedFABChild({
    Key? key,
    required this.label,
    required this.icon,
    required this.isExtended,
  }) : super(key: key);

  final Widget label;
  final Widget? icon;
  final bool isExtended;

  @override
  Widget build(BuildContext context) {
    final double gap = 8;
    return _ChildOverflowBox(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (icon != null) icon!,
          if (icon != null && isExtended) SizedBox(width: gap),
          if (isExtended) label,
        ],
      ),
    );
  }
}

// This widget's size matches its child's size unless its constraints
// force it to be larger or smaller. The child is centered.
//
// Used to encapsulate extended FABs whose size is fixed, using Row
// and MainAxisSize.min, to be as wide as their label and icon.
class _ChildOverflowBox extends SingleChildRenderObjectWidget {
  const _ChildOverflowBox({
    Key? key,
    Widget? child,
  }) : super(key: key, child: child);

  @override
  _RenderChildOverflowBox createRenderObject(BuildContext context) {
    return _RenderChildOverflowBox(
      textDirection: Directionality.of(context),
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, _RenderChildOverflowBox renderObject) {
    renderObject.textDirection = Directionality.of(context);
  }
}

class _RenderChildOverflowBox extends RenderAligningShiftedBox {
  _RenderChildOverflowBox({
    RenderBox? child,
    TextDirection? textDirection,
  }) : super(
            child: child,
            alignment: Alignment.center,
            textDirection: textDirection);

  @override
  double computeMinIntrinsicWidth(double height) => 0.0;

  @override
  double computeMinIntrinsicHeight(double width) => 0.0;

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    if (child != null) {
      final Size childSize = child!.getDryLayout(const BoxConstraints());
      return Size(
        math.max(constraints.minWidth,
            math.min(constraints.maxWidth, childSize.width)),
        math.max(constraints.minHeight,
            math.min(constraints.maxHeight, childSize.height)),
      );
    } else {
      return constraints.biggest;
    }
  }

  @override
  void performLayout() {
    final BoxConstraints constraints = this.constraints;
    if (child != null) {
      child!.layout(const BoxConstraints(), parentUsesSize: true);
      size = Size(
        math.max(constraints.minWidth,
            math.min(constraints.maxWidth, child!.size.width)),
        math.max(constraints.minHeight,
            math.min(constraints.maxHeight, child!.size.height)),
      );
      alignChild();
    } else {
      size = constraints.biggest;
    }
  }
}
