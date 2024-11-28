import "dart:ui";

import "package:flutter/cupertino.dart";
import "package:store/core/utils.dart";

class CupertinoSliverPersistentBlurHeader extends StatelessWidget {
  const CupertinoSliverPersistentBlurHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      floating: false,
      pinned: true,
      delegate: _CupertinoSliverPersistentBlurHeaderDelegate(context: context),
    );
  }
}

class _CupertinoSliverPersistentBlurHeaderDelegate extends SliverPersistentHeaderDelegate {
  final BuildContext context;

  const _CupertinoSliverPersistentBlurHeaderDelegate({required this.context});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final scrollFraction = MathUtils.inverseLerp(0, maxExtent, shrinkOffset).clamp(0.0, 1.0);

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          height: maxExtent,
          decoration: BoxDecoration(
            color: Color.lerp(
              CupertinoTheme.of(context).barBackgroundColor.withOpacity(0),
              CupertinoTheme.of(context).barBackgroundColor,
              scrollFraction,
            ),
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => MediaQuery.of(context).padding.top;

  @override
  double get minExtent => MediaQuery.of(context).padding.top;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
