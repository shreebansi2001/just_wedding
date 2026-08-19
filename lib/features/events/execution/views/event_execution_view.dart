import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_page_container.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../controllers/event_execution_controller.dart';
import 'modals/add_item_modal.dart';
import 'modals/events_list_modal.dart';
import 'modals/go_to_modal.dart';

class EventExecutionView extends GetView<EventExecutionController> {
  const EventExecutionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Get.back(),
        ),
        title: Text(
          AppStrings.eventFlower,
          style: GoogleFonts.publicSans(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: AppColors.textPrimary),
            onPressed: () => EventsListModal.show(context),
          ),
        ],
      ),
      body: SafeArea(
        child: AppPageContainer(
          maxWidth: 600,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppDimens.paddingLg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. Header Event Card
                _buildHeaderEventCard(context),
                const SizedBox(height: AppDimens.paddingMd),

                // 2. Action Buttons Row (Save, Print, Total, Status, Present, Go To)
                _buildActionButtonsBar(context),
                const SizedBox(height: AppDimens.paddingLg),

                // 3. Execution Details Section
                _buildExecutionDetailsSection(),
                const SizedBox(height: AppDimens.paddingMd),

                // 4. Setup & Dismantle Row
                _buildSetupDismantleRow(),
                const SizedBox(height: AppDimens.paddingLg),

                // 5. Gala Dinner Section (Dropdown, Search, Add buttons)
                _buildGalaDinnerHeader(context),
                const SizedBox(height: AppDimens.paddingMd),

                // 6. List of Items (Flowers & Props, Decorative Lighting, Floral Centerpieces)
                _buildItemsList(),
                const SizedBox(height: AppDimens.paddingXxl),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderEventCard(BuildContext context) {
    return GestureDetector(
      onTap: () => EventsListModal.show(context),
      child: Container(
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
            // Top gradient line
            Container(
              height: 3,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppDimens.paddingMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Badges Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          AppStrings.eventCodeSample,
                          style: GoogleFonts.publicSans(
                            color: AppColors.textSecondary,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF2F2),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: const Color(0xFFFCA5A5), width: 0.5),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: Color(0xFFEF4444),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              AppStrings.live,
                              style: GoogleFonts.publicSans(
                                color: const Color(0xFFEF4444),
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Event Title & Company
                  Text(
                    AppStrings.globalTechSummit,
                    style: GoogleFonts.publicSans(
                      color: AppColors.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    AppStrings.acmeCorpInternational,
                    style: GoogleFonts.publicSans(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Location & Date Pink Container
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFDF4F7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.location_on_outlined, size: 14, color: AppColors.primary),
                            const SizedBox(width: 6),
                            Text(
                              AppStrings.grandHorizonCenter,
                              style: GoogleFonts.publicSans(
                                color: AppColors.textPrimary,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.calendar_today_outlined, size: 14, color: AppColors.primary),
                            const SizedBox(width: 6),
                            Text(
                              AppStrings.sampleEventDates,
                              style: GoogleFonts.publicSans(
                                color: AppColors.textSecondary,
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtonsBar(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          // 1. Save (Active Maroon)
          _buildActionButton(
            icon: Icons.save_outlined,
            label: AppStrings.save,
            isFilled: true,
            onTap: () {
              Get.snackbar(
                'Saved',
                'Execution details saved successfully',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: AppColors.primary,
                colorText: AppColors.white,
                margin: const EdgeInsets.all(16),
                duration: const Duration(seconds: 2),
              );
            },
          ),
          const SizedBox(width: 8),

          // 2. Print
          _buildActionButton(
            icon: Icons.print_outlined,
            label: AppStrings.print,
            onTap: () {},
          ),
          const SizedBox(width: 8),

          // 3. Total
          _buildActionButton(
            icon: Icons.functions,
            label: AppStrings.total,
            onTap: () {},
          ),
          const SizedBox(width: 8),

          // 4. Status
          _buildActionButton(
            icon: Icons.pie_chart_outline,
            label: AppStrings.status,
            onTap: () {},
          ),
          const SizedBox(width: 8),

          // 5. Present
          _buildActionButton(
            icon: Icons.play_arrow_outlined,
            label: AppStrings.present,
            onTap: () {},
          ),
          const SizedBox(width: 8),

          // 6. Go To -> OPENS SCREEN 2 (GoToModal)
          _buildActionButton(
            icon: Icons.explore_outlined,
            label: AppStrings.goTo,
            onTap: () => GoToModal.show(context),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isFilled = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 54,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isFilled ? AppColors.primary : AppColors.white,
          borderRadius: BorderRadius.circular(10),
          border: isFilled ? null : Border.all(color: AppColors.border),
          boxShadow: isFilled
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 18,
              color: isFilled ? AppColors.white : AppColors.textPrimary,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.publicSans(
                color: isFilled ? AppColors.white : AppColors.textPrimary,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExecutionDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.executionDetails,
          style: GoogleFonts.publicSans(
            color: AppColors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        Container(
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
              _buildFieldLabel(AppStrings.referenceUpper),
              AppTextField(
                hintText: AppStrings.enterReference,
                controller: controller.referenceController,
              ),
              const SizedBox(height: AppDimens.paddingMd),

              _buildFieldLabel(AppStrings.productionInchargeUpper),
              Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                  border: Border.all(color: AppColors.border),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: 'Select Incharge',
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.hint),
                    items: ['Select Incharge', 'Rahul Sharma', 'Ankit Verma', 'Vikram Patel']
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e, style: GoogleFonts.publicSans(fontSize: 13, color: AppColors.textPrimary)),
                            ))
                        .toList(),
                    onChanged: (val) {},
                  ),
                ),
              ),
              const SizedBox(height: AppDimens.paddingMd),

              _buildFieldLabel(AppStrings.noteUpper),
              AppTextField(
                hintText: AppStrings.addSpecialRemarks,
                controller: controller.noteController,
                maxLines: 3,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSetupDismantleRow() {
    return Row(
      children: [
        // SETUP Card
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(AppDimens.paddingMd),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border, width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFieldLabel(AppStrings.setupUpper),
                const AppTextField(
                  hintText: 'mm/dd/yyyy',
                  prefixIcon: Icon(Icons.calendar_today_outlined, size: 16, color: AppColors.primary),
                ),
                const SizedBox(height: 8),
                const AppTextField(
                  hintText: '--:-- --',
                  prefixIcon: Icon(Icons.access_time, size: 16, color: AppColors.primary),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: AppDimens.paddingMd),

        // DISMANTLE Card
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(AppDimens.paddingMd),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border, width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFieldLabel(AppStrings.dismantleUpper),
                const AppTextField(
                  hintText: 'mm/dd/yyyy',
                  prefixIcon: Icon(Icons.calendar_today_outlined, size: 16, color: AppColors.primary),
                ),
                const SizedBox(height: 8),
                const AppTextField(
                  hintText: '--:-- --',
                  prefixIcon: Icon(Icons.access_time, size: 16, color: AppColors.primary),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGalaDinnerHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingMd),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Column(
        children: [
          // Dropdown Row: "Gala Dinner"
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.galaDinner,
                style: GoogleFonts.publicSans(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary),
            ],
          ),
          const SizedBox(height: 12),

          // Search Items + Filter Row
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  hintText: AppStrings.searchItems,
                  prefixIcon: const Icon(Icons.search, size: 18, color: AppColors.hint),
                  controller: controller.searchItemController,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.circular(AppDimens.radiusMd),
                  border: Border.all(color: AppColors.border),
                ),
                child: const Icon(Icons.tune, color: AppColors.textSecondary, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Action Buttons: + Add & + Add Item
          Row(
            children: [
              Expanded(
                flex: 1,
                child: AppButton(
                  text: '+ Add',
                  isOutlined: true,
                  hasShadow: false,
                  textColor: AppColors.primary,
                  backgroundColor: AppColors.border,
                  onPressed: () => AddItemModal.show(context),
                  borderRadius: AppDimens.radiusMd,
                  height: 42,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: AppButton(
                  text: '+ Add Item',
                  onPressed: () => AddItemModal.show(context),
                  borderRadius: AppDimens.radiusMd,
                  height: 42,
                  hasShadow: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildItemsList() {
    return Obx(() {
      return Column(
        children: List.generate(controller.items.length, (index) {
          final item = controller.items[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: _buildExecutionItemCard(index, item),
          );
        }),
      );
    });
  }

  Widget _buildExecutionItemCard(int index, ExecutionItem item) {
    return GestureDetector(
      onTap: () => controller.navigateToItemDetails(itemName: item.title),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: item.isExpanded ? AppColors.primary.withValues(alpha: 0.4) : AppColors.border,
            width: item.isExpanded ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (item.isExpanded)
                Container(
                  width: 4,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                  ),
                ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(AppDimens.paddingMd),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Row
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.title,
                              style: GoogleFonts.publicSans(
                                color: item.isExpanded ? AppColors.primary : AppColors.textPrimary,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => controller.navigateToItemDetails(itemName: item.title),
                            child: const Icon(Icons.edit_outlined, size: 16, color: AppColors.hint),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.delete_outline, size: 16, color: AppColors.hint),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () => controller.toggleItemExpansion(index),
                            child: Icon(
                              item.isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                              size: 18,
                              color: AppColors.hint,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.vendor,
                        style: GoogleFonts.publicSans(
                          color: AppColors.textSecondary,
                          fontSize: 11,
                        ),
                      ),

                      // Expanded details
                      if (item.isExpanded && item.description != null) ...[
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.description!,
                                style: GoogleFonts.publicSans(
                                  color: AppColors.textSecondary,
                                  fontSize: 11,
                                  height: 1.4,
                                ),
                              ),
                              if (item.tags.isNotEmpty) ...[
                                const SizedBox(height: 8),
                                Wrap(
                                  spacing: 6,
                                  children: item.tags.map((tag) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFE2E8F0),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        tag,
                                        style: GoogleFonts.publicSans(
                                          color: AppColors.textSecondary,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],

                      const SizedBox(height: 10),
                      // QTY, RATE, TOTAL Row
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppStrings.qtyUpper,
                                style: GoogleFonts.publicSans(color: AppColors.hint, fontSize: 9, fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '${item.qty}',
                                style: GoogleFonts.publicSans(color: AppColors.textPrimary, fontSize: 13, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          const SizedBox(width: 24),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppStrings.rateUpper,
                                style: GoogleFonts.publicSans(color: AppColors.hint, fontSize: 9, fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '₹${item.rate.toInt()}',
                                style: GoogleFonts.publicSans(color: AppColors.textPrimary, fontSize: 13, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                AppStrings.totalUpper,
                                style: GoogleFonts.publicSans(color: AppColors.hint, fontSize: 9, fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '₹${item.total.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                                style: GoogleFonts.publicSans(color: AppColors.primary, fontSize: 15, fontWeight: FontWeight.w800),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimens.paddingXs),
      child: Text(
        text,
        style: GoogleFonts.publicSans(
          color: AppColors.textSecondary,
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
