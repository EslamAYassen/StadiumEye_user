import 'package:flutter/material.dart';

/// Reusable fade + slide-up entrance animation used to stagger the
/// appearance of sections on scrollable pages (e.g. the Home page slivers).
///
/// Wrap any widget with [StaggeredFadeIn] and give it an incrementing
/// [index] to create a staggered reveal effect as the page first builds,
/// without needing a bespoke [AnimationController] in every section.
///
/// Usage:
/// ```dart
/// StaggeredFadeIn(index: 0, child: const MatchesSection()),
/// StaggeredFadeIn(index: 1, child: const TicketsStatusChart()),
/// ```
class StaggeredFadeIn extends StatefulWidget {
  const StaggeredFadeIn({
    super.key,
    required this.child,
    this.index = 0,
    this.baseDelay = const Duration(milliseconds: 90),
    this.duration = const Duration(milliseconds: 500),
    this.offset = const Offset(0, 0.08),
  });

  /// The widget to animate in.
  final Widget child;

  /// Position in the staggered sequence; higher index = later start.
  final int index;

  /// Delay multiplier applied per [index].
  final Duration baseDelay;

  /// How long the fade/slide takes once it starts.
  final Duration duration;

  /// Starting slide offset (fractional, relative to the child's size).
  final Offset offset;

  @override
  State<StaggeredFadeIn> createState() => _StaggeredFadeInState();
}

class _StaggeredFadeInState extends State<StaggeredFadeIn>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slide = Tween<Offset>(begin: widget.offset, end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    Future.delayed(widget.baseDelay * widget.index, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(position: _slide, child: widget.child),
    );
  }
}
