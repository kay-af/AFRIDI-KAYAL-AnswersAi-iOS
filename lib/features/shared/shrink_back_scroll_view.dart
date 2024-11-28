import "dart:ui";

import "package:flutter/material.dart";
import "package:store/features/routers/root_router.dart";

class ShrinkBackScrollView extends StatefulWidget {
  final ScrollController controller;
  final Widget child;
  final double scrollThresholdOffset;
  final double scrollShrinkFactor;
  final double swipeThresholdOffset;
  final double swipeShrinkFactor;
  final double swipeStartMaxX;

  const ShrinkBackScrollView({
    required this.controller,
    required this.child,
    this.scrollThresholdOffset = 96.0,
    this.scrollShrinkFactor = 0.9,
    this.swipeThresholdOffset = 172.0,
    this.swipeShrinkFactor = 0.8,
    this.swipeStartMaxX = 24.0,
    super.key,
  });

  @override
  State<ShrinkBackScrollView> createState() => _ShrinkBackScrollViewState();
}

class _ShrinkBackScrollViewState extends State<ShrinkBackScrollView> {
  late bool _isSwipingBack;
  late double _swipeBackStartX;
  late ValueNotifier<double> _swipeBackFractionNotifier;

  @override
  void initState() {
    super.initState();
    _isSwipingBack = false;
    _swipeBackStartX = 0.0;
    _swipeBackFractionNotifier = ValueNotifier(0.0);
    widget.controller.addListener(_onScroll);
  }

  @override
  void dispose() {
    _swipeBackFractionNotifier.dispose();
    widget.controller.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    if (widget.controller.hasClients) {
      if (widget.controller.offset < -widget.scrollThresholdOffset) {
        rootNavigator.maybePop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onHorizontalDragDown: _onHorizontalDragDown,
      onHorizontalDragUpdate: _onHorizontalDragUpdate,
      onHorizontalDragCancel: _onHorizontalDragCancel,
      onHorizontalDragEnd: _onHorizontalDragEnd,
      child: ValueListenableBuilder(
        valueListenable: _swipeBackFractionNotifier,
        builder: (context, swipeFraction, child) => AnimatedScale(
          scale: lerpDouble(1.0, widget.swipeShrinkFactor, swipeFraction)!,
          duration: Durations.short3,
          child: AnimatedContainer(
            duration: Durations.short3,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(swipeFraction * 48),
              ),
            ),
            child: child,
          ),
        ),
        child: SingleChildScrollView(
          controller: widget.controller,
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          child: AnimatedBuilder(
            animation: widget.controller,
            builder: (context, child) {
              double scrollFraction = 0.0;
              if (widget.controller.hasClients) {
                scrollFraction =
                    (-widget.controller.offset / widget.scrollThresholdOffset).clamp(0.0, 1.0);
              }
              return Transform.scale(
                scale: lerpDouble(1.0, widget.scrollShrinkFactor, scrollFraction),
                child: ClipRRect(
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.circular(48 * scrollFraction),
                  child: child,
                ),
              );
            },
            child: widget.child,
          ),
        ),
      ),
    );
  }

  void _onHorizontalDragDown(DragDownDetails details) {
    if (details.globalPosition.dx < 16) {
      _isSwipingBack = true;
      _swipeBackStartX = details.globalPosition.dx;
    }
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    if (!_isSwipingBack) return;
    final fraction = ((details.globalPosition.dx - _swipeBackStartX) / widget.swipeThresholdOffset)
        .clamp(0.0, 1.0);
    if (!mounted) return;
    _swipeBackFractionNotifier.value = fraction;
    if (fraction >= 1.0) {
      rootNavigator.maybePop();
    }
  }

  void _onHorizontalDragCancel() {
    if (!mounted) return;
    _isSwipingBack = false;
    _swipeBackFractionNotifier.value = 0;
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    _onHorizontalDragCancel();
  }
}
