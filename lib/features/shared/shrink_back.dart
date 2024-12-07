import "dart:ui";

import "package:flutter/material.dart";
import "package:store/features/home_page/today_page/presentation/featured_app_item/featured_app_item_card.dart";

class ShrinkBack extends StatefulWidget {
  final ScrollController controller;
  final Widget child;
  final double fingerMoveDistance;
  final double shrinkFactor;
  final double leftEdgeThreshold;
  final ValueChanged<double>? onShrinkUpdate;
  final ValueChanged<double>? onPop;

  const ShrinkBack({
    required this.controller,
    required this.child,
    this.fingerMoveDistance = 120.0,
    this.shrinkFactor = 0.86,
    this.leftEdgeThreshold = 48.0,
    this.onShrinkUpdate,
    this.onPop,
    super.key,
  });

  @override
  State<ShrinkBack> createState() => _ShrinkBackState();
}

class _ShrinkBackState extends State<ShrinkBack> with SingleTickerProviderStateMixin {
  late bool _isSwipingBackX;
  late bool _isSwipingBackY;
  late double _swipeBackStartX;
  late double _swipeBackStartY;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _borderRadiusAnimation;
  bool _isPoppingBack = false;

  @override
  void initState() {
    super.initState();

    _isSwipingBackX = false;
    _isSwipingBackY = false;

    _swipeBackStartX = 0.0;
    _swipeBackStartY = 0.0;

    _animationController = AnimationController(
      duration: Durations.short4,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: widget.shrinkFactor,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    _animationController.addListener(() {
      widget.onShrinkUpdate?.call(_animationController.value);
    });

    _borderRadiusAnimation = Tween<double>(
      begin: 0.0,
      end: 48.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: _onPointerDown,
      onPointerMove: _onPointerMove,
      onPointerUp: _onPointerUp,
      onPointerCancel: _onPointerCancel,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: AnimatedBuilder(
              animation: ModalRoute.of(context)!.animation!,
              builder: (context, child) => Container(
                clipBehavior: Clip.hardEdge,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      _isPoppingBack
                          ? lerpDouble(
                              48.0,
                              FeaturedAppItemCard.cardRadius,
                              1 - ModalRoute.of(context)!.animation!.value,
                            )!
                          : _borderRadiusAnimation.value,
                    ),
                  ),
                ),
                child: child,
              ),
              child: child,
            ),
          );
        },
        child: widget.child,
      ),
    );
  }

  void _onPointerDown(PointerDownEvent event) {
    if (event.position.dx < widget.leftEdgeThreshold) {
      _isSwipingBackX = true;
      _swipeBackStartX = event.position.dx;
    } else if (widget.controller.hasClients && widget.controller.offset <= 32) {
      _isSwipingBackY = true;
      _swipeBackStartY = event.position.dy;
    }
  }

  void _onPointerMove(PointerMoveEvent event) {
    if (_isSwipingBackX) {
      final fraction =
          ((event.position.dx - _swipeBackStartX) / widget.fingerMoveDistance).clamp(0.0, 1.0);

      if (fraction == 1.0) {
        widget.onPop?.call(widget.shrinkFactor);
        setState(() {
          if (mounted) {
            _isPoppingBack = true;
          }
        });
        _animationController.value = 0;
      } else {
        _animationController.value = fraction;
      }
    } else if (_isSwipingBackY) {
      if (widget.controller.hasClients && widget.controller.offset > 0) {
        _swipeBackStartY = event.position.dy;
        return;
      }

      final fraction =
          ((event.position.dy - _swipeBackStartY) / widget.fingerMoveDistance).clamp(0.0, 1.0);

      if (fraction == 1.0) {
        widget.onPop?.call(widget.shrinkFactor);
        setState(() {
          if (mounted) {
            _isPoppingBack = true;
          }
        });
        _animationController.value = 0;
      } else {
        _animationController.value = fraction;
      }
    }
  }

  void _onPointerUp(PointerUpEvent event) {
    _resetAnimation();
  }

  void _onPointerCancel(PointerCancelEvent event) {
    _resetAnimation();
  }

  void _resetAnimation() {
    _isSwipingBackX = false;
    _isSwipingBackY = false;
    _animationController.reverse().orCancel.catchError((_) {});
  }
}
