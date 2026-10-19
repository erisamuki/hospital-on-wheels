import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/app_colors.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/footer_widget.dart';
import '../widgets/imaging_information_section.dart';
import '../widgets/scroll_reveal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _homeKey = GlobalKey();
  final _servicesKey = GlobalKey();
  final _aboutKey = GlobalKey();
  final _contactKey = GlobalKey();

  Future<void> _scrollTo(GlobalKey key) async {
    final target = key.currentContext;
    if (target != null) {
      await Scrollable.ensureVisible(
        target,
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeInOutCubic,
        alignment: 0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onHome: () => _scrollTo(_homeKey),
        onServices: () => _scrollTo(_servicesKey),
        onAbout: () => _scrollTo(_aboutKey),
        onContact: () => _scrollTo(_contactKey),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            KeyedSubtree(key: _homeKey, child: _buildHeroSection(context)),
            KeyedSubtree(key: _servicesKey, child: _buildCareSection(context)),
            KeyedSubtree(key: _aboutKey, child: const ImagingInformationSection()),
            _buildVisitSection(context),
            KeyedSubtree(
              key: _contactKey,
              child: const ScrollReveal(
                id: 'footer-reveal',
                child: FooterWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('lib/assets/dr DON-11.JPG'),
          fit: BoxFit.cover,
          alignment: Alignment.centerRight,
        ),
      ),
      child: Stack(
        children: [
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xEB0B3C6F),
                    Color(0xB30B3C6F),
                    Color(0x000B3C6F),
                  ],
                  stops: [0, 0.45, 1],
                ),
              ),
            ),
          ),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1240),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 52,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 680),
                    child: _heroCopy(context),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _heroCopy(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFC45A00),
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Text(
            'HOSPITAL IMAGING ON WHEELS  /  MUKONO',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w800,
              letterSpacing: 1,
            ),
          ),
        )
            .animate()
            .fadeIn(duration: 500.ms, curve: Curves.easeOut)
            .move(
              begin: const Offset(0, 20),
              end: Offset.zero,
              duration: 500.ms,
              curve: Curves.easeOutCubic,
            ),
        const SizedBox(height: 18),
        Text(
          'Access care with complete confidence.',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            color: Colors.white,
            fontSize: 56,
            height: 1.12,
            fontWeight: FontWeight.w800,
          ),
        )
            .animate(delay: 150.ms)
            .fadeIn(duration: 600.ms, curve: Curves.easeOut)
            .move(
              begin: const Offset(0, 20),
              end: Offset.zero,
              duration: 600.ms,
              curve: Curves.easeOutCubic,
            ),
        const SizedBox(height: 20),
        const Text(
          'Quality healthcare close to home. Visit us in Mukono, opposite the Lands Office.',
          style: TextStyle(
            color: Color(0xE6FFFFFF),
            fontSize: 20,
            height: 1.7,
          ),
        )
            .animate(delay: 300.ms)
            .fadeIn(duration: 600.ms, curve: Curves.easeOut)
            .move(
              begin: const Offset(0, 20),
              end: Offset.zero,
              duration: 600.ms,
              curve: Curves.easeOutCubic,
            ),
        const SizedBox(height: 30),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: const [
            _HeroBadge(icon: Icons.health_and_safety_outlined, label: 'Patient-centered care'),
            _HeroBadge(icon: Icons.directions_bus_outlined, label: 'Mobile imaging'),
            _HeroBadge(icon: Icons.location_on_outlined, label: 'Mukono, Uganda'),
          ],
        )
            .animate(delay: 450.ms)
            .fadeIn(duration: 500.ms)
            .move(
              begin: const Offset(0, 20),
              end: Offset.zero,
              duration: 500.ms,
              curve: Curves.easeOutCubic,
            ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/appointment'),
              icon: const Icon(Icons.calendar_month_outlined),
              label: const Text('Book an appointment'),
            )
                .animate(delay: 600.ms)
                .fadeIn(duration: 500.ms)
                .move(
                  begin: const Offset(0, 20),
                  end: Offset.zero,
                  duration: 500.ms,
                  curve: Curves.easeOutCubic,
                ),
            ElevatedButton.icon(
              onPressed: () => _showLocation(context),
              icon: const Icon(Icons.location_on_outlined),
              label: const Text('Find our hospital'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
            )
                .animate(delay: 700.ms)
                .fadeIn(duration: 500.ms)
                .move(
                  begin: const Offset(0, 20),
                  end: Offset.zero,
                  duration: 500.ms,
                  curve: Curves.easeOutCubic,
                ),
          ],
        ),
      ],
    );
  }

  Widget _buildCareSection(BuildContext context) {
    return Container(
      color: AppColors.sectionBackground,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1160),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScrollReveal(
                id: 'services-eyebrow',
                child: const Text('HERE WHEN YOU NEED US', style: TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.w800, letterSpacing: 1)),
              ),
              const SizedBox(height: 12),
              ScrollReveal(
                id: 'services-title',
                delay: const Duration(milliseconds: 100),
                child: Text('Explore your next step', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800)),
              ),
              const SizedBox(height: 30),
              LayoutBuilder(
                builder: (context, constraints) {
                  final columns = constraints.maxWidth >= 800 ? 3 : (constraints.maxWidth >= 520 ? 2 : 1);
                  final width = (constraints.maxWidth - (columns - 1) * 18) / columns;
                  return Wrap(
                    spacing: 18,
                    runSpacing: 18,
                    children: [
                      _careItem(width, 0, 'lib/assets/IMG_8697.jpg', Icons.medical_services_outlined, 'Explore care', 'Speak with our team about the care and services available.'),
                      _careItem(width, 1, 'lib/assets/IMG_8727.jpg', Icons.calendar_month_outlined, 'Book a visit', 'Request an appointment at our Mukono hospital.'),
                      _careItem(width, 2, 'lib/assets/IMG_8779.jpg', Icons.directions_outlined, 'Plan your visit', 'Find us in Mukono, opposite the Lands Office.'),
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

  Widget _careItem(double width, int index, String imagePath, IconData icon, String title, String description) {
    return ScrollReveal(
      id: 'service-card-$index',
      delay: Duration(milliseconds: 120 * index),
      child: SizedBox(
        width: width,
        child: _PressableCard(
          child: Container(
          decoration: BoxDecoration(color: AppColors.surface, border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(4)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(3)),
                child: SizedBox(
                  height: 160,
                  width: double.infinity,
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    cacheWidth: 800,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(icon, color: AppColors.primary, size: 25),
                    const SizedBox(height: 14),
                    Text(title, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                    const SizedBox(height: 8),
                    Text(description, style: const TextStyle(color: AppColors.textSecondary, height: 1.5)),
                  ],
                ),
              ),
            ],
          ),
          ),
        ),
      ),
    );
  }

  Widget _buildVisitSection(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1160),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 62),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 680;
              final details = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ScrollReveal(
                    id: 'visit-eyebrow',
                    child: const Text('COME VISIT US', style: TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.w800, letterSpacing: 1)),
                  ),
                  const SizedBox(height: 12),
                  ScrollReveal(
                    id: 'visit-title',
                    delay: const Duration(milliseconds: 100),
                    child: Text('Right here in Mukono.', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800)),
                  ),
                  const SizedBox(height: 14),
                  ScrollReveal(
                    id: 'visit-description',
                    delay: const Duration(milliseconds: 160),
                    child: const Text('Hospital Imaging on Wheels is in Mukono, opposite the Lands Office.', style: TextStyle(color: AppColors.textSecondary, fontSize: 16, height: 1.6)),
                  ),
                  const SizedBox(height: 22),
                  OutlinedButton.icon(
                    onPressed: () => _showLocation(context),
                    icon: const Icon(Icons.location_on_outlined),
                    label: const Text('View location details'),
                  ),
                ],
              );
              final panel = Container(
                padding: const EdgeInsets.all(28),
                color: AppColors.primaryDark,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.pin_drop_outlined, color: AppColors.lightAccent, size: 30),
                    SizedBox(height: 18),
                    Text('HOSPITAL IMAGING ON WHEELS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 17)),
                    SizedBox(height: 8),
                    Text('Mukono\nOpposite the Lands Office', style: TextStyle(color: Colors.white70, height: 1.6)),
                  ],
                ),
              );
              return isWide
                  ? Row(children: [Expanded(child: details), const SizedBox(width: 50), SizedBox(width: 330, child: panel)])
                  : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [details, const SizedBox(height: 28), SizedBox(width: double.infinity, child: panel)]);
            },
          ),
        ),
      ),
    );
  }

  void _showLocation(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Visit Hospital Imaging on Wheels'),
        content: const Text('Mukono, opposite the Lands Office.'),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))],
      ),
    );
  }
}

