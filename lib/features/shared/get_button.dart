import "dart:math";

import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:store/core/utils.dart";

class GetButton extends ConsumerStatefulWidget {
  final bool? prefersDarkText;
  final bool hasInAppPurchases;
  final bool centeredProgress;

  const GetButton({
    required this.hasInAppPurchases,
    required this.prefersDarkText,
    this.centeredProgress = false,
    super.key,
  });

  @override
  ConsumerState<GetButton> createState() => _GetButtonState();
}

class _GetButtonState extends ConsumerState<GetButton> with SingleTickerProviderStateMixin {
  late AnimationController _loadingProgressAnimationController;
  late Animation<double> _loadingProgressAnimation;

  @override
  void initState() {
    super.initState();
    _loadingProgressAnimationController = AnimationController(
      vsync: this,
      duration: Durations.extralong4 * 5,
    );
    final random = Random(DateTime.now().microsecondsSinceEpoch);
    _loadingProgressAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.2), weight: 1.0 + random.nextInt(10)),
      TweenSequenceItem(tween: Tween(begin: 0.2, end: 0.4), weight: 1.0 + random.nextInt(10)),
      TweenSequenceItem(tween: Tween(begin: 0.4, end: 0.6), weight: 1.0 + random.nextInt(10)),
      TweenSequenceItem(tween: Tween(begin: 0.6, end: 0.8), weight: 1.0 + random.nextInt(10)),
      TweenSequenceItem(tween: Tween(begin: 0.8, end: 1.0), weight: 1.0 + random.nextInt(10)),
    ]).animate(_loadingProgressAnimationController);
  }

  @override
  void dispose() {
    _loadingProgressAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: AnimatedBuilder(
        animation: _loadingProgressAnimation,
        builder: (context, child) {
          final isLoading = _loadingProgressAnimation.value > 0.0;
          return Stack(
            children: [
              Positioned.fill(
                child: IgnorePointer(
                  ignoring: !isLoading,
                  child: Align(
                    alignment: widget.centeredProgress ? Alignment.center : Alignment.centerRight,
                    child: AnimatedOpacity(
                      duration: Durations.short3,
                      opacity: isLoading ? 1 : 0,
                      child: SizedBox.square(
                        child: Stack(
                          children: [
                            SizedBox.square(
                              dimension: 32,
                              child: CircularProgressIndicator(
                                value: _loadingProgressAnimation.value,
                                color: CupertinoTheme.of(context).primaryColor,
                                strokeWidth: 3,
                                backgroundColor: CupertinoColors.black.withOpacity(0.25),
                              ),
                            ),
                            Positioned.fill(
                              child: CupertinoButton(
                                minSize: 0,
                                padding: EdgeInsets.zero,
                                onPressed: _stopLoading,
                                child: const Icon(
                                  CupertinoIcons.stop_fill,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              IgnorePointer(
                ignoring: isLoading,
                child: ClipRect(
                  child: AnimatedScale(
                    duration: Durations.short3,
                    scale: widget.centeredProgress ? (isLoading ? 0.5 : 1.0) : 1.0,
                    child: AnimatedSlide(
                      duration: Durations.short3,
                      offset:
                          widget.centeredProgress ? Offset.zero : Offset(isLoading ? 0.5 : 0, 0),
                      child: AnimatedOpacity(
                        duration: Durations.short3,
                        opacity: isLoading ? 0 : 1,
                        child: Column(
                          children: [
                            CupertinoButton(
                              minSize: 0,
                              color: widget.prefersDarkText == null
                                  ? CupertinoColors.activeBlue
                                  : (widget.prefersDarkText!
                                      ? CupertinoColors.white.withOpacity(0.25)
                                      : CupertinoColors.black.withOpacity(0.25)),
                              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                              borderRadius: BorderRadius.circular(32),
                              onPressed: _startLoading,
                              child: const Text(
                                "Get",
                                style: TextStyle(
                                  color: CupertinoColors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            if (widget.hasInAppPurchases) ...[
                              6.verticalSpace,
                              Text(
                                "In-App Purchases",
                                style: TextStyle(
                                  fontSize: 8,
                                  color: widget.prefersDarkText == null
                                      ? null
                                      : widget.prefersDarkText!
                                          ? CupertinoColors.black.withOpacity(0.75)
                                          : CupertinoColors.white.withOpacity(0.75),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _startLoading() {
    if (!mounted) return;
    _loadingProgressAnimationController
        .forward()
        .orCancel
        .whenComplete(_stopLoading)
        .catchError((err) {});
  }

  void _stopLoading() {
    if (!mounted) return;
    _loadingProgressAnimationController.reset();
  }
}
