import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.onHome,
    this.onServices,
    this.onAbout,
    this.onContact,
  });

  final VoidCallback? onHome;
  final VoidCallback? onServices;
  final VoidCallback? onAbout;
  final VoidCallback? onContact;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 960;
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1240),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isWide ? 40 : 20,
                  vertical: 16,
                ),
                child: Row(
                  children: [
                    const Icon(Icons.local_hospital_outlined, color: AppColors.primary, size: 32),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Hospital Imaging on Wheels',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.primaryDark),
                          ),
                          Text(
                            'MUKONO, UGANDA',
                            style: TextStyle(fontSize: 10, letterSpacing: 1, fontWeight: FontWeight.w700, color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                    if (isWide && onHome != null) ...[
                      _NavigationLink(label: 'Home', onPressed: onHome!),
                      _NavigationLink(label: 'Services', onPressed: onServices!),
                      _NavigationLink(label: 'About', onPressed: onAbout!),
                      _NavigationLink(label: 'Contact', onPressed: onContact!),
                      const SizedBox(width: 12),
                    ] else if (isWide) ...[
                      const Icon(Icons.location_on_outlined, size: 18, color: AppColors.primary),
                      const SizedBox(width: 6),
                      const Text('Opposite the Lands Office, Mukono', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                      const SizedBox(width: 22),
                    ],
                    if (!isWide && onHome != null) ...[
                      PopupMenuButton<String>(
                        tooltip: 'Navigate',
                        icon: const Icon(Icons.menu, color: AppColors.primary),
                        onSelected: (section) {
                          switch (section) {
                            case 'home':
                              onHome!();
                              break;
                            case 'services':
                              onServices!();
                              break;
                            case 'about':
                              onAbout!();
                              break;
                            case 'contact':
                              onContact!();
                              break;
                          }
                        },
                        itemBuilder: (context) => const [
                          PopupMenuItem(value: 'home', child: Text('Home')),
                          PopupMenuItem(value: 'services', child: Text('Services')),
                          PopupMenuItem(value: 'about', child: Text('About')),
                          PopupMenuItem(value: 'contact', child: Text('Contact')),
                        ],
                      ),
                    ],
                    ElevatedButton.icon(
                      onPressed: () => Navigator.pushNamed(context, '/appointment'),
                      icon: const Icon(Icons.calendar_month_outlined, size: 18),
                      label: Text(isWide ? 'Book appointment' : 'Book'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(82);
}

class _NavigationLink extends StatefulWidget {
  const _NavigationLink({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  State<_NavigationLink> createState() => _NavigationLinkState();
}

class _NavigationLinkState extends State<_NavigationLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: TextButton(
        onPressed: widget.onPressed,
        style: TextButton.styleFrom(
          foregroundColor: _hovered ? AppColors.primary : AppColors.textSecondary,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        ),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          style: TextStyle(
            color: _hovered ? AppColors.primary : AppColors.textSecondary,
            fontWeight: _hovered ? FontWeight.w800 : FontWeight.w600,
            fontSize: 13,
          ),
          child: Text(widget.label),
        ),
      ),
    );
  }
}