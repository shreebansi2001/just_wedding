import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/routes/app_routes.dart';

class AppSidebar extends StatelessWidget {
  const AppSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.background,
      child: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            const Divider(height: 1, color: AppColors.border),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: AppDimens.paddingMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle('EVENT'),
                    _buildNavItem(AppStrings.overview, Icons.dashboard_customize_rounded, isActive: true),
                    _buildNavItem(
                      AppStrings.addEvent,
                      Icons.add_circle_outline,
                      onTap: () {
                        Scaffold.of(context).closeDrawer();
                        Get.toNamed(AppRoutes.createEvent);
                      },
                    ),
                    _buildNavItem(AppStrings.guestList, Icons.people_outline),
                    _buildNavItem(
                      AppStrings.quotation,
                      Icons.request_quote_outlined,
                      onTap: () {
                        Scaffold.of(context).closeDrawer();
                        Get.toNamed(AppRoutes.quotation);
                      },
                    ),
                    
                    const SizedBox(height: AppDimens.paddingMd),
                    _buildSectionTitle(AppStrings.execution),
                    _buildNavItem(AppStrings.execution, Icons.play_circle_outline),
                    _buildNavItem(
                      AppStrings.rsvp,
                      Icons.check_box_outlined,
                      badge: '3',
                      onTap: () {
                        Scaffold.of(context).closeDrawer();
                        Get.toNamed(AppRoutes.createRsvp);
                      },
                    ),
                    _buildNavItem(AppStrings.teamAllocation, Icons.assignment_ind_outlined),
                    _buildNavItem(AppStrings.teamTask, Icons.assignment_outlined),
                    _buildNavItem(AppStrings.checklist, Icons.checklist_rtl_outlined),
                    _buildNavItem(AppStrings.itinerary, Icons.calendar_today_outlined),
                    
                    const SizedBox(height: AppDimens.paddingMd),
                    _buildSectionTitle(AppStrings.relationship),
                    _buildNavItem(
                      AppStrings.followUp,
                      Icons.contact_mail_outlined,
                      onTap: () {
                        Scaffold.of(context).closeDrawer();
                        Get.toNamed(AppRoutes.followUp);
                      },
                    ),
                  ],
                ),
              ),
            ),
            const Divider(height: 1, color: AppColors.border),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppDimens.paddingMd),
              child: Column(
                children: [
                  _buildNavItem(AppStrings.settings, Icons.settings_outlined),
                  _buildNavItem(AppStrings.helpSupport, Icons.help_outline),
                  _buildNavItem(
                    AppStrings.logout,
                    Icons.logout,
                    color: AppColors.error,
                    onTap: () => Get.offAllNamed(AppRoutes.signIn),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimens.paddingMd),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'JE',
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: AppDimens.paddingSm),
              const Text(
                'Just Event',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.close, color: AppColors.textPrimary),
            onPressed: () => Scaffold.of(context).closeDrawer(),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingLg, vertical: AppDimens.paddingSm),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.textSecondary,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildNavItem(String title, IconData icon, {bool isActive = false, String? badge, Color? color, VoidCallback? onTap}) {
    final itemColor = color ?? (isActive ? AppColors.primary : AppColors.textPrimary);
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingLg),
      leading: Icon(icon, color: itemColor),
      title: Text(
        title,
        style: TextStyle(
          color: itemColor,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
          fontSize: 15,
        ),
      ),
      trailing: badge != null
          ? Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: Text(
                badge,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : null,
      selected: isActive,
      selectedTileColor: AppColors.primaryLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.radiusSm),
      ),
      onTap: onTap,
    );
  }
}
