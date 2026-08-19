import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimens.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/widgets/app_search_field.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, r) {
        return CustomScrollView(
          slivers: [
            _buildAppBar(context),
            SliverPadding(
              padding: EdgeInsets.symmetric(
                horizontal: r.pick(mobile: AppDimens.paddingMd, tablet: AppDimens.paddingLg, desktop: AppDimens.paddingXl),
                vertical: AppDimens.paddingMd,
              ),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 800),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHeader(),
                          const SizedBox(height: AppDimens.paddingMd),
                          _buildSearchBar(),
                          const SizedBox(height: AppDimens.paddingLg),
                          _buildCalendarCard(),
                          const SizedBox(height: AppDimens.paddingLg),
                          _buildUpcomingEventsHeader(),
                          const SizedBox(height: AppDimens.paddingSm),
                          Obx(() => _buildEventsList()),
                          const SizedBox(height: 80), // padding for fab
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      pinned: true,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: AppColors.textPrimary, size: 24),
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
      title: Text(
        AppStrings.justEvent,
        style: GoogleFonts.publicSans(
          color: AppColors.primary,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      centerTitle: true,
      actions: [
        Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_none_rounded, color: AppColors.textPrimary, size: 24),
              onPressed: () {},
            ),
            Positioned(
              top: 14,
              right: 14,
              child: Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: AppDimens.paddingMd, left: 4),
          child: CircleAvatar(
            radius: 17,
            backgroundColor: AppColors.primaryTint,
            child: ClipOval(
              child: Container(
                color: const Color(0xFF1E293B),
                child: const Icon(Icons.person, size: 22, color: AppColors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.goodMorningAdmin,
          style: GoogleFonts.publicSans(
            color: AppColors.textPrimary,
            fontSize: 22,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          AppStrings.dashboardSubtitle,
          style: GoogleFonts.publicSans(
            color: AppColors.textSecondary,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return AppSearchField(
      hintText: AppStrings.searchHint,
      onChanged: controller.searchEvents,
    );
  }

  Widget _buildCalendarCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimens.paddingMd),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() => Text(
                DateFormat('MMMM yyyy').format(controller.currentMonth.value),
                style: GoogleFonts.publicSans(
                  color: AppColors.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              )),
              Row(
                children: [
                  GestureDetector(
                    onTap: controller.previousMonth,
                    behavior: HitTestBehavior.opaque,
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(Icons.chevron_left, color: AppColors.primary, size: 20),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: controller.nextMonth,
                    behavior: HitTestBehavior.opaque,
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(Icons.chevron_right, color: AppColors.primary, size: 20),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN']
                .map((day) => Expanded(
                      child: Text(
                        day,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.publicSans(
                          color: AppColors.hint,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 12),
          _buildCalendarGrid(),
        ],
      ),
    );
  }

  Widget _buildCalendarGrid() {
    return Obx(() {
      final currentMonth = controller.currentMonth.value;
      final selectedDate = controller.selectedDate.value;

      final firstDayOfMonth = DateTime(currentMonth.year, currentMonth.month, 1);
      final lastDayOfMonth = DateTime(currentMonth.year, currentMonth.month + 1, 0);
      final firstWeekday = firstDayOfMonth.weekday;

      final List<DateTime> days = [];
      final previousMonth = DateTime(currentMonth.year, currentMonth.month - 1);
      final lastDayOfPrevMonth = DateTime(currentMonth.year, currentMonth.month, 0).day;

      for (int i = firstWeekday - 1; i > 0; i--) {
        days.add(DateTime(previousMonth.year, previousMonth.month, lastDayOfPrevMonth - i + 1));
      }
      for (int i = 1; i <= lastDayOfMonth.day; i++) {
        days.add(DateTime(currentMonth.year, currentMonth.month, i));
      }
      final remainingCells = 42 - days.length;
      final nextMonth = DateTime(currentMonth.year, currentMonth.month + 1);
      for (int i = 1; i <= remainingCells; i++) {
        days.add(DateTime(nextMonth.year, nextMonth.month, i));
      }

      final List<List<DateTime>> weeks = [];
      for (int i = 0; i < days.length; i += 7) {
        if (i >= 28 && days[i].month != currentMonth.month) break;
        weeks.add(days.sublist(i, i + 7));
      }

      // Special mockup event days for August 2026 (days 20, 22, 23)
      final sampleEventDays = {20, 22, 23};

      return Column(
        children: List.generate(weeks.length, (weekIndex) {
          final week = weeks[weekIndex];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: week.map((date) {
                final isCurrentMonth = date.month == currentMonth.month;
                final isSelected = selectedDate != null &&
                    date.year == selectedDate.year &&
                    date.month == selectedDate.month &&
                    date.day == selectedDate.day;

                // Event indicator dot
                final bool hasEvent = (isCurrentMonth && currentMonth.year == 2026 && currentMonth.month == 8 && sampleEventDays.contains(date.day)) ||
                    controller.events.any((e) {
                      try {
                        final f1 = DateFormat('MM/dd/yyyy').format(date);
                        final f2 = DateFormat('dd/MM/yyyy').format(date);
                        return e.date.contains(f1) || e.date.contains(f2);
                      } catch (_) {
                        return false;
                      }
                    });

                return Expanded(
                  child: GestureDetector(
                    onTap: () => controller.selectDate(date),
                    behavior: HitTestBehavior.opaque,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.primary : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '${date.day}',
                            style: GoogleFonts.publicSans(
                              color: isSelected
                                  ? AppColors.white
                                  : (isCurrentMonth ? AppColors.textPrimary : const Color(0xFFCBD5E1)),
                              fontSize: 13.5,
                              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 3),
                        Container(
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                            color: (!isSelected && hasEvent) ? AppColors.primary : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        }),
      );
    });
  }

  Widget _buildUpcomingEventsHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppStrings.upcomingEvents,
          style: GoogleFonts.publicSans(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Text(
            AppStrings.viewAll,
            style: GoogleFonts.publicSans(
              color: AppColors.primary,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEventsList() {
    if (controller.isLoading.value) {
      return const Padding(
        padding: EdgeInsets.all(40.0),
        child: Center(child: CircularProgressIndicator(color: AppColors.primary)),
      );
    }

    if (controller.hasError.value) {
      return Padding(
        padding: const EdgeInsets.all(40.0),
        child: Center(
          child: Column(
            children: [
              const Icon(Icons.error_outline, color: AppColors.error, size: 48),
              const SizedBox(height: 16),
              Text(controller.errorMessage.value, style: const TextStyle(color: AppColors.error)),
            ],
          ),
        ),
      );
    }

    if (controller.filteredEvents.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(40.0),
        child: Center(
          child: Text(
            'No upcoming events found.',
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ),
      );
    }

    return Column(
      children: controller.filteredEvents.map((event) {
        return Padding(
          padding: const EdgeInsets.only(bottom: AppDimens.paddingSm),
          child: _buildEventCard(
            title: event.title,
            date: event.date,
            time: event.time,
            location: event.location,
            tag: event.tag,
            imageUrl: event.imageUrl,
            tagBgColor: _getTagBgColor(event.tag),
            tagTextColor: _getTagTextColor(event.tag),
          ),
        );
      }).toList(),
    );
  }

  Color _getTagBgColor(String tag) {
    if (tag.toLowerCase() == 'wedding') return AppColors.tagWeddingBg;
    if (tag.toLowerCase() == 'corporate') return AppColors.tagCorporateBg;
    if (tag.toLowerCase() == 'birthday') return AppColors.tagBirthdayBg;
    return AppColors.primaryLight;
  }

  Color _getTagTextColor(String tag) {
    if (tag.toLowerCase() == 'wedding') return AppColors.tagWeddingText;
    if (tag.toLowerCase() == 'corporate') return AppColors.tagCorporateText;
    if (tag.toLowerCase() == 'birthday') return AppColors.tagBirthdayText;
    return AppColors.primaryDark;
  }

  Widget _buildEventCard({
    required String title,
    required String date,
    required String time,
    required String location,
    required String tag,
    required String imageUrl,
    required Color tagBgColor,
    required Color tagTextColor,
  }) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.eventExecution),
      child: Container(
        padding: const EdgeInsets.all(12),
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
        child: Row(
          children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: AppColors.primaryTint,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.broken_image_outlined, color: AppColors.primary);
                },
              ),
            ),
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
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.calendar_today_outlined, size: 12, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    Text(
                      date,
                      style: GoogleFonts.publicSans(color: AppColors.textSecondary, fontSize: 11),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.access_time_outlined, size: 12, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    Text(
                      time,
                      style: GoogleFonts.publicSans(color: AppColors.textSecondary, fontSize: 11),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 12, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        location,
                        style: GoogleFonts.publicSans(color: AppColors.textSecondary, fontSize: 11),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: tagBgColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    tag,
                    style: GoogleFonts.publicSans(
                      color: tagTextColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppColors.hint, size: 20),
        ],
      ),
    ),
    );
  }
}

