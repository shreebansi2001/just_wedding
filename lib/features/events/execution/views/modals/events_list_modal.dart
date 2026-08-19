import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_dimens.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/widgets/app_text_field.dart';

class EventsListModal extends StatelessWidget {
  const EventsListModal({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const EventsListModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sampleEvents = [
      {
        'initial': 'B',
        'title': 'Bina Ketan Shah',
        'subtitle': 'B260001 • 19/02/2026 • 08:00 AM',
        'tag': 'Wedding',
        'isWedding': true,
      },
      {
        'initial': 'J',
        'title': 'Just Catering',
        'subtitle': 'C260001 • 24/03/2026 • 08:00 AM',
        'tag': 'Wedding',
        'isWedding': true,
      },
      {
        'initial': 'J',
        'title': 'Just Catering',
        'subtitle': 'D260001 • 04/03/2026',
        'tag': 'Reception',
        'isWedding': false,
      },
      {
        'initial': 'J',
        'title': 'Just Catering',
        'subtitle': 'D260002 • 04/04/2026',
        'tag': 'Reception',
        'isWedding': false,
      },
      {
        'initial': 'J',
        'title': 'Just Catering',
        'subtitle': 'D260003 • 04/05/2026',
        'tag': 'Reception',
        'isWedding': false,
      },
    ];

    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingLg, vertical: 12),
      child: Column(
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 44,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.events,
                style: GoogleFonts.publicSans(
                  color: AppColors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              GestureDetector(
                onTap: () => Get.back(),
                child: const Icon(Icons.close, size: 20, color: AppColors.textSecondary),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Search Field
          const AppTextField(
            hintText: 'Search by name, code, type or date...',
            prefixIcon: Icon(Icons.search, color: AppColors.hint, size: 20),
          ),
          const SizedBox(height: 16),

          // Events List
          Expanded(
            child: ListView.separated(
              itemCount: sampleEvents.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final item = sampleEvents[index];
                final isWedding = item['isWedding'] as bool;
                return GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.border),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.02),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.primaryTint,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            item['initial'] as String,
                            style: GoogleFonts.publicSans(
                              color: AppColors.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['title'] as String,
                                style: GoogleFonts.publicSans(
                                  color: AppColors.textPrimary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                item['subtitle'] as String,
                                style: GoogleFonts.publicSans(
                                  color: AppColors.textSecondary,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: isWedding ? AppColors.primaryTint : const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            item['tag'] as String,
                            style: GoogleFonts.publicSans(
                              color: isWedding ? AppColors.primary : AppColors.textSecondary,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
