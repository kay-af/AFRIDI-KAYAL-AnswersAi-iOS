import "package:flutter/cupertino.dart";
import "package:store/features/app_listing_page/presentation/app_listing_page.dart";
import "package:store/features/app_listing_page/presentation/app_listing_page_arguments.dart";
import "package:store/features/home_page/today_page/presentation/featured_app_item/featured_app_item_content.dart";
import "package:store/features/home_page/today_page/presentation/featured_app_item/featured_app_item_image.dart";
import "package:store/features/routers/root_router.dart";
import "package:store/features/shared/scaling_action.dart";
import "package:store/network/dtos/featured_app_dto.dart";

class FeaturedAppItemCard extends StatefulWidget {
  static const preferredAspectRatio = 0.75;
  static const preferredMaxWidth = 540.0;
  static const cardRadius = 16.0;

  final FeaturedAppDto featuredApp;

  const FeaturedAppItemCard({required this.featuredApp, super.key});

  @override
  State<FeaturedAppItemCard> createState() => _FeaturedAppItemCardState();
}

class _FeaturedAppItemCardState extends State<FeaturedAppItemCard> {
  final GlobalKey _frameKey = GlobalKey();

  final GlobalKey _getButtonKey = GlobalKey();

  double _currentScale = 1.0;

  @override
  Widget build(BuildContext context) {
    return ScalingAction(
      key: _frameKey,
      onScaleUpdate: (value) => _currentScale = value,
      onPressed: _onPressed,
      ignoreChildrenKeys: [_getButtonKey],
      child: ClipRRect(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(FeaturedAppItemCard.cardRadius),
        child: Stack(
          fit: StackFit.expand,
          children: [
            FeaturedAppItemImage(featuredApp: widget.featuredApp),
            FeaturedAppItemContent(featuredApp: widget.featuredApp, getButtonKey: _getButtonKey),
            _buildBorderLight(),
          ],
        ),
      ),
    );
  }

  Widget _buildBorderLight() {
    return IgnorePointer(
      child: Container(
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(FeaturedAppItemCard.cardRadius),
            side: BorderSide(
              color: CupertinoColors.white.withOpacity(0.2),
            ),
          ),
        ),
      ),
    );
  }

  void _onPressed() {
    final renderBox = _frameKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final offsetGlobalPosition = renderBox.localToGlobal(Offset.zero);
    final itemRect = Rect.fromLTWH(
      offsetGlobalPosition.dx,
      offsetGlobalPosition.dy,
      renderBox.size.width,
      renderBox.size.height,
    );

    rootNavigator.pushNamed(
      AppListingPage.route,
      arguments: AppListingPageArguments(
        featuredApp: widget.featuredApp,
        forwardItemRect: itemRect,
        forwardScaleFactor: _currentScale,
      ),
    );
  }
}
