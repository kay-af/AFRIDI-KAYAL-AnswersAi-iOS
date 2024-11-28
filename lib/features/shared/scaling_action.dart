import "package:flutter/material.dart";

class ScalingAction extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;
  final double scaleFactor;
  final Duration duration;
  final HitTestBehavior behavior;
  final List<GlobalKey>? ignoreChildrenKeys;

  const ScalingAction({
    required this.child,
    required this.onPressed,
    this.behavior = HitTestBehavior.deferToChild,
    this.scaleFactor = 0.96,
    this.duration = Durations.medium2,
    this.ignoreChildrenKeys,
    super.key,
  });

  @override
  State<ScalingAction> createState() => _ScalingActionState();
}

class _ScalingActionState extends State<ScalingAction> {
  double _scale = 1.0;

  @override
  void setState(VoidCallback fn) {
    if (!mounted) return;
    super.setState(fn);
  }

  void _onTapDown(TapDownDetails details) {
    final ignoreChildrenKeys = widget.ignoreChildrenKeys;
    if (ignoreChildrenKeys != null) {
      final box = context.findRenderObject() as RenderBox?;
      if (box == null) return;

      final touchPosition = details.globalPosition;

      for (final key in ignoreChildrenKeys) {
        final buttonRenderBox = key.currentContext?.findRenderObject() as RenderBox?;
        if (buttonRenderBox != null) {
          final buttonPosition = buttonRenderBox.localToGlobal(Offset.zero);
          final buttonSize = buttonRenderBox.size;

          final noOverlap = (touchPosition.dx < buttonPosition.dx) ||
              (touchPosition.dx > buttonPosition.dx + buttonSize.width) ||
              (touchPosition.dy < buttonPosition.dy) ||
              (touchPosition.dy > buttonPosition.dy + buttonSize.height);
          final hasOverlap = !noOverlap;
          if (hasOverlap) return;
        }
      }
    }
    setState(() => _scale = widget.scaleFactor);
  }

  void _onTapUp(TapUpDetails details) {
    setState(() => _scale = 1.0);
    widget.onPressed();
  }

  void _onTapCancel() {
    setState(() => _scale = 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      behavior: widget.behavior,
      child: AnimatedScale(
        curve: Curves.easeInOutSine,
        scale: _scale,
        duration: widget.duration,
        child: widget.child,
      ),
    );
  }
}
