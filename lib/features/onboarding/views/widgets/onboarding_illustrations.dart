import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimens.dart';

/// Page 1: Calendar, event timeline cards, wedding-related cards composition
class OnboardingIllustration1 extends StatelessWidget {
  const OnboardingIllustration1({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 340,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Faded background circle
          Positioned(
            top: 20,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryLight.withAlpha(80),
              ),
            ),
          ),

          // Calendar card (top center)
          Positioned(
            top: 10,
            left: 40,
            child: _buildCalendarCard(),
          ),

          // Event Timeline card (right side)
          Positioned(
            top: 60,
            right: 20,
            child: _buildEventTimelineCard(),
          ),

          // Wedding card (left, colored)
          Positioned(
            left: 16,
            top: 130,
            child: _buildEventChip(
              'Wedding',
              'Oct 23 | 4:00 PM',
              AppColors.primary,
              AppColors.white,
              Icons.check_circle,
            ),
          ),

          // Sangeet card
          Positioned(
            left: 10,
            top: 185,
            child: _buildEventChip(
              'Sangeet',
              'Oct 25 | 7:30 PM',
              const Color(0xFFE8A03E),
              AppColors.white,
              Icons.check_circle,
            ),
          ),

          // Reception card
          Positioned(
            left: 30,
            top: 240,
            child: _buildEventChip(
              'Reception',
              'Oct 27 | 6:30 PM',
              const Color(0xFF4CAF50),
              AppColors.white,
              null,
            ),
          ),

          // Mehendi card
          Positioned(
            left: 20,
            bottom: 10,
            child: _buildEventChip(
              'Mehendi',
              'Oct 27 | 11:00 AM',
              const Color(0xFF9C27B0),
              AppColors.white,
              null,
            ),
          ),

