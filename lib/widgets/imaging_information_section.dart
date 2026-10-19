import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import 'scroll_reveal.dart';

class ImagingInformationSection extends StatelessWidget {
  const ImagingInformationSection({super.key});

  static const _vision =
      'To revolutionize access to medical imaging services, bridge the healthcare gap in underserved communities, and improve patient outcomes through innovative mobility and cutting-edge technology.';

  static const _mission =
      'To deliver high-quality, patient-centric mobile medical imaging services directly to the community, fostering early detection, diagnosis, and treatment of medical conditions.';

  static const _objectives = [
    'Provide accessible imaging services, regardless of geographical or financial barriers.',
    'Foster continuous learning, innovation, and excellence in medical imaging.',
    'Build trust through compassionate care and exceptional patient service.',
    'Collaborate with healthcare providers to enhance patient outcomes.',
    'Embrace innovation and technology to stay at the forefront of mobile imaging.',
  ];

  static const _goals = [
    'Deploy fully equipped mobile imaging units with enough staff to serve marginalized communities.',
    'Perform at least 1,000 imaging procedures per month.',
    'Achieve a patient satisfaction rate of 95% or higher.',
    'Partner with at least five local healthcare organizations for seamless referrals and follow-up care.',
    'Add imaging modalities such as MRI and CT within the next 24 months.',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('lib/assets/dr DON-11.JPG'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.white.withValues(alpha: 0.42),
            BlendMode.srcOver,
          ),
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.sectionBackground.withValues(alpha: 0.3),
            AppColors.background.withValues(alpha: 0.3),
          ],
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1160),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScrollReveal(
                id: 'imaging-eyebrow',
                child: const Text(
                  'HOSPITAL IMAGING ON WHEELS',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ScrollReveal(
                id: 'imaging-title',
                delay: const Duration(milliseconds: 100),
                child: Text(
                  'Scan anywhere.',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(height: 30),
              LayoutBuilder(
                builder: (context, constraints) {
                  final columns = constraints.maxWidth >= 680 ? 2 : 1;
                  final width =
                      (constraints.maxWidth - (columns - 1) * 18) / columns;
                  return Wrap(
                    spacing: 18,
                    runSpacing: 18,
                    children: [
                      ScrollReveal(
                        id: 'imaging-vision',
                        child: _InformationCard(
                          width: width,
                          icon: Icons.visibility_outlined,
                          title: 'Our vision',
                          content: _vision,
                        ),
                      ),
                      ScrollReveal(
                        id: 'imaging-mission',
                        delay: const Duration(milliseconds: 100),
                        child: _InformationCard(
                          width: width,
                          icon: Icons.favorite_outline,
                          title: 'Our mission',
                          content: _mission,
                        ),
                      ),
                      ScrollReveal(
                        id: 'imaging-objectives',
                        delay: const Duration(milliseconds: 150),
                        child: _InformationCard(
                          width: width,
                          icon: Icons.track_changes_outlined,
                          title: 'Our objectives',
                          items: _objectives,
                        ),
                      ),
                      ScrollReveal(
                        id: 'imaging-goals',
                        delay: const Duration(milliseconds: 200),
                        child: _InformationCard(
                          width: width,
                          icon: Icons.flag_outlined,
                          title: 'Our goals',
                          items: _goals,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InformationCard extends StatefulWidget {
  const _InformationCard({
    required this.width,
    required this.icon,
    required this.title,
    this.content,
    this.items = const [],
  });

  final double width;
  final IconData icon;
  final String title;
  final String? content;
  final List<String> items;

  @override
  State<_InformationCard> createState() => _InformationCardState();
}

class _InformationCardState extends State<_InformationCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        width: widget.width,
        padding: const EdgeInsets.all(24),
        transform: Matrix4.translationValues(0, _isHovered ? -4 : 0, 0),
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryDark.withValues(alpha: _isHovered ? 0.12 : 0.04),
              blurRadius: _isHovered ? 18 : 8,
              offset: Offset(0, _isHovered ? 8 : 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(widget.icon, color: AppColors.primary, size: 27),
            const SizedBox(height: 14),
            Text(
              widget.title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 12),
            if (widget.content != null)
              Text(
                widget.content!,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  height: 1.65,
                ),
              ),
            for (final item in widget.items) ...[
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 7),
                    child: Icon(Icons.circle, color: AppColors.highlight, size: 7),
                  ),
                  const SizedBox(width: 11),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
