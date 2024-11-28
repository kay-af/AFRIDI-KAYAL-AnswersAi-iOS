import "package:flutter/cupertino.dart";
import "package:store/core/utils.dart";
import "package:store/features/shared/get_button.dart";
import "package:store/network/dtos/featured_app_dto.dart";

class FeaturedAppItemContent extends StatelessWidget {
  final FeaturedAppDto featuredApp;
  final GlobalKey getButtonKey;

  const FeaturedAppItemContent({
    required this.featuredApp,
    required this.getButtonKey,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildDescription(),
          _buildAppTile(),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            featuredApp.descriptionHeader,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: featuredApp.prefersDarkText
                  ? CupertinoColors.black.withOpacity(0.5)
                  : CupertinoColors.white.withOpacity(0.5),
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          4.verticalSpace,
          Text(
            featuredApp.descriptionContent,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: featuredApp.prefersDarkText ? CupertinoColors.black : CupertinoColors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          4.verticalSpace,
          Text(
            featuredApp.descriptionFooter,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: featuredApp.prefersDarkText
                  ? CupertinoColors.black.withOpacity(0.5)
                  : CupertinoColors.white.withOpacity(0.5),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppTile() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: CupertinoColors.black.withOpacity(0.2),
      child: Row(
        children: [
          _buildAppIcon(),
          12.horizontalSpace,
          Expanded(
            child: DefaultTextStyle.merge(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    featuredApp.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: featuredApp.prefersDarkText
                          ? CupertinoColors.black
                          : CupertinoColors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  2.verticalSpace,
                  Text(
                    featuredApp.keywords,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: featuredApp.prefersDarkText
                          ? CupertinoColors.black.withOpacity(0.75)
                          : CupertinoColors.white.withOpacity(0.75),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          12.horizontalSpace,
          GetButton(
            key: getButtonKey,
            hasInAppPurchases: featuredApp.hasInappPurchases,
            prefersDarkText: featuredApp.prefersDarkText,
          ),
        ],
      ),
    );
  }

  Widget _buildAppIcon() {
    return SizedBox.square(
      dimension: 42,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: CupertinoColors.white.withOpacity(0.1)),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(featuredApp.iconUrl),
        ),
      ),
    );
  }
}
