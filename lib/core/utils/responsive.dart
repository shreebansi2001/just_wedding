import 'package:flutter/widgets.dart';
import '../constants/app_breakpoints.dart';

class ResponsiveInfo {
  final BoxConstraints constraints;
  final Orientation orientation;
  final Size screenSize;

  ResponsiveInfo({
    required this.constraints,
    required this.orientation,
    required this.screenSize,
  });

  bool get isMobile => constraints.maxWidth < AppBreakpoints.tablet;
  bool get isTablet => constraints.maxWidth >= AppBreakpoints.tablet && constraints.maxWidth < AppBreakpoints.desktop;
  bool get isDesktop => constraints.maxWidth >= AppBreakpoints.desktop;

  bool get isLandscape => orientation == Orientation.landscape;
  bool get isShortScreen => screenSize.height < AppBreakpoints.shortScreenHeight;

  T pick<T>({required T mobile, T? tablet, T? desktop}) {
    if (isDesktop && desktop != null) return desktop;
    if (isTablet && tablet != null) return tablet;
    return mobile;
  }
}

class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, ResponsiveInfo info) builder;

  const ResponsiveBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var mediaQuery = MediaQuery.of(context);
        var responsiveInfo = ResponsiveInfo(
          constraints: constraints,
          orientation: mediaQuery.orientation,
          screenSize: mediaQuery.size,
        );
        return builder(context, responsiveInfo);
      },
    );
  }
}