          // Businesswoman silhouette (right bottom)
          Positioned(
            right: 10,
            bottom: 0,
            child: _buildPersonIllustration(),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarCard() {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(AppDimens.paddingSm),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text(
              'OCTOBER 2024',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildDayLabel('WED'),
              const SizedBox(width: 12),
              Container(
                width: 32,
                height: 32,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.primaryLight,
                  shape: BoxShape.circle,
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('23', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primary)),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.calendar_today, size: 14, color: AppColors.primary),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDayLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 9,
        color: AppColors.textSecondary,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildEventTimelineCard() {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(AppDimens.paddingSm),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimens.radiusMd),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.chevron_left, size: 14, color: AppColors.textSecondary),
              const Spacer(),
              const Text(
                'EVENT TIMELINE',
                style: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  letterSpacing: 0.5,
                ),
              ),
              const Spacer(),
              Icon(Icons.open_in_new, size: 10, color: AppColors.textSecondary.withAlpha(150)),
            ],
          ),
          const SizedBox(height: 8),
          _buildTimelineItem('Wedding', 'Oct 23 | 4:00 PM', AppColors.primary),
          const SizedBox(height: 6),
          _buildTimelineItem('10:00 AM - Vendor Setup', null, const Color(0xFF4CAF50), isSmall: true),
          _buildTimelineItem('4:00 PM - Wedding Ceremony', null, AppColors.primary, isSmall: true),
          _buildTimelineItem('6:30 PM - Photoshoot', null, const Color(0xFFE8A03E), isSmall: true),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(String text, String? subtitle, Color color, {bool isSmall = false}) {
    if (isSmall) {
      return Padding(
        padding: const EdgeInsets.only(left: 8, bottom: 4),
        child: Row(
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(fontSize: 7, color: AppColors.textSecondary),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: color),
          ),
          if (subtitle != null)
            Text(
              subtitle,
              style: TextStyle(fontSize: 7, color: color.withAlpha(180)),
            ),
        ],
      ),
    );
  }

  Widget _buildEventChip(
    String name,
    String detail,
    Color bgColor,
    Color textColor,
    IconData? checkIcon,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppDimens.radiusSm),
        boxShadow: [
          BoxShadow(
            color: bgColor.withAlpha(60),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  color: textColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                detail,
                style: TextStyle(
                  color: textColor.withAlpha(200),
                  fontSize: 8,
                ),
              ),
            ],
          ),
          if (checkIcon != null) ...[
            const SizedBox(width: 6),
            Icon(checkIcon, size: 14, color: textColor.withAlpha(200)),
          ],
        ],
      ),
    );
  }

  Widget _buildPersonIllustration() {
    return SizedBox(
      width: 90,
      height: 140,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Body
          Positioned(
            bottom: 0,
            child: Container(
              width: 50,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.primary.withAlpha(40),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
            ),
          ),
          // Head
          Positioned(
            top: 20,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: const Color(0xFFF5C6A5),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF3D2B1F), width: 2),
              ),
            ),
          ),
          // Hair
          Positioned(
            top: 10,
            child: Container(
              width: 34,
              height: 20,
              decoration: const BoxDecoration(
                color: Color(0xFF3D2B1F),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(17),
                  topRight: Radius.circular(17),
                ),
              ),
            ),
          ),
          // Briefcase
          Positioned(
            bottom: 30,
            right: 5,
            child: Container(
              width: 18,
              height: 14,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Page 2: Workflow diagram with Team, Venue, Tasks, Itinerary, RSVP cards
class OnboardingIllustration2 extends StatelessWidget {
  const OnboardingIllustration2({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 340,
      child: Column(
        children: [
          // Title
          const Text(
            'Event Workflow:\nSeamlessly Planned.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 16),
          // Workflow cards in a visual arrangement
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Connecting lines background
                CustomPaint(
                  size: const Size(double.infinity, 280),
                  painter: _WorkflowLinesPainter(),
                ),

                // Team card
                Positioned(
                  top: 0,
                  left: 20,
                  child: _buildWorkflowCard(
                    'Team',
                    Icons.people_outline,
                    AppColors.primary,
                    hasAvatars: true,
                  ),
                ),

                // Tasks card
                Positioned(
                  top: 0,
                  right: 20,
                  child: _buildTasksCard(),
                ),

                // Venue card
                Positioned(
                  top: 80,
                  left: 20,
                  child: _buildWorkflowCard(
                    'Venue',
                    Icons.location_on_outlined,
                    const Color(0xFF4CAF50),
                    subtitle: 'Grand Ballroom',
                  ),
                ),

                // Itinerary card
                Positioned(
                  top: 100,
                  right: 20,
                  child: _buildItineraryCard(),
                ),

                // RSVP Status card
                Positioned(
                  bottom: 0,
                  right: 20,
                  child: _buildRsvpCard(),
                ),

                // Left side mini items
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildMiniItem('Venue Coordinator', Icons.check_circle, const Color(0xFF4CAF50)),
                      const SizedBox(height: 4),
                      _buildMiniItem('Speaker Setup', Icons.check_circle_outline, AppColors.hint),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkflowCard(
    String title,
    IconData icon,
    Color color, {
    bool hasAvatars = false,
    String? subtitle,
  }) {
    return Container(
      width: 130,
      padding: const EdgeInsets.all(AppDimens.paddingSm),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimens.radiusSm),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(12),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          if (hasAvatars) ...[
            const SizedBox(height: 6),
            Row(
              children: List.generate(3, (i) {
                final colors = [
                  AppColors.primary,
                  const Color(0xFFE8A03E),
                  const Color(0xFF4CAF50),
                ];
                return Container(
                  width: 18,
                  height: 18,
                  margin: EdgeInsets.only(left: i == 0 ? 0 : 4),
                  decoration: BoxDecoration(
                    color: colors[i].withAlpha(50),
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.white, width: 1.5),
                  ),
                  child: Icon(Icons.person, size: 10, color: colors[i]),
                );
              }),
            ),
          ],
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.check_circle, size: 10, color: color),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    subtitle,
                    style: const TextStyle(fontSize: 9, color: AppColors.textSecondary),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTasksCard() {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(AppDimens.paddingSm),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimens.radiusSm),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(12),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.task_alt, size: 14, color: AppColors.primary),
              SizedBox(width: 4),
              Text('Tasks', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            ],
          ),
          const SizedBox(height: 6),
          _buildTaskItem('Venue Setup', true),
          _buildTaskItem('Speaker Coordination', false),
          _buildTaskItem('Banner Coordination', false),
        ],
      ),
    );
  }

  Widget _buildTaskItem(String text, bool checked) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Row(
        children: [
          Icon(
            checked ? Icons.check_box : Icons.check_box_outline_blank,
            size: 12,
            color: checked ? const Color(0xFF4CAF50) : AppColors.hint,
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 8,
                color: AppColors.textSecondary,
                decoration: checked ? TextDecoration.lineThrough : null,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItineraryCard() {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(AppDimens.paddingSm),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimens.radiusSm),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(12),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.schedule, size: 14, color: Color(0xFFE8A03E)),
              SizedBox(width: 4),
              Text('Itinerary', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            ],
          ),
          SizedBox(height: 6),
          Text('9:00 AM - Hymns', style: TextStyle(fontSize: 8, color: AppColors.textSecondary)),
          SizedBox(height: 2),
          Text('7:30 AM - Workshop', style: TextStyle(fontSize: 8, color: AppColors.textSecondary)),
        ],
      ),
    );
  }

  Widget _buildRsvpCard() {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(AppDimens.paddingSm),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimens.radiusSm),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(12),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.how_to_reg, size: 14, color: Color(0xFF3163A4)),
              SizedBox(width: 4),
              Text('RSVP Status', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              _buildRsvpStat('24', 'Accepted', const Color(0xFF4CAF50)),
              const SizedBox(width: 8),
              _buildRsvpStat('20', 'Pending', const Color(0xFFE8A03E)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRsvpStat(String count, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: [
          Text(count, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: color)),
          Text(label, style: TextStyle(fontSize: 7, color: color)),
        ],
      ),
    );
  }

  Widget _buildMiniItem(String text, IconData icon, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: color),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontSize: 8, color: AppColors.textSecondary)),
      ],
    );
  }
}