class _HeroBadge extends StatelessWidget {
  const _HeroBadge({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.iconBackground,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.primary, size: 17),
          const SizedBox(width: 7),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.primaryDark,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _PressableCard extends StatefulWidget {
  const _PressableCard({required this.child});

  final Widget child;

  @override
  State<_PressableCard> createState() => _PressableCardState();
}

class _PressableCardState extends State<_PressableCard> {
  bool _isPressed = false;
  bool _isHovered = false;

  void _setPressed(bool isPressed) {
    if (_isPressed != isPressed) {
      setState(() => _isPressed = isPressed);
    }
  }

  void _setHovered(bool isHovered) {
    if (_isHovered != isHovered) {
      setState(() => _isHovered = isHovered);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _setHovered(true),
      onExit: (_) => _setHovered(false),
      child: GestureDetector(
        onTapDown: (_) => _setPressed(true),
        onTapUp: (_) => _setPressed(false),
        onTapCancel: () => _setPressed(false),
        child: AnimatedScale(
          scale: _isPressed ? 0.98 : (_isHovered ? 1.025 : 1),
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOutCubic,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryDark.withValues(alpha: _isHovered ? 0.14 : 0.04),
                  blurRadius: _isHovered ? 20 : 8,
                  offset: Offset(0, _isHovered ? 9 : 3),
                ),
              ],
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}