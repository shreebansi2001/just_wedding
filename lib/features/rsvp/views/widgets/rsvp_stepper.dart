import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_strings.dart';

class RsvpStepper extends StatelessWidget {
  final int currentStep;

  const RsvpStepper({
    super.key,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    final steps = [
      AppStrings.stepRsvp,
      AppStrings.stepGuests,
      AppStrings.stepStay,
      AppStrings.stepTransport,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'STEP $currentStep OF 4',
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: AppDimens.paddingSm),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(steps.length, (index) {
            final stepIndex = index + 1;
            final isCompleted = stepIndex < currentStep;
            final isCurrent = stepIndex == currentStep;
            final isLast = index == steps.length - 1;

            return Expanded(
              child: Row(
                children: [
                  Column(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isCurrent
                              ? AppColors.primary
                              : isCompleted
                                  ? const Color(0xFFE5E7EB)
                                  : const Color(0xFFF3F4F6),
                          border: isCompleted
                              ? Border.all(color: const Color(0xFFD1D5DB))
                              : null,
                        ),
                        child: Center(
                          child: isCompleted
                              ? const Icon(
                                  Icons.check,
                                  size: 16,
                                  color: AppColors.textSecondary,
                                )
                              : isCurrent
                                  ? Text(
                                      '$stepIndex',
                                      style: const TextStyle(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    )
                                  : Icon(
                                      Icons.check,
                                      size: 16,
                                      color: Colors.grey.shade400,
                                    ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        steps[index],
                        style: TextStyle(
                          color: isCurrent ? AppColors.primary : AppColors.textSecondary,
                          fontSize: 10,
                          fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                  if (!isLast)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 18),
                        child: Container(
                          height: 1.5,
                          color: stepIndex < currentStep
                              ? AppColors.primary
                              : const Color(0xFFE5E7EB),
                        ),
                      ),
                    ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}
