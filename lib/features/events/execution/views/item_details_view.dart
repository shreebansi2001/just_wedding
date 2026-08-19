import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_page_container.dart';
import '../../../../core/widgets/app_text_field.dart';

class ItemDetailsView extends StatefulWidget {
  const ItemDetailsView({super.key});

  @override
  State<ItemDetailsView> createState() => _ItemDetailsViewState();
}

class _ItemDetailsViewState extends State<ItemDetailsView> {
  late String screenTitle;

  final itemNameController = TextEditingController(text: 'Decorative Lighting');
  final descriptionController = TextEditingController(text: 'Warm white LED fairy lights, 10m rolls');
  final basePriceController = TextEditingController(text: '150');
  final totalQtyController = TextEditingController(text: '50');
  final noteController = TextEditingController();

  String selectedVendor = 'Lumina Events';
  String selectedUnit = 'Rolls';

  final placements = [
    {'name': 'Welcome Board', 'qty': 5},
    {'name': 'Entry Gate', 'qty': 20},
    {'name': 'Props', 'qty': 10},
    {'name': 'Artiste Stage Platform', 'qty': 15},
  ];

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>?;
    screenTitle = args?['title'] ?? 'Decorative Lighting';
    if (args?['title'] != null) {
      itemNameController.text = args!['title'];
    }
  }

  @override
  void dispose() {
    itemNameController.dispose();
    descriptionController.dispose();
    basePriceController.dispose();
    totalQtyController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => Get.back(),
        ),
        title: Text(
          screenTitle,
          style: GoogleFonts.publicSans(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: AppPageContainer(
          maxWidth: 600,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppDimens.paddingLg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. ITEM DETAILS Card
                _buildItemDetailsCard(),
                const SizedBox(height: AppDimens.paddingLg),

                // 2. PLACEMENT (ITEMS) Card
                _buildPlacementCard(),
                const SizedBox(height: AppDimens.paddingLg),

                // 3. REFERENCE IMAGE Card
                _buildReferenceImageCard(),
                const SizedBox(height: AppDimens.paddingLg),

                // 4. Send SMS Update Button
                AppButton(
                  text: '✉  ${AppStrings.sendSmsUpdate}',
                  isOutlined: true,
                  hasShadow: false,
                  textColor: AppColors.textPrimary,
                  backgroundColor: AppColors.border,
                  onPressed: () {
                    Get.snackbar(
                      'SMS Sent',
                      'Vendor has been notified via SMS',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: AppColors.primary,
                      colorText: AppColors.white,
                      margin: const EdgeInsets.all(16),
                      duration: const Duration(seconds: 2),
                    );
                  },
                  borderRadius: AppDimens.radiusMd,
                  height: 48,
                ),
                const SizedBox(height: AppDimens.paddingXxl),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItemDetailsCard() {
    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingMd),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.itemDetailsUpper,
            style: GoogleFonts.publicSans(
              color: AppColors.textSecondary,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: AppDimens.paddingMd),

          _buildFieldLabel(AppStrings.itemNameUpper),
          AppTextField(
            hintText: 'Enter item name',
            controller: itemNameController,
          ),
          const SizedBox(height: AppDimens.paddingMd),

          _buildFieldLabel(AppStrings.descriptionUpper),
          AppTextField(
            hintText: 'Enter description',
            controller: descriptionController,
            maxLines: 2,
          ),
          const SizedBox(height: AppDimens.paddingMd),

          // Vendor & Unit Row
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel(AppStrings.vendorUpper),
                    _buildDropdown(
                      value: selectedVendor,
                      items: ['Lumina Events', 'Vishal Bhai', 'Grand Decorators', 'Royal Lights'],
                      onChanged: (val) => setState(() => selectedVendor = val!),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppDimens.paddingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel(AppStrings.unitUpper),
                    _buildDropdown(
                      value: selectedUnit,
                      items: ['Rolls', 'Pieces', 'Sets', 'KG', 'Hours'],
                      onChanged: (val) => setState(() => selectedUnit = val!),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.paddingMd),

          // Date & Time Row
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel(AppStrings.dateUpper),
                    const AppTextField(
                      hintText: 'mm/dd/yyyy',
                      prefixIcon: Icon(Icons.calendar_today_outlined, size: 18, color: AppColors.hint),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppDimens.paddingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel(AppStrings.timeUpper),
                    const AppTextField(
                      hintText: '--:-- --',
                      prefixIcon: Icon(Icons.access_time, size: 18, color: AppColors.hint),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.paddingMd),

          // Base Price & Total Qty Row
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel(AppStrings.basePriceUpper),
                    AppTextField(
                      hintText: '0',
                      controller: basePriceController,
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppDimens.paddingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel(AppStrings.totalQtyUpper),
                    AppTextField(
                      hintText: '0',
                      controller: totalQtyController,
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.paddingMd),

          _buildFieldLabel(AppStrings.noteUpper),
          AppTextField(
            hintText: AppStrings.addSpecialRemarks,
            controller: noteController,
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildPlacementCard() {
    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingMd),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.placementItemsUpper,
            style: GoogleFonts.publicSans(
              color: AppColors.textSecondary,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: AppDimens.paddingMd),

          ...placements.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      item['name'] as String,
                      style: GoogleFonts.publicSans(
                        color: AppColors.textPrimary,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    width: 48,
                    height: 32,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFAFAFA),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Text(
                      '${item['qty']}',
                      style: GoogleFonts.publicSans(
                        color: AppColors.textPrimary,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.info_outline, size: 18, color: AppColors.hint),
                ],
              ),
            );
          }),

          const SizedBox(height: 8),
          const Divider(height: 1, color: AppColors.border),
          const SizedBox(height: 12),

          // Allocated Total & Total Amount Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.allocatedTotalUpper,
                    style: GoogleFonts.publicSans(
                      color: AppColors.textSecondary,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '50 Rolls',
                    style: GoogleFonts.publicSans(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    AppStrings.totalUpper,
                    style: GoogleFonts.publicSans(
                      color: AppColors.textSecondary,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '₹7,500',
                    style: GoogleFonts.publicSans(
                      color: AppColors.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReferenceImageCard() {
    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingMd),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.referenceImageUpper,
            style: GoogleFonts.publicSans(
              color: AppColors.textSecondary,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: AppDimens.paddingMd),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24),
            decoration: BoxDecoration(
              color: const Color(0xFFFAFAFA),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.border,
                style: BorderStyle.solid,
              ),
            ),
            child: Column(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF1F5F9),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.hide_image_outlined, size: 22, color: AppColors.hint),
                ),
                const SizedBox(height: 8),
                Text(
                  AppStrings.noImageUploaded,
                  style: GoogleFonts.publicSans(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.primary),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  child: Text(
                    AppStrings.changeImage,
                    style: GoogleFonts.publicSans(
                      color: AppColors.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFieldLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimens.paddingXs),
      child: Text(
        text,
        style: GoogleFonts.publicSans(
          color: AppColors.textPrimary,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        border: Border.all(color: AppColors.border),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.hint),
          items: items.map((e) => DropdownMenuItem(
                value: e,
                child: Text(e, style: GoogleFonts.publicSans(fontSize: 13, color: AppColors.textPrimary)),
              )).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
