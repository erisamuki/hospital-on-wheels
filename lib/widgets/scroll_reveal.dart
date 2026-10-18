import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ScrollReveal extends StatefulWidget {
  const ScrollReveal({
    super.key,
    required this.id,
    required this.child,
    this.delay = Duration.zero,
  });

  final String id;
  final Widget child;
  final Duration delay;

  @override
  State<ScrollReveal> createState() => _ScrollRevealState();
}

class _ScrollRevealState extends State<ScrollReveal> {
  bool _isVisible = false;

  void _onVisibilityChanged(VisibilityInfo info) {
    final isVisible = info.visibleFraction >= 0.15;
    if (_isVisible != isVisible) {
      setState(() => _isVisible = isVisible);
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ValueKey(widget.id),
      onVisibilityChanged: _onVisibilityChanged,
      child: widget.child
          .animate(target: _isVisible ? 1 : 0)
          .fade(
            begin: 0,
            end: 1,
            delay: widget.delay,
            duration: 550.ms,
            curve: Curves.easeOut,
          )
          .slideY(
            begin: 0.14,
            end: 0,
            duration: 650.ms,
            curve: Curves.easeOutCubic,
          ),
    );
  }
}
