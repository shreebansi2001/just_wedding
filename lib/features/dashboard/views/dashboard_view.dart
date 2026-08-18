import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimens.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/widgets/app_search_field.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: ResponsiveBuilder(
        builder: (context, r) {
          return CustomScrollView(
          slivers: [
            _buildAppBar(context),
            SliverPadding(
              padding: EdgeInsets.symmetric(
                horizontal: r.pick(mobile: AppDimens.paddingMd, tablet: AppDimens.paddingLg, desktop: AppDimens.paddingXl),
                vertical: AppDimens.paddingLg,
              ),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1200),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHeader(),
                          const SizedBox(height: AppDimens.paddingLg),
                          _buildSearchBar(),
                          const SizedBox(height: AppDimens.paddingXl),
                          _buildCalendarWidget(r),
                          const SizedBox(height: AppDimens.paddingXl),
                          _buildUpcomingEventsHeader(),
                          const SizedBox(height: AppDimens.paddingMd),
                          Obx(() => _buildEventsList()),
                          const SizedBox(height: 100), // padding for fab
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
    ));
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      pinned: true,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: AppColors.textPrimary),
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
      title: const Text(
        'Just Event',
        style: TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none, color: AppColors.textPrimary),
          onPressed: () {},
        ),
        const Padding(
          padding: EdgeInsets.only(right: AppDimens.paddingMd),
          child: CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.primaryLight,
            child: Icon(Icons.person, size: 20, color: AppColors.primary),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.goodMorningAdmin,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 28,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: AppDimens.paddingXs),
        Text(
          AppStrings.dashboardSubtitle,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
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

  Widget _buildCalendarWidget(ResponsiveInfo r) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimens.paddingMd),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() {
                final month = controller.currentMonth.value;
                final monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
                return Text(
                  '${monthNames[month.month - 1]} ${month.year}',
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left, color: AppColors.primary, size: 20),
                    onPressed: controller.previousMonth,
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                  ),
                  const SizedBox(width: AppDimens.paddingMd),
                  IconButton(
                    icon: const Icon(Icons.chevron_right, color: AppColors.primary, size: 20),
                    onPressed: controller.nextMonth,
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppDimens.paddingMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: ['M', 'T', 'W', 'T', 'F', 'S', 'S']
                .map((day) => Expanded(
                      child: Text(
                        day,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: AppDimens.paddingSm),
          Obx(() => _buildCalendarGrid()),
        ],
      ),
    );
  }

  Widget _buildCalendarGrid() {
    final currentMonth = controller.currentMonth.value;
    final selectedDate = controller.selectedDate.value;
    final daysInMonth = DateTime(currentMonth.year, currentMonth.month + 1, 0).day;
    final firstDayWeekday = DateTime(currentMonth.year, currentMonth.month, 1).weekday;
    
    // Previous month trailing days
    final daysInPrevMonth = DateTime(currentMonth.year, currentMonth.month, 0).day;
    
    List<DateTime> calendarDays = [];
    
    // Fill previous month days
    for (int i = firstDayWeekday - 1; i > 0; i--) {
      calendarDays.add(DateTime(currentMonth.year, currentMonth.month - 1, daysInPrevMonth - i + 1));
    }
    
    // Fill current month days
    for (int i = 1; i <= daysInMonth; i++) {
      calendarDays.add(DateTime(currentMonth.year, currentMonth.month, i));
    }
    
    // Fill next month days
    int remainingDays = 42 - calendarDays.length; // 6 rows * 7 days
    for (int i = 1; i <= remainingDays; i++) {
      calendarDays.add(DateTime(currentMonth.year, currentMonth.month + 1, i));
    }

    List<Widget> rows = [];
    for (int i = 0; i < 6; i++) {
      List<Widget> dayWidgets = [];
      for (int j = 0; j < 7; j++) {
        final date = calendarDays[i * 7 + j];
        final isCurrentMonth = date.month == currentMonth.month;
        final isSelected = selectedDate != null && 
                           date.year == selectedDate.year && 
                           date.month == selectedDate.month && 
                           date.day == selectedDate.day;
                           
        // Check if there's an event on this date (client-side indication)
        final hasEvent = controller.events.any((e) {
          try {
            final eDate = DateTime.parse(e.date);
            return eDate.year == date.year && eDate.month == date.month && eDate.day == date.day;
          } catch (_) {
            return false;
          }
        });

        dayWidgets.add(
          Expanded(
            child: GestureDetector(
              onTap: () => controller.selectDate(date),
              behavior: HitTestBehavior.opaque,
              child: Column(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${date.day}',
                      style: TextStyle(
                        color: isSelected
                            ? AppColors.white
                            : (isCurrentMonth ? AppColors.textPrimary : AppColors.hint),
                        fontSize: 12,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Container(
                    width: 3,
                    height: 3,
                    decoration: BoxDecoration(
                      color: hasEvent && !isSelected ? AppColors.primary : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
      rows.add(Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: dayWidgets,
        ),
      ));
    }

    return Column(children: rows);
  }

  Widget _buildEventsList() {
    if (controller.isLoading.value) {
      return const Padding(
        padding: EdgeInsets.all(20.0),
        child: Center(child: CircularProgressIndicator(color: AppColors.primary)),
      );
    }

    if (controller.hasError.value) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              const Icon(Icons.error_outline, color: AppColors.error, size: 36),
              const SizedBox(height: 8),
              Text(controller.errorMessage.value, style: const TextStyle(color: AppColors.error)),
            ],
          ),
        ),
      );
    }

    if (controller.filteredEvents.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              const Icon(Icons.event_busy, color: AppColors.hint, size: 48),
              const SizedBox(height: 8),
              const Text(
                'No events for this date.',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
              ),
            ],
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
    if (tag.toLowerCase() == 'wedding') return const Color(0xFFF9EAEA);
    if (tag.toLowerCase() == 'corporate') return const Color(0xFFE5F0FF);
    if (tag.toLowerCase() == 'birthday') return const Color(0xFFFCEFDC);
    return AppColors.primaryLight;
  }

  Color _getTagTextColor(String tag) {
    if (tag.toLowerCase() == 'wedding') return AppColors.primary;
    if (tag.toLowerCase() == 'corporate') return const Color(0xFF3163A4);
    if (tag.toLowerCase() == 'birthday') return const Color(0xFFB47318);
    return AppColors.primaryDark;
  }

  Widget _buildUpcomingEventsHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          AppStrings.upcomingEvents,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            AppStrings.viewAll,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        )
      ],
    );
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
    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingSm),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(AppDimens.radiusSm),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppDimens.radiusSm),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.event, color: AppColors.primary, size: 24);
                },
              ),
            ),
          ),
          const SizedBox(width: AppDimens.paddingSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.calendar_today_outlined, size: 10, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    Text(date, style: const TextStyle(color: AppColors.textSecondary, fontSize: 10)),
                    const SizedBox(width: 8),
                    const Icon(Icons.access_time_outlined, size: 10, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    Text(time, style: const TextStyle(color: AppColors.textSecondary, fontSize: 10)),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 10, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        location,
                        style: const TextStyle(color: AppColors.textSecondary, fontSize: 10),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: tagBgColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              tag,
              style: TextStyle(
                color: tagTextColor,
                fontSize: 8,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
    );
  }
}
