import "dart:ui";

import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:store/core/utils.dart";
import "package:store/features/shared/get_button.dart";
import "package:store/network/dtos/featured_app_dto.dart";

class FeaturedAppInstallBar extends StatelessWidget {
  final FeaturedAppDto featuredApp;
  final bool onScreen;

  final GlobalKey _getButtonKey = GlobalKey();

  FeaturedAppInstallBar({
    required this.featuredApp,
    required this.onScreen,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: MediaQuery.of(context).padding.bottom,
      right: 16,
      left: 16,
      child: AnimatedSlide(
        duration: Durations.long4,
        curve: Curves.easeInOutBack,
        offset: onScreen ? Offset.zero : const Offset(0, 2),
        child: ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(12),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: ClipRRect(
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(16),
                color: CupertinoTheme.of(context).barBackgroundColor,
                child: _buildAppTile(context),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppTile(BuildContext context) {
    return Row(
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
                    color: MediaQuery.of(context).platformBrightness == Brightness.light
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
                    color: MediaQuery.of(context).platformBrightness == Brightness.light
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
          key: _getButtonKey,
          hasInAppPurchases: featuredApp.hasInappPurchases,
          prefersDarkText: null,
        ),
      ],
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
