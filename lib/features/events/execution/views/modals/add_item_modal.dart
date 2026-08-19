import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_dimens.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/app_text_field.dart';

class AddItemModal extends StatefulWidget {
  const AddItemModal({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddItemModal(),
    );
  }

  @override
  State<AddItemModal> createState() => _AddItemModalState();
}

class _AddItemModalState extends State<AddItemModal> {
  final nameController = TextEditingController();
  String selectedCategory = 'Artist & Entertainment';
  String selectedUnit = 'KG';

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      padding: EdgeInsets.only(
        top: 12,
        left: AppDimens.paddingLg,
        right: AppDimens.paddingLg,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppDimens.paddingLg,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
                AppStrings.addItem,
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
          const Divider(height: 1, color: AppColors.border),
          const SizedBox(height: 16),

          // Name *
          _buildFieldLabel(AppStrings.name, isRequired: true),
          AppTextField(
            hintText: 'Enter item name',
            controller: nameController,
          ),
          const SizedBox(height: AppDimens.paddingMd),

          // Item Main Category *
          _buildFieldLabel('Item Main Category', isRequired: true),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: const Color(0xFFFAFAFA),
              borderRadius: BorderRadius.circular(AppDimens.radiusMd),
              border: Border.all(color: AppColors.border),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedCategory,
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.hint),
                items: [
                  'Artist & Entertainment',
                  'Flowers & Props',
                  'Decorative Lighting',
                  'Sound & AV',
                  'Mandap & Structure',
                ].map((c) => DropdownMenuItem(
                      value: c,
                      child: Text(
                        c,
                        style: GoogleFonts.publicSans(
                          color: AppColors.textPrimary,
                          fontSize: 13,
                        ),
                      ),
                    )).toList(),
                onChanged: (val) {
                  if (val != null) setState(() => selectedCategory = val);
                },
              ),
            ),
          ),
          const SizedBox(height: AppDimens.paddingMd),

          // Unit Type *
          _buildFieldLabel(AppStrings.unitType, isRequired: true),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: const Color(0xFFFAFAFA),
              borderRadius: BorderRadius.circular(AppDimens.radiusMd),
              border: Border.all(color: AppColors.border),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedUnit,
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.hint),
                items: ['KG', 'Rolls', 'Pieces', 'Hours', 'Set', 'Days']
                    .map((u) => DropdownMenuItem(
                          value: u,
                          child: Text(
                            u,
                            style: GoogleFonts.publicSans(
                              color: AppColors.textPrimary,
                              fontSize: 13,
                            ),
                          ),
                        ))
                    .toList(),
                onChanged: (val) {
                  if (val != null) setState(() => selectedUnit = val);
                },
              ),
            ),
          ),
          const SizedBox(height: AppDimens.paddingXxl),

          // Buttons
          Row(
            children: [
              Expanded(
                child: AppButton(
                  text: AppStrings.cancel,
                  isOutlined: true,
                  hasShadow: false,
                  textColor: AppColors.primary,
                  backgroundColor: AppColors.border,
                  onPressed: () => Get.back(),
                  borderRadius: AppDimens.radiusMd,
                  height: 48,
                ),
              ),
              const SizedBox(width: AppDimens.paddingMd),
              Expanded(
                child: AppButton(
                  text: AppStrings.saveChanges,
                  onPressed: () {
                    Get.back();
                    Get.snackbar(
                      'Success',
                      'Item added successfully',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: AppColors.primary,
                      colorText: AppColors.white,
                      margin: const EdgeInsets.all(16),
                      duration: const Duration(seconds: 2),
                    );
                  },
                  borderRadius: AppDimens.radiusMd,
                  height: 48,
                  hasShadow: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildFieldLabel(String text, {bool isRequired = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimens.paddingXs),
      child: RichText(
        text: TextSpan(
          text: text,
          style: GoogleFonts.publicSans(
            color: AppColors.textPrimary,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
          children: isRequired
              ? [
                  const TextSpan(
                    text: ' *',
                    style: TextStyle(color: AppColors.error, fontWeight: FontWeight.bold),
                  )
                ]
              : [],
        ),
      ),
    );
  }
}
