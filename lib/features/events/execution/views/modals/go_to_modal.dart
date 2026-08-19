import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_dimens.dart';
import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/routes/app_routes.dart';

class GoToModal extends StatelessWidget {
  const GoToModal({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const GoToModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.88,
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          // Drag handle
          Container(
            width: 44,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFFE2E8F0),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 12),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingLg),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.selectModule,
                        style: GoogleFonts.publicSans(
                          color: AppColors.textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        AppStrings.chooseSectionToManage,
                        style: GoogleFonts.publicSans(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF1F5F9),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.close, size: 18, color: AppColors.textSecondary),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: AppColors.border),

          // Body Scrollable
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppDimens.paddingLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Client Module Header
                  Text(
                    AppStrings.clientModuleUpper,
                    style: GoogleFonts.publicSans(
                      color: AppColors.primary.withValues(alpha: 0.8),
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Client Module 1: Edit Details
                  _buildClientModuleTile(
                    icon: Icons.edit_note_outlined,
                    iconBg: const Color(0xFFF8FAFC),
                    iconColor: AppColors.textPrimary,
                    title: AppStrings.editDetails,
                    subtitle: AppStrings.modifyEventInfo,
                    onTap: () {
                      Get.back();
                      Get.toNamed(AppRoutes.createEvent);
                    },
                  ),
                  const SizedBox(height: 8),

                  // Client Module 2: Estimate (Active state)
                  _buildClientModuleTile(
                    icon: Icons.description,
                    iconBg: AppColors.primary,
                    iconColor: AppColors.white,
                    title: AppStrings.estimate,
                    subtitle: AppStrings.manageQuotesBilling,
                    hasActiveDot: true,
                    borderColor: AppColors.primary.withValues(alpha: 0.3),
                    onTap: () {
                      Get.back();
                      Get.toNamed(AppRoutes.quotation);
                    },
                  ),
                  const SizedBox(height: 8),

                  // Client Module 3: Execution
                  _buildClientModuleTile(
                    icon: Icons.play_circle_outline,
                    iconBg: const Color(0xFFF8FAFC),
                    iconColor: AppColors.textPrimary,
                    title: AppStrings.execution,
                    subtitle: AppStrings.trackEventProgress,
                    onTap: () {
                      Get.back();
                    },
                  ),
                  const SizedBox(height: 20),

                  // Execution Modules Header with Badge
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.executionModulesUpper,
                        style: GoogleFonts.publicSans(
                          color: AppColors.primary.withValues(alpha: 0.8),
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.primaryTint,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          AppStrings.fourteenItems,
                          style: GoogleFonts.publicSans(
                            color: AppColors.primary,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // 14 Execution Modules 2-Column Grid
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 2.1,
                    children: [
                      // 1. Flower -> Navigates to Screen 3 (Item Details)
                      _buildGridModule(
                        icon: Icons.local_florist_outlined,
                        label: AppStrings.flower,
                        onTap: () {
                          Get.back();
                          Get.toNamed(
                            AppRoutes.itemDetails,
                            arguments: {'title': 'Flowers & Props'},
                          );
                        },
                      ),
                      // 2. Lighting -> Navigates to Screen 3 (Decorative Lighting Details)
                      _buildGridModule(
                        icon: Icons.lightbulb_outline,
                        label: AppStrings.lighting,
                        onTap: () {
                          Get.back();
                          Get.toNamed(
                            AppRoutes.itemDetails,
                            arguments: {'title': 'Decorative Lighting'},
                          );
                        },
                      ),
                      _buildGridModule(
                        icon: Icons.tv,
                        label: AppStrings.ledWall,
                        onTap: () {
                          Get.back();
                          Get.toNamed(
                            AppRoutes.itemDetails,
                            arguments: {'title': 'LED Wall Setup'},
                          );
                        },
                      ),
                      _buildGridModule(
                        icon: Icons.speaker_outlined,
                        label: AppStrings.sound,
                        onTap: () {
                          Get.back();
                          Get.toNamed(
                            AppRoutes.itemDetails,
                            arguments: {'title': 'Sound System'},
                          );
                        },
                      ),
                      _buildGridModule(
                        icon: Icons.holiday_village_outlined,
                        label: AppStrings.mandap,
                        onTap: () {
                          Get.back();
                          Get.toNamed(
                            AppRoutes.itemDetails,
                            arguments: {'title': 'Mandap Decoration'},
                          );
                        },
                      ),
                      _buildGridModule(
                        icon: Icons.chair_outlined,
                        label: AppStrings.furniture,
                        onTap: () {
                          Get.back();
                          Get.toNamed(
                            AppRoutes.itemDetails,
                            arguments: {'title': 'Furniture Layout'},
                          );
                        },
                      ),
                      _buildGridModule(
                        icon: Icons.print_outlined,
                        label: AppStrings.printing,
                        onTap: () {
                          Get.back();
                          Get.toNamed(
                            AppRoutes.itemDetails,
                            arguments: {'title': 'Printing & Signage'},
                          );
                        },
                      ),
                      _buildGridModule(
                        icon: Icons.celebration_outlined,
                        label: AppStrings.sfx,
                        onTap: () {
                          Get.back();
                          Get.toNamed(
                            AppRoutes.itemDetails,
                            arguments: {'title': 'SFX & Pyro'},
                          );
                        },
                      ),
                      _buildGridModule(
                        icon: Icons.shopping_bag_outlined,
                        label: AppStrings.purchaseItem,
                        onTap: () {
                          Get.back();
                          Get.toNamed(
                            AppRoutes.itemDetails,
                            arguments: {'title': 'Purchase Items'},
                          );
                        },
                      ),
                      _buildGridModule(
                        icon: Icons.warehouse_outlined,
                        label: AppStrings.godown,
                        onTap: () {
                          Get.back();
                          Get.toNamed(
                            AppRoutes.itemDetails,
                            arguments: {'title': 'Godown Inventory'},
                          );
                        },
                      ),
                      _buildGridModule(
                        icon: Icons.queue_music_outlined,
                        label: AppStrings.artistAndEnt,
                        onTap: () {
                          Get.back();
                          Get.toNamed(
                            AppRoutes.itemDetails,
                            arguments: {'title': 'Artist & Entertainment'},
                          );
                        },
                      ),
                      _buildGridModule(
                        icon: Icons.storefront_outlined,
                        label: AppStrings.outsource,
                        onTap: () {
                          Get.back();
                          Get.toNamed(
                            AppRoutes.itemDetails,
                            arguments: {'title': 'Outsourced Vendors'},
                          );
                        },
                      ),
                      _buildGridModule(
                        icon: Icons.handyman_outlined,
                        label: AppStrings.newMaking,
                        onTap: () {
                          Get.back();
                          Get.toNamed(
                            AppRoutes.itemDetails,
                            arguments: {'title': 'New Making Fabrications'},
                          );
                        },
                      ),
                      _buildGridModule(
                        icon: Icons.groups_outlined,
                        label: AppStrings.labour,
                        onTap: () {
                          Get.back();
                          Get.toNamed(
                            AppRoutes.itemDetails,
                            arguments: {'title': 'Labour & Crew'},
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClientModuleTile({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool hasActiveDot = false,
    Color? borderColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: borderColor ?? AppColors.border, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.publicSans(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: GoogleFonts.publicSans(
                      color: AppColors.textSecondary,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            if (hasActiveDot) ...[
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
            ],
            const Icon(Icons.chevron_right, size: 18, color: AppColors.hint),
          ],
        ),
      ),
    );
  }

  Widget _buildGridModule({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border, width: 1),
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
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.primaryTint,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 16, color: AppColors.primary),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.publicSans(
                  color: AppColors.textPrimary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
