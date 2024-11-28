import "package:flutter/cupertino.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:store/core/utils.dart";
import "package:store/features/home_page/today_page/data/featured_apps_provider.dart";
import "package:store/features/home_page/today_page/presentation/featured_app_item/featured_app_item_card.dart";
import "package:store/features/shared/cupertino_sliver_persistent_blur_header.dart";
import "package:store/features/shared/page_error.dart";
import "package:store/features/shared/page_loader.dart";
import "package:store/network/dtos/featured_app_dto.dart";

class TodayPage extends ConsumerWidget {
  const TodayPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CupertinoPageScaffold(
      child: ref.watch(featuredAppsProvider).when(
            error: PageError.builder,
            loading: PageLoader.builder,
            data: (featuredApps) => CustomScrollView(
              slivers: [
                const CupertinoSliverPersistentBlurHeader(),
                _buildSliverHeader(context),
                _buildSliverItemList(context, featuredApps),
                SliverToBoxAdapter(
                  child: MediaQuery.of(context).padding.bottom.verticalSpace,
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildSliverHeader(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(16) - const EdgeInsets.only(bottom: 8),
      sliver: SliverToBoxAdapter(
        child: DefaultTextStyle.merge(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      "Today",
                      style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
                    ),
                    16.horizontalSpace,
                    Expanded(
                      child: Text(
                        DateTimeFormatters.dateFullMonth.format(DateTime.now()),
                        style: const TextStyle(
                          fontSize: 24,
                          color: CupertinoColors.systemGrey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              16.horizontalSpace,
              Center(
                child: Container(
                  width: 32,
                  height: 32,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        CupertinoColors.systemGrey2,
                        CupertinoColors.systemGrey,
                      ],
                    ),
                  ),
                  child: const Text(
                    "AK",
                    style: TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSliverItemList(BuildContext context, List<FeaturedAppDto> featuredApps) {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverGrid.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: FeaturedAppItemCard.preferredMaxWidth,
          childAspectRatio: FeaturedAppItemCard.preferredAspectRatio,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
        ),
        itemBuilder: (context, index) => _buildTodayItem(featuredApps[index]),
        itemCount: featuredApps.length,
      ),
    );
  }

  Widget _buildTodayItem(FeaturedAppDto featuredApp) {
    return FeaturedAppItemCard(featuredApp: featuredApp);
  }
}