class _WorkflowLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primaryLight
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    // Vertical line in center-left area
    final centerX = size.width * 0.35;
    canvas.drawLine(
      Offset(centerX, 30),
      Offset(centerX, size.height - 30),
      paint,
    );

    // Small dots along the line
    final dotPaint = Paint()
      ..color = AppColors.primary.withAlpha(60)
      ..style = PaintingStyle.fill;

    for (var y = 40.0; y < size.height - 30; y += 30) {
      canvas.drawCircle(Offset(centerX, y), 3, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Page 3: Phone mockup with "EVENT COMPLETE" screen
class OnboardingIllustration3 extends StatelessWidget {
  const OnboardingIllustration3({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 340,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background confetti/decoration dots
          ..._buildConfettiDots(),

          // Phone frame
          Center(
            child: Container(
              width: 200,
              height: 310,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppDimens.radiusXl),
                border: Border.all(color: AppColors.border, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(15),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppDimens.radiusXl - 1),
                child: Column(
                  children: [
                    // Status bar
                    Container(
                      height: 24,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('9:19', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                          Row(
                            children: [
                              Icon(Icons.signal_cellular_alt, size: 10, color: AppColors.textPrimary),
                              SizedBox(width: 2),
                              Icon(Icons.wifi, size: 10, color: AppColors.textPrimary),
                              SizedBox(width: 2),
                              Icon(Icons.battery_full, size: 10, color: AppColors.textPrimary),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // App bar
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Row(
                        children: [
                          const Icon(Icons.chevron_left, size: 14, color: AppColors.textSecondary),
                          const Spacer(),
                          const Text('EVNTLY', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                          const Spacer(),
                          Container(width: 14),
                        ],
                      ),
                    ),
                    // Content
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            const SizedBox(height: 8),
                            // Event Complete badge
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(0xFF4CAF50).withAlpha(20),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.check_circle, size: 28, color: Color(0xFF4CAF50)),
                            ),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withAlpha(20),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Text(
                                'EVENT\nCOMPLETE',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.primary,
                                  height: 1.2,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),

                            // Planning section
                            _buildSectionHeader('PLANNING', Icons.description_outlined),
                            _buildCheckItem('Venue Booked'),
                            _buildCheckItem('Agenda Set'),
                            _buildCheckItem('Vendors Confirmed'),

                            const SizedBox(height: 8),

                            // Execution section
                            _buildSectionHeader('EXECUTION', Icons.groups_outlined),
                            _buildCheckItem('Team Member Assign'),
                            _buildCheckItem('Rsvp Confirmed'),

                            const SizedBox(height: 8),

                            // On Track section
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildStatCircle('100%', 'Progress', const Color(0xFF4CAF50)),
                                _buildStatCircle('✓', 'Budget', AppColors.primary),
                              ],
                            ),

                            const SizedBox(height: 10),

                            // Bottom icons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildBottomFeature(Icons.sync, 'Seamless\nWorkflow'),
                                _buildBottomFeature(Icons.emoji_emotions_outlined, 'Happy\nAttendees'),
                                _buildBottomFeature(Icons.verified_outlined, 'Stress-Free\nManagement'),
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
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(icon, size: 10, color: AppColors.primary),
          const SizedBox(width: 4),
          Text(
            title,
            style: const TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 14, bottom: 2),
      child: Row(
        children: [
          const Icon(Icons.check, size: 8, color: Color(0xFF4CAF50)),
          const SizedBox(width: 4),
          Text(text, style: const TextStyle(fontSize: 7, color: AppColors.textSecondary)),
        ],
      ),
    );
  }

  Widget _buildStatCircle(String value, String label, Color color) {
    return Column(
      children: [
        Container(
          width: 28,
          height: 28,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 2),
          ),
          child: Text(value, style: TextStyle(fontSize: 8, fontWeight: FontWeight.w700, color: color)),
        ),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(fontSize: 7, color: AppColors.textSecondary)),
      ],
    );
  }

  Widget _buildBottomFeature(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 28,
          height: 28,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 14, color: AppColors.primary),
        ),
        const SizedBox(height: 3),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 6, color: AppColors.textSecondary, height: 1.2),
        ),
      ],
    );
  }

  List<Widget> _buildConfettiDots() {
    final positions = [
      const Offset(30, 20),
      const Offset(60, 50),
      const Offset(20, 140),
      const Offset(50, 280),
      const Offset(310, 30),
      const Offset(290, 100),
      const Offset(330, 200),
      const Offset(300, 280),
      const Offset(160, 10),
      const Offset(200, 320),
    ];

    final colors = [
      AppColors.primary,
      const Color(0xFFE8A03E),
      const Color(0xFF4CAF50),
      AppColors.primary.withAlpha(100),
      const Color(0xFF4CAF50),
      const Color(0xFFE8A03E),
      AppColors.primary,
      const Color(0xFF4CAF50),
      const Color(0xFFE8A03E),
      AppColors.primary.withAlpha(80),
    ];

    return List.generate(positions.length, (i) {
      final size = (i % 3 == 0) ? 6.0 : (i % 3 == 1) ? 4.0 : 8.0;
      final isSquare = i % 4 == 0;
      return Positioned(
        left: positions[i].dx,
        top: positions[i].dy,
        child: Transform.rotate(
          angle: i * 0.5,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: colors[i],
              borderRadius: isSquare ? BorderRadius.circular(1) : BorderRadius.circular(size),
            ),
          ),
        ),
      );
    });
  }
}

