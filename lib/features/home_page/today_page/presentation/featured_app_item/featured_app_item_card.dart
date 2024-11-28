import "package:flutter/cupertino.dart";
import "package:store/features/app_listing_page/presentation/app_listing_page.dart";
import "package:store/features/app_listing_page/presentation/app_listing_page_arguments.dart";
import "package:store/features/home_page/today_page/presentation/featured_app_item/featured_app_item_image.dart";
import "package:store/features/home_page/today_page/presentation/featured_app_item/featured_app_item_content.dart";
import "package:store/features/routers/root_router.dart";
import "package:store/features/shared/scaling_action.dart";
import "package:store/network/dtos/featured_app_dto.dart";

class FeaturedAppItemCard extends StatelessWidget {
  static const preferredAspectRatio = 0.75;
  static const preferredMaxWidth = 540.0;
  static const cardRadius = 16.0;

  final GlobalKey _getButtonKey = GlobalKey();

  final FeaturedAppDto featuredApp;

  FeaturedAppItemCard({required this.featuredApp, super.key});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: featuredApp.id,
      child: ScalingAction(
        onPressed: _onPressed,
        ignoreChildrenKeys: [_getButtonKey],
        child: ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(cardRadius),
          child: Stack(
            fit: StackFit.expand,
            children: [
              FeaturedAppItemImage(featuredApp: featuredApp),
              FeaturedAppItemContent(featuredApp: featuredApp, getButtonKey: _getButtonKey),
              _buildBorderLight(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBorderLight() {
    return IgnorePointer(
      child: Container(
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(cardRadius),
            side: BorderSide(
              color: CupertinoColors.white.withOpacity(0.2),
            ),
          ),
        ),
      ),
    );
  }

  void _onPressed() {
    rootNavigator.pushNamed(
      AppListingPage.route,
      arguments: AppListingPageArguments(featuredApp: featuredApp),
    );
  }
}
