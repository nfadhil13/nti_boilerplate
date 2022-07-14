import 'package:flutter/material.dart';

class ColorThemeWidget extends StatefulWidget {
  final ColorTheme initialTheme;
  final Widget child;
  const ColorThemeWidget(
      {Key? key, required this.initialTheme, required this.child})
      : super(key: key);

  @override
  State<ColorThemeWidget> createState() => _ColorThemeWidgetState();
}

class _ColorThemeWidgetState extends State<ColorThemeWidget> {
  late ColorTheme _currentTheme;

  @override
  void initState() {
    _currentTheme = widget.initialTheme;
    super.initState();
  }

  void _changeCurrentTheme(ColorTheme colorTheme) {
    setState(() {
      _currentTheme = colorTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ColorScope(
      colorTheme: _currentTheme,
      changeCurrentColor: _changeCurrentTheme,
      child: widget.child,
    );
  }
}

class ColorScope extends InheritedWidget {
  final ColorTheme colorTheme;
  final void Function(ColorTheme) changeCurrentColor;
  const ColorScope(
      {Key? key,
      required this.colorTheme,
      required super.child,
      required this.changeCurrentColor})
      : super(key: key);

  static ColorScope of(BuildContext context) {
    final widget = context.dependOnInheritedWidgetOfExactType<ColorScope>();
    if (widget == null) {
      throw Exception("Cant Found AuthenticatedWidget in the tree");
    }
    return widget;
  }

  @override
  bool updateShouldNotify(ColorScope oldWidget) {
    return oldWidget.colorTheme != colorTheme;
  }
}

abstract class ColorTheme {
  // Primary
  MaterialColor primary();

  MaterialColor onPrimary();

  MaterialColor primaryContainer();

  MaterialColor secondary();

  MaterialColor onSecondary();

  MaterialColor secondaryContainer();

  MaterialColor onSecondaryContainer();

  //Tertiary
  MaterialColor tertiary();

  MaterialColor onTertiary();

  MaterialColor tertiaryContainer();

  MaterialColor onTertiaryContainer();

  //Error
  MaterialColor error();

  MaterialColor onError();

  MaterialColor errorContainer();

  MaterialColor onErrorContainer();

  //Background
  MaterialColor background();

  MaterialColor onBackground();

  MaterialColor backgroundContainer();

  MaterialColor onBackgroundContainer();

  //Surface Variant
  MaterialColor surfaceVariant();

  MaterialColor onSurfaceVariant();

  MaterialColor surfaceVariantContainer();

  MaterialColor onSurfaceVariantContainer();

  MaterialColor surface();

  MaterialColor onSurface();

  MaterialColor seed();

  MaterialColor inverseSurface();
}

extension CtxThemeExt on BuildContext {
  ColorScope colorScope() => ColorScope.of(this);

  ColorTheme colorTheme() => ColorScope.of(this).colorTheme;
}