/// Illustration for Sign In screen — woman at desk with laptop
class SignInIllustration extends StatelessWidget {
  const SignInIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Left plant
          Positioned(
            left: 20,
            bottom: 0,
            child: _buildPlant(isFlipped: false),
          ),

          // Right plant
          Positioned(
            right: 20,
            bottom: 0,
            child: _buildPlant(isFlipped: true),
          ),

          // Desk
          Positioned(
            bottom: 10,
            child: Container(
              width: 140,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFFF5E6D0),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Stack(
                children: [
                  // Desk legs
                  Positioned(
                    left: 15,
                    bottom: 0,
                    child: Container(width: 3, height: 20, color: const Color(0xFFD4B896)),
                  ),
                  Positioned(
                    right: 15,
                    bottom: 0,
                    child: Container(width: 3, height: 20, color: const Color(0xFFD4B896)),
                  ),
                  // Laptop on desk
                  Positioned(
                    top: -15,
                    left: 35,
                    child: _buildLaptop(),
                  ),
                  // Lamp
                  Positioned(
                    top: -30,
                    right: 10,
                    child: _buildLamp(),
                  ),
                ],
              ),
            ),
          ),

          // Person sitting at desk
          Positioned(
            bottom: 40,
            left: 100,
            child: _buildSittingPerson(),
          ),

          // Floating icons around
          Positioned(
            top: 10,
            left: 60,
            child: _buildFloatingIcon(Icons.person_outline, AppColors.primaryLight, AppColors.primary),
          ),
          Positioned(
            top: 20,
            left: 120,
            child: _buildFloatingIcon(Icons.notifications_outlined, AppColors.primaryLight, AppColors.primary),
          ),
          Positioned(
            top: 10,
            right: 80,
            child: _buildFloatingIcon(Icons.calendar_today_outlined, AppColors.primaryLight, AppColors.primary),
          ),
          Positioned(
            top: 40,
            right: 40,
            child: _buildFloatingIcon(Icons.lightbulb_outline, AppColors.primaryLight, AppColors.primary),
          ),
          Positioned(
            top: 30,
            left: 40,
            child: _buildFloatingIcon(Icons.check_circle_outline, AppColors.primaryLight, AppColors.primary),
          ),
        ],
      ),
    );
  }

  Widget _buildPlant({required bool isFlipped}) {
    return Transform.flip(
      flipX: isFlipped,
      child: SizedBox(
        width: 60,
        height: 80,
        child: Stack(
          children: [
            // Pot
            Positioned(
              bottom: 0,
              left: 15,
              child: Container(
                width: 30,
                height: 20,
                decoration: BoxDecoration(
                  color: AppColors.primary.withAlpha(80),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(6),
                    bottomRight: Radius.circular(6),
                  ),
                ),
              ),
            ),
            // Leaves
            Positioned(
              bottom: 15,
              left: 5,
              child: Container(
                width: 22,
                height: 35,
                decoration: BoxDecoration(
                  color: AppColors.primary.withAlpha(50),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(4),
                    bottomRight: Radius.circular(20),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              right: 5,
              child: Container(
                width: 18,
                height: 30,
                decoration: BoxDecoration(
                  color: AppColors.primary.withAlpha(40),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(18),
                    bottomLeft: Radius.circular(18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLaptop() {
    return Column(
      children: [
        // Screen
        Container(
          width: 40,
          height: 28,
          decoration: BoxDecoration(
            color: const Color(0xFFE8E8E8),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(3),
              topRight: Radius.circular(3),
            ),
            border: Border.all(color: const Color(0xFFCCCCCC), width: 1),
          ),
          child: Center(
            child: Container(
              width: 30,
              height: 18,
              color: Colors.white,
              child: const Icon(Icons.code, size: 12, color: AppColors.primary),
            ),
          ),
        ),
        // Base
        Container(
          width: 46,
          height: 3,
          decoration: BoxDecoration(
            color: const Color(0xFFCCCCCC),
            borderRadius: BorderRadius.circular(1),
          ),
        ),
      ],
    );
  }

  Widget _buildLamp() {
    return Column(
      children: [
        // Shade
        Container(
          width: 16,
          height: 10,
          decoration: const BoxDecoration(
            color: Color(0xFFE8A03E),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
          ),
        ),
        // Stand
        Container(width: 2, height: 20, color: const Color(0xFFCCCCCC)),
      ],
    );
  }

  Widget _buildSittingPerson() {
    return SizedBox(
      width: 60,
      height: 80,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Hair
          Positioned(
            top: 0,
            child: Container(
              width: 24,
              height: 14,
              decoration: const BoxDecoration(
                color: Color(0xFF3D2B1F),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
            ),
          ),
          // Head
          Positioned(
            top: 6,
            child: Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                color: Color(0xFFF5C6A5),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Body (blouse)
          Positioned(
            top: 24,
            child: Container(
              width: 30,
              height: 25,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          // Legs
          Positioned(
            top: 48,
            child: Container(
              width: 28,
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFF3D2B1F).withAlpha(180),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(3),
                  bottomRight: Radius.circular(3),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingIcon(IconData icon, Color bgColor, Color iconColor) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: iconColor.withAlpha(20),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(icon, size: 14, color: iconColor),
    );
  }
}
