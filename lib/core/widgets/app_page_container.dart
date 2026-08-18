import 'package:flutter/material.dart';
import '../utils/responsive.dart';
import '../constants/app_dimens.dart';

class AppPageContainer extends StatelessWidget {
  final Widget child;
  final bool hasPadding;
  final double maxWidth;
  
  const AppPageContainer({super.key, required this.child, this.hasPadding = true, this.maxWidth = 1200});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, info) {
        final horizontalPadding = info.pick<double>(
          mobile: AppDimens.paddingMd,
          tablet: AppDimens.paddingLg,
          desktop: AppDimens.paddingXl,
        );
        
        final verticalPadding = info.pick<double>(
          mobile: AppDimens.paddingMd,
          tablet: AppDimens.paddingMd,
          desktop: AppDimens.paddingLg,
        );

        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Padding(
              padding: hasPadding 
                  ? EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding) 
                  : EdgeInsets.zero,
              child: child,
            ),
          ),
        );
      },
    );
  }
}
