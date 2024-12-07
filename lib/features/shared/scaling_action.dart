import "package:flutter/material.dart";

class ScalingAction extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;
  final double scaleFactor;
  final Duration duration;
  final HitTestBehavior behavior;
  final List<GlobalKey>? ignoreChildrenKeys;
  final ValueChanged<double>? onScaleUpdate;

  const ScalingAction({
    required this.child,
    required this.onPressed,
    this.behavior = HitTestBehavior.deferToChild,
    this.scaleFactor = 0.96,
    this.duration = const Duration(milliseconds: 200),
    this.ignoreChildrenKeys,
    this.onScaleUpdate,
    super.key,
  });

  @override
  State<ScalingAction> createState() => _ScalingActionState();
}

class _ScalingActionState extends State<ScalingAction> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: widget.scaleFactor,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutSine,
    ))
      ..addListener(() {
        widget.onScaleUpdate?.call(_scaleAnimation.value);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
    _controller.forward().orCancel.catchError((error) {});
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse().orCancel.catchError((error) {});
    widget.onPressed();
  }

  void _onTapCancel() {
    _controller.reverse().orCancel.catchError((error) {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      behavior: widget.behavior,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          );
        },
        child: widget.child,
      ),
    );
  }
}
