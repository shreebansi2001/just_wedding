import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_dimens.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../domain/models/event_dtos.dart';
import '../../controllers/event_wizard_controller.dart';
import 'wizard_progress_bar.dart';

class Step3FunctionDetailsView extends GetView<EventWizardController> {
  const Step3FunctionDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const WizardProgressBar(
          currentStep: 3,
          totalSteps: 4,
          title: AppStrings.functionDetails,
        ),
        const SizedBox(height: AppDimens.paddingLg),
        AppTextField(
          hintText: AppStrings.searchFunctions,
          prefixIcon: const Icon(Icons.search, color: AppColors.hint, size: 20),
          onChanged: (value) => controller.functionSearchQuery.value = value,
        ),
        const SizedBox(height: AppDimens.paddingMd),
        AppButton(
          text: '+ Add Function',
          onPressed: controller.addFunctionRow,
          borderRadius: AppDimens.radiusMd,
          height: 48,
          hasShadow: true,
        ),
        const SizedBox(height: AppDimens.paddingLg),
        Obx(() {
          final query = controller.functionSearchQuery.value
              .trim()
              .toLowerCase();
          final filtered = query.isEmpty
              ? controller.functions
              : controller.functions
                    .where((f) => f.name.toLowerCase().contains(query))
                    .toList();

          if (filtered.isEmpty) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppDimens.paddingXl,
              ),
              child: Center(
                child: Text(
                  controller.functions.isEmpty
                      ? 'No functions added yet. Tap "+ Add Function" to add one.'
                      : 'No functions match your search.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.publicSans(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                  ),
                ),
              ),
            );
          }

          return Column(
            children: filtered
                .map(
                  (entry) => Padding(
                    padding: const EdgeInsets.only(bottom: AppDimens.paddingMd),
                    child: _buildFunctionCard(context, entry),
                  ),
                )
                .toList(),
          );
        }),
        const SizedBox(height: AppDimens.paddingXxl),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: AppButton(
                text: AppStrings.cancel,
                isOutlined: true,
                hasShadow: false,
                textColor: AppColors.primary,
                backgroundColor: AppColors.border,
                onPressed: controller.previousStep,
                borderRadius: AppDimens.radiusMd,
                height: 48,
              ),
            ),
            const SizedBox(width: AppDimens.paddingMd),
            Expanded(
              flex: 2,
              child: AppButton(
                text: AppStrings.continueToOther,
                onPressed: controller.nextStep,
                borderRadius: AppDimens.radiusMd,
                height: 48,
                hasShadow: true,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimens.paddingXxl),
      ],
    );
  }

  Widget _buildFunctionCard(BuildContext context, FunctionEntry entry) {
    return Obx(() {
      // Reads controller.functions so this card rebuilds whenever any row is
      // mutated in place (functions.refresh()), since FunctionEntry itself isn't reactive.
      // ignore: unused_local_variable
      final _ = controller.functions.length;

      final venue = controller.venues.firstWhereOrNull(
        (v) => v.id == entry.venueId,
      );
      final subVenueNames = entry.subVenueIds
          .map(
            (id) => venue?.subVenues
                .firstWhereOrNull((sv) => sv.id == id)
                ?.nameEnglish,
          )
          .whereType<String>()
          .join(', ');

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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header: function type + notes/delete actions
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildIconLabel(
                        Icons.celebration_outlined,
                        'Function Type *',
                      ),
                      const SizedBox(height: 4),
                      PopupMenuButton<int>(
                        onSelected: (id) =>
                            controller.selectFunctionType(entry, id),
                        itemBuilder: (context) => controller.functionTypes
                            .map(
                              (t) => PopupMenuItem(
                                value: t.id,
                                child: Text(t.nameEnglish ?? ''),
                              ),
                            )
                            .toList(),
                        child: _buildDisplayField(
                          text: entry.name,
                          hint: 'Select function type...',
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.chat_bubble_outline,
                    size: 18,
                    color: entry.notesEnglish.isEmpty
                        ? AppColors.hint
                        : AppColors.primary,
                  ),
                  tooltip: entry.notesEnglish.isEmpty
                      ? 'Add notes'
                      : 'Edit notes',
                  onPressed: () => _showNotesDialog(context, entry),
                  constraints: const BoxConstraints(),
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete_outline,
                    size: 18,
                    color: AppColors.error,
                  ),
                  tooltip: 'Remove function',
                  onPressed: () => controller.removeFunctionRow(entry),
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
            const SizedBox(height: AppDimens.paddingMd),

            // Date & Time
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildIconLabel(
                        Icons.calendar_today_outlined,
                        '${AppStrings.date} *',
                      ),
                      const SizedBox(height: 4),
                      GestureDetector(
                        onTap: () =>
                            controller.pickFunctionDate(context, entry),
                        child: _buildDisplayField(
                          text: entry.date,
                          hint: 'mm/dd/yyyy',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppDimens.paddingMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildIconLabel(
                        Icons.access_time,
                        '${AppStrings.time} *',
                      ),
                      const SizedBox(height: 4),
                      GestureDetector(
                        onTap: () =>
                            controller.pickFunctionTime(context, entry),
                        child: _buildDisplayField(
                          text: entry.time,
                          hint: '--:-- --',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimens.paddingMd),

            // Venue
            _buildIconLabel(
              Icons.location_on_outlined,
              '${AppStrings.venue} *',
            ),
            const SizedBox(height: 4),
            PopupMenuButton<int>(
              onSelected: (id) => controller.selectFunctionVenue(entry, id),
              itemBuilder: (context) => controller.venues
                  .map(
                    (v) => PopupMenuItem(
                      value: v.id,
                      child: Text(v.nameEnglish ?? ''),
                    ),
                  )
                  .toList(),
              child: _buildDisplayField(
                text: entry.venue,
                hint: 'Search or select a venue...',
              ),
            ),
            const SizedBox(height: AppDimens.paddingMd),

            // Sub Venue - multi-select, disabled until a venue is chosen
            _buildIconLabel(
              Icons.door_front_door_outlined,
              AppStrings.subVenue,
            ),
            const SizedBox(height: 4),
            GestureDetector(
              onTap: (venue == null || venue.subVenues.isEmpty)
                  ? null
                  : () => _showSubVenuePicker(context, entry, venue),
              child: _buildDisplayField(
                text: subVenueNames.isEmpty ? null : subVenueNames,
                hint: venue == null
                    ? 'Select a venue first'
                    : 'Select sub venue(s)...',
                disabled: venue == null || venue.subVenues.isEmpty,
              ),
            ),
          ],
        ),
      );
    });
  }

  void _showNotesDialog(BuildContext context, FunctionEntry entry) {
    final notesController = TextEditingController(text: entry.notesEnglish);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Notes'),
        content: AppTextField(
          controller: notesController,
          hintText: 'Add a note for this function...',
          maxLines: 4,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              controller.updateFunctionNotes(
                entry,
                notesController.text.trim(),
              );
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showSubVenuePicker(
    BuildContext context,
    FunctionEntry entry,
    VenueResponseDto venue,
  ) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(AppDimens.paddingMd),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Select Sub Venue(s)',
                      style: GoogleFonts.publicSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: AppDimens.paddingSm),
                    ...venue.subVenues.map(
                      (sv) => CheckboxListTile(
                        value: entry.subVenueIds.contains(sv.id),
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                        title: Text(sv.nameEnglish ?? ''),
                        onChanged: (_) {
                          controller.toggleSubVenue(entry, sv.id);
                          setModalState(() {});
                        },
                      ),
                    ),
                    const SizedBox(height: AppDimens.paddingMd),
                    AppButton(
                      text: 'Done',
                      onPressed: () => Navigator.pop(context),
                      height: 44,
                      borderRadius: AppDimens.radiusMd,
                      hasShadow: true,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDisplayField({
    required String? text,
    required String hint,
    bool disabled = false,
  }) {
    final isEmpty = text == null || text.isEmpty;
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: disabled
            ? AppColors.border.withValues(alpha: 0.3)
            : AppColors.white,
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              isEmpty ? hint : text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.publicSans(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isEmpty ? AppColors.hint : AppColors.textPrimary,
              ),
            ),
          ),
          const Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.hint,
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildIconLabel(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: AppColors.textSecondary),
        const SizedBox(width: 4),
        Text(
          text,
          style: GoogleFonts.publicSans(
            color: AppColors.textSecondary,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
