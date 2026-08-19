import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_dimens.dart';

class WizardProgressBar extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final String title;

  const WizardProgressBar({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final progress = currentStep / totalSteps;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Step $currentStep of $totalSteps',
              style: GoogleFonts.publicSans(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
            Text(
              title,
              style: GoogleFonts.publicSans(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimens.paddingSm),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Container(
            height: 4,
            width: double.infinity,
            color: AppColors.border,
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress,
              child: Container(
                color: AppColors.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

