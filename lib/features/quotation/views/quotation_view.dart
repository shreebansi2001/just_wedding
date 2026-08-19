import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_dropdown.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/app_page_container.dart';
import '../controllers/quotation_controller.dart';
import 'modals/function_summary_modal.dart';
import 'modals/quotation_update_history_modal.dart';
import 'modals/select_printing_option_modal.dart';

class QuotationView extends GetView<QuotationController> {
  const QuotationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: AppPageContainer(
          maxWidth: 600,
          child: Column(
            children: [
              _buildTopHeader(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildEventInfoCard(context),
                      const SizedBox(height: AppDimens.paddingLg),
                      _buildQuickAddItemsCard(),
                      const SizedBox(height: AppDimens.paddingLg),
                      _buildEstimateItemsSection(),
                      const SizedBox(height: AppDimens.paddingLg),
                      _buildFunctionSummaryBanner(context),
                      const SizedBox(height: AppDimens.paddingLg),
                      _buildEstimateSummaryCard(),
                      const SizedBox(height: AppDimens.paddingLg),
                      _buildPaymentDetailsCard(),
                      const SizedBox(height: AppDimens.paddingLg),
                      _buildNotesCard(),
                      const SizedBox(height: AppDimens.paddingXxl),
                      _buildBottomActions(context),
                      const SizedBox(height: AppDimens.paddingXxl),
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

  Widget _buildTopHeader() {
    return Padding(
      padding: const EdgeInsets.all(AppDimens.paddingLg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
            onPressed: () => Get.back(),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          Expanded(
            child: Column(
              children: [
                const Text(
                  AppStrings.newEstimate,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 2),
                const Text(
                  AppStrings.newEstimateSubtitle,
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage(
              'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=100&q=80',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventInfoCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingLg),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: AppColors.primaryLight,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.event_note, size: 16, color: AppColors.primary),
              ),
              const SizedBox(width: AppDimens.paddingSm),
              const Text(
                AppStrings.eventInformation,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.keyboard_arrow_up, color: AppColors.textSecondary),
                onPressed: controller.toggleEventInfo,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.paddingLg),
          _buildLabel(AppStrings.eventNo),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingMd, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(AppDimens.radiusMd),
            ),
            child: const Text(
              AppStrings.sampleEventNo,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const SizedBox(height: AppDimens.paddingMd),
          _buildLabel(AppStrings.eventName),
          const AppTextField(hintText: 'e.g. Royal Grand Wedding'),
          const SizedBox(height: AppDimens.paddingMd),
          _buildLabel(AppStrings.partyName),
          const AppTextField(hintText: AppStrings.partyNameHint),
          const SizedBox(height: AppDimens.paddingMd),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel(AppStrings.venue),
                    const AppTextField(hintText: AppStrings.venueLocationHint),
                  ],
                ),
              ),
              const SizedBox(width: AppDimens.paddingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel(AppStrings.estimateDate),
                    const AppTextField(
                      hintText: AppStrings.sampleEstimateDate,
                      suffixIcon: Icon(Icons.calendar_today_outlined, size: 18, color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.paddingMd),
          _buildLabel(AppStrings.approval),
          const AppTextField(
            hintText: AppStrings.completed,
            suffixIcon: Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppDimens.paddingMd),
          _buildLabel(AppStrings.functionName),
          const AppTextField(
            hintText: AppStrings.reception,
            suffixIcon: Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppDimens.paddingLg),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: AppColors.primaryLight,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.flash_on, size: 14, color: AppColors.primary),
              ),
              const SizedBox(width: AppDimens.paddingSm),
              const Text(
                AppStrings.actions,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const Spacer(),
              const Icon(Icons.info_outline, size: 16, color: AppColors.primary),
            ],
          ),
          const SizedBox(height: AppDimens.paddingMd),
          AppButton(
            text: AppStrings.eventExecution,
            onPressed: () {},
            borderRadius: AppDimens.radiusMd,
            icon: const Icon(Icons.calendar_month_outlined, color: AppColors.white, size: 16),
          ),
          const SizedBox(height: AppDimens.paddingSm),
          AppButton(
            text: AppStrings.otherEstimate,
            isOutlined: true,
            onPressed: () => QuotationUpdateHistoryModal.show(context),
            borderRadius: AppDimens.radiusMd,
            icon: const Icon(Icons.history_outlined, color: AppColors.primary, size: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAddItemsCard() {
    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingLg),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: AppColors.primaryLight,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.bolt, size: 16, color: AppColors.primary),
              ),
              const SizedBox(width: AppDimens.paddingSm),
              const Text(
                AppStrings.quickAddItems,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.paddingMd),
          const AppTextField(
            hintText: AppStrings.searchItemsDecorHint,
            prefixIcon: Icon(Icons.search, size: 18, color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppDimens.paddingMd),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  text: AppStrings.addItem,
                  isOutlined: true,
                  onPressed: () {},
                  borderRadius: AppDimens.radiusMd,
                  height: 48,
                ),
              ),
              const SizedBox(width: AppDimens.paddingMd),
              Expanded(
                child: AppButton(
                  text: AppStrings.generateItem,
                  onPressed: () {},
                  borderRadius: AppDimens.radiusMd,
                  height: 48,
                  icon: const Icon(Icons.auto_awesome, color: AppColors.white, size: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEstimateItemsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: AppColors.primaryLight,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.list_alt, size: 16, color: AppColors.primary),
            ),
            const SizedBox(width: AppDimens.paddingSm),
            const Text(
              AppStrings.estimateItems,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const Spacer(),
            Obx(() => Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '${controller.items.length} items added',
                style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
              ),
            )),
            const SizedBox(width: 8),
            const Text(
              AppStrings.clearAll,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.error,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimens.paddingMd),
        Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.items.isEmpty) {
            return const Text("No items added yet.", style: TextStyle(color: AppColors.textSecondary));
          }
          return Column(
            children: controller.items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: AppDimens.paddingMd),
              child: _buildItemCard(
                title: item.title,
                description: item.description,
                imageUrl: 'https://images.unsplash.com/photo-1519741497674-611481863552?auto=format&fit=crop&w=150&q=80',
                size: '25',
                qty: item.quantity.toString().padLeft(2, '0'),
                rate: '₹${item.rate.toStringAsFixed(0)}',
                discount: '10%',
                discRate: '₹${(item.rate * 0.9).toStringAsFixed(0)}',
                total: '₹${item.amount.toStringAsFixed(0)}',
              ),
            )).toList(),
          );
        }),
      ],
    );
  }

  Widget _buildItemCard({
    required String title,
    required String description,
    required String imageUrl,
    required String size,
    required String qty,
    required String rate,
    required String discount,
    required String discRate,
    required String total,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingMd),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.drag_indicator, size: 18, color: AppColors.primary),
              const SizedBox(width: 6),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      description,
                      style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  imageUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 50,
                    height: 50,
                    color: AppColors.primaryLight,
                    child: const Icon(Icons.image, size: 20, color: AppColors.primary),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.paddingMd),
          Row(
            children: [
              _buildMiniMetric('Size', size),
              _buildMiniMetric('Qty', qty),
              _buildMiniMetric('Rate', rate),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              _buildMiniMetric('Discount', discount),
              _buildMiniMetric('Disc. Rate', discRate),
              _buildMiniMetric('Total', total, isBoldTotal: true),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.edit_outlined, size: 16, color: AppColors.textSecondary),
                onPressed: () {},
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.symmetric(horizontal: 6),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, size: 16, color: AppColors.error),
                onPressed: () {},
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.symmetric(horizontal: 6),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiniMetric(String label, String value, {bool isBoldTotal = false}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 9, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isBoldTotal ? FontWeight.w800 : FontWeight.w600,
                color: isBoldTotal ? AppColors.primary : AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFunctionSummaryBanner(BuildContext context) {
    return GestureDetector(
      onTap: () => FunctionSummaryModal.show(context),
      child: Container(
        padding: const EdgeInsets.all(AppDimens.paddingMd),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppDimens.radiusMd),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: AppColors.primaryLight,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.receipt_long_outlined, size: 16, color: AppColors.primary),
            ),
            const SizedBox(width: AppDimens.paddingSm),
            const Text(
              AppStrings.functionSummary,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                Text(
                  'Total ₹',
                  style: TextStyle(fontSize: 10, color: AppColors.textSecondary),
                ),
                Text(
                  AppStrings.sampleFunctionSummaryTotal,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEstimateSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingLg),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: AppColors.primaryLight,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.calculate_outlined, size: 16, color: AppColors.primary),
              ),
              const SizedBox(width: AppDimens.paddingSm),
              const Text(
                AppStrings.estimateSummary,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const Spacer(),
              const Icon(Icons.keyboard_arrow_up, color: AppColors.textSecondary),
            ],
          ),
          const SizedBox(height: AppDimens.paddingLg),
          _buildSummaryRow(AppStrings.subtotal, '₹ ${AppStrings.sampleSubtotal}', isBold: true),
          const SizedBox(height: AppDimens.paddingSm),
          _buildSummaryRow(AppStrings.haldiDecoration, '₹ 45,000'),
          const SizedBox(height: AppDimens.paddingSm),
          _buildSummaryRow(AppStrings.receptionGala, '₹ 1,20,000'),
          const SizedBox(height: AppDimens.paddingMd),
          Row(
            children: [
              const Text(AppStrings.discount, style: TextStyle(fontSize: 13, color: AppColors.textPrimary)),
              const Spacer(),
              Container(
                width: 60,
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.border),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text('% 10', textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
              ),
              const SizedBox(width: 8),
              Container(
                width: 80,
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.border),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text('₹ 12,000', textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: AppDimens.paddingMd),
          _buildSummaryRow(AppStrings.amountAfterDiscount, '₹ ${AppStrings.sampleAmountAfterDiscount}', isBold: true),
          const SizedBox(height: AppDimens.paddingMd),
          const Divider(height: 1, color: AppColors.border),
          const SizedBox(height: AppDimens.paddingMd),
          _buildSummaryRow('${AppStrings.cgst} 9%', '₹ 24,300'),
          const SizedBox(height: AppDimens.paddingSm),
          _buildSummaryRow('${AppStrings.sgst} 9%', '₹ 24,300'),
          const SizedBox(height: AppDimens.paddingSm),
          _buildSummaryRow('${AppStrings.igst} 0%', '₹ 0'),
          const SizedBox(height: AppDimens.paddingMd),
          Container(
            padding: const EdgeInsets.all(AppDimens.paddingMd),
            decoration: BoxDecoration(
              color: const Color(0xFFF0FDF4),
              borderRadius: BorderRadius.circular(AppDimens.radiusSm),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(AppStrings.chequeAmt, style: TextStyle(fontSize: 12, color: Color(0xFF16A34A))),
                Text('₹ 0.00', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF16A34A))),
              ],
            ),
          ),
          const SizedBox(height: AppDimens.paddingMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                AppStrings.grandTotal,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                '₹ ${AppStrings.sampleGrandTotal}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
            color: isBold ? AppColors.textPrimary : AppColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isBold ? FontWeight.w800 : FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentDetailsCard() {
    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingLg),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: AppColors.primaryLight,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.payment, size: 16, color: AppColors.primary),
              ),
              const SizedBox(width: AppDimens.paddingSm),
              const Text(
                AppStrings.paymentDetails,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const Spacer(),
              const Icon(Icons.keyboard_arrow_up, color: AppColors.textSecondary),
            ],
          ),
          const SizedBox(height: AppDimens.paddingMd),
          AppButton(
            text: AppStrings.addAdvancePayment,
            onPressed: () {},
            borderRadius: AppDimens.radiusMd,
            height: 44,
          ),
          const SizedBox(height: AppDimens.paddingMd),
          Container(
            padding: const EdgeInsets.all(AppDimens.paddingMd),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(AppDimens.radiusMd),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.check_circle_outline, size: 16, color: Color(0xFF16A34A)),
                        SizedBox(width: 6),
                        Text(
                          AppStrings.advancePayment1,
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE5E7EB),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text('₹ 50000', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimens.paddingMd),
                _buildLabel(AppStrings.paymentMode),
                Obx(() => AppDropdown<String>(
                  hintText: AppStrings.paymentMode,
                  value: controller.paymentMode.value,
                  items: [
                    DropdownMenuItem(value: 'BANK_TRANSFER', child: Text(AppStrings.bankTransfer)),
                    DropdownMenuItem(value: 'UPI', child: Text(AppStrings.upi)),
                    DropdownMenuItem(value: 'CASH', child: Text(AppStrings.cash)),
                    DropdownMenuItem(value: 'CHEQUE', child: Text(AppStrings.cheque)),
                  ],
                  onChanged: (val) {
                    if (val != null) controller.paymentMode.value = val;
                  },
                )),
                const SizedBox(height: AppDimens.paddingMd),
                _buildLabel(AppStrings.paymentDateTime),
                const AppTextField(
                  hintText: AppStrings.samplePaymentDateTime,
                  suffixIcon: Icon(Icons.calendar_today_outlined, size: 16, color: AppColors.textSecondary),
                ),
                const SizedBox(height: AppDimens.paddingMd),
                _buildLabel(AppStrings.paymentDescription),
                const AppTextField(hintText: AppStrings.paymentDescHint),
                const SizedBox(height: AppDimens.paddingSm),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.delete_outline, size: 14, color: AppColors.error),
                    label: const Text(AppStrings.remove, style: TextStyle(fontSize: 12, color: AppColors.error)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimens.paddingMd),
          Container(
            padding: const EdgeInsets.all(AppDimens.paddingMd),
            decoration: BoxDecoration(
              color: const Color(0xFFF0FDF4),
              borderRadius: BorderRadius.circular(AppDimens.radiusSm),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(AppStrings.totalPaid, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF16A34A))),
                Text(AppStrings.sampleTotalPaid, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF16A34A))),
              ],
            ),
          ),
          const SizedBox(height: AppDimens.paddingSm),
          Container(
            padding: const EdgeInsets.all(AppDimens.paddingMd),
            decoration: BoxDecoration(
              color: const Color(0xFFFEF3C7),
              borderRadius: BorderRadius.circular(AppDimens.radiusSm),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(AppStrings.remainingPayment, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFFD97706))),
                Text(AppStrings.sampleRemainingPayment, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFD97706))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotesCard() {
    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingLg),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: AppColors.primaryLight,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.note_alt_outlined, size: 16, color: AppColors.primary),
              ),
              const SizedBox(width: AppDimens.paddingSm),
              const Text(
                AppStrings.notes,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const Spacer(),
              const Icon(Icons.keyboard_arrow_up, color: AppColors.textSecondary),
            ],
          ),
          const SizedBox(height: AppDimens.paddingMd),
          const AppTextField(
            hintText: AppStrings.addGeneralNotesHint,
            maxLines: 3,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: AppButton(
                text: AppStrings.cancel,
                isOutlined: true,
                onPressed: () => Get.back(),
                borderRadius: AppDimens.radiusMd,
              ),
            ),
            const SizedBox(width: AppDimens.paddingMd),
            Expanded(
              child: AppButton(
                text: AppStrings.saveDraft,
                isOutlined: true,
                onPressed: () => Get.back(),
                borderRadius: AppDimens.radiusMd,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimens.paddingMd),
        AppButton(
          text: AppStrings.downloadPdf,
          onPressed: () => SelectPrintingOptionModal.show(context),
          borderRadius: AppDimens.radiusMd,
          icon: const Icon(Icons.download_outlined, color: AppColors.white, size: 18),
        ),
        const SizedBox(height: AppDimens.paddingSm),
        AppButton(
          text: AppStrings.sendToClient,
          onPressed: () => Get.back(),
          borderRadius: AppDimens.radiusMd,
          icon: const Icon(Icons.send_outlined, color: AppColors.white, size: 18),
        ),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimens.paddingXs),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
