import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/app_colors.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  static const _email = 'hiowsug.org@gmail.com';
  static const _whatsappNumbers = [
    ('+256 207 809 334', '256207809334'),
    ('+256 787 258 914', '256787258914'),
  ];

  Future<void> _openLink(
    BuildContext context,
    Uri uri,
    String errorMessage,
  ) async {
    final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!opened && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('lib/assets/dr DON-11.JPG'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            AppColors.primaryDark.withValues(alpha: 0.88),
            BlendMode.srcOver,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1160),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Hospital Imaging on Wheels', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 21)),
              const SizedBox(height: 14),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.location_on_outlined, color: AppColors.lightAccent, size: 19),
                  SizedBox(width: 8),
                  Expanded(child: Text('Mukono, opposite the Lands Office', style: TextStyle(color: Colors.white70, height: 1.5))),
                ],
              ),
              const SizedBox(height: 22),
              const Text(
                'CONTACT US',
                style: TextStyle(
                  color: AppColors.lightAccent,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 14,
                runSpacing: 12,
                children: [
                  for (final (displayNumber, whatsappNumber)
                      in _whatsappNumbers)
                    OutlinedButton.icon(
                      onPressed: () => _openLink(
                        context,
                        Uri.parse('https://wa.me/$whatsappNumber'),
                        'Could not open WhatsApp. Please try again.',
                      ),
                      icon: const Icon(Icons.chat_outlined, size: 18),
                      label: Text(displayNumber),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white38),
                      ),
                    ),
                  OutlinedButton.icon(
                    onPressed: () => _openLink(
                      context,
                      Uri(scheme: 'mailto', path: _email),
                      'Could not open your email app. Please try again.',
                    ),
                    icon: const Icon(Icons.email_outlined, size: 18),
                    label: const Text('Email: $_email'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white38),
                    ),
                  ),
                ],
              ),
              const Divider(color: Colors.white24, height: 36),
              const Text('© 2026 Hospital Imaging on Wheels', style: TextStyle(color: Colors.white54, fontSize: 13)),
            ],
          ),
        ),
      ),
    );
  }
}