import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:share_plus/share_plus.dart";
import "package:store/core/utils.dart";
import "package:store/features/app_listing_page/data/app_listing_provider.dart";
import "package:store/features/app_listing_page/presentation/app_listing_page_arguments.dart";
import "package:store/features/app_listing_page/presentation/featured_app_install_bar.dart";
import "package:store/features/home_page/today_page/presentation/featured_app_item/featured_app_item_card.dart";
import "package:store/features/home_page/today_page/presentation/featured_app_item/featured_app_item_content.dart";
import "package:store/features/home_page/today_page/presentation/featured_app_item/featured_app_item_image.dart";
import "package:store/features/routers/root_router.dart";
import "package:store/features/shared/get_button.dart";
import "package:store/features/shared/page_error.dart";
import "package:store/features/shared/page_loader.dart";
import "package:store/features/shared/shrink_back_scroll_view.dart";
import "package:store/network/dtos/app_listing_dto.dart";
import "package:styled_text/styled_text.dart";

class AppListingPage extends StatefulWidget {
  static const route = "/app";

  final AppListingPageArguments arguments;

  const AppListingPage({required this.arguments, super.key});

  @override
  State<AppListingPage> createState() => _AppListingPageState();
}

class _AppListingPageState extends State<AppListingPage> {
  final _getButtonKey = GlobalKey();

  late final ScrollController _scrollController;
  late ValueNotifier<bool> _showInstallBarNotifier;

  @override
  void setState(VoidCallback fn) {
    if (!mounted) return;
    super.setState(fn);
  }

  @override
  void initState() {
    super.initState();
    _showInstallBarNotifier = ValueNotifier(false);
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (!_scrollController.hasClients) return;
      const headerAspectRatio = FeaturedAppItemCard.preferredAspectRatio;
      final headerWidth = MediaQuery.of(context).size.width;
      final headerHeight = headerWidth / headerAspectRatio;
      final maxScrollExtent = _scrollController.position.maxScrollExtent;

      final showInstallBar = _scrollController.offset > headerHeight &&
          _scrollController.offset < maxScrollExtent - MediaQuery.of(context).padding.bottom - 72;

      if (!mounted) return;
      _showInstallBarNotifier.value = showInstallBar;
    });
  }

  @override
  void dispose() {
    _showInstallBarNotifier.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: MediaQuery.of(context).platformBrightness == Brightness.light
          ? CupertinoColors.systemBackground
          : CupertinoColors.darkBackgroundGray,
      child: Stack(
        fit: StackFit.expand,
        children: [
          _buildPage(context),
          _buildCloseButton(context),
          _buildAppInstallBar(context),
        ],
      ),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return Positioned(
      right: 16,
      top: MediaQuery.of(context).padding.top,
      child: AnimatedBuilder(
        animation: _scrollController,
        builder: (context, child) => AnimatedOpacity(
          opacity: _scrollController.hasClients && _scrollController.offset < -16 ? 0.0 : 1.0,
          duration: Durations.short3,
          child: child,
        ),
        child: CupertinoButton(
          minSize: 0,
          padding: const EdgeInsets.all(6),
          borderRadius: BorderRadius.circular(32),
          color: const CupertinoDynamicColor.withBrightness(
            color: CupertinoColors.black,
            darkColor: CupertinoColors.white,
          ),
          onPressed: () => rootNavigator.maybePop(),
          child: const Icon(CupertinoIcons.xmark, size: 20),
        ),
      ),
    );
  }

  Widget _buildPage(BuildContext context) {
    return ShrinkBackScrollView(
      controller: _scrollController,
      child: Column(
        children: [
          _buildHeader(context),
          _buildContent(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Hero(
      tag: widget.arguments.featuredApp.id,
      child: AnimatedBuilder(
        animation: ModalRoute.of(context)!.animation!,
        builder: (_, child) {
          final radiusMultiplier = 1.0 - ModalRoute.of(context)!.animation!.value;
          return ClipRRect(
            borderRadius: BorderRadius.circular(FeaturedAppItemCard.cardRadius * radiusMultiplier),
            child: child,
          );
        },
        child: AspectRatio(
          aspectRatio: FeaturedAppItemCard.preferredAspectRatio,
          child: Stack(
            fit: StackFit.expand,
            children: [
              FeaturedAppItemImage(featuredApp: widget.arguments.featuredApp),
              FeaturedAppItemContent(
                featuredApp: widget.arguments.featuredApp,
                getButtonKey: _getButtonKey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) =>
          ref.watch(appListingProvider(widget.arguments.featuredApp.id)).when(
                data: (featuredApp) => _buildWithData(context, featuredApp),
                error: PageError.builder,
                loading: PageLoader.builder,
              ),
    );
  }

  Widget _buildWithData(BuildContext context, AppListingDto appListing) {
    final defaultStyle = CupertinoTheme.of(context).textTheme.textStyle.copyWith(
          color: CupertinoTheme.of(context).textTheme.textStyle.color?.withOpacity(0.6),
          height: 1.5,
        );

    final tags = {
      "b": StyledTextTag(
        style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(fontWeight: FontWeight.bold),
      ),
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ...ListUtils.insertBetweenEvery(
                appListing.longDescriptionPre
                    .map(
                      (desc) => StyledText(
                        text: desc,
                        tags: tags,
                        style: defaultStyle,
                      ),
                    )
                    .toList(),
                16.verticalSpace,
              ),
              24.verticalSpace,
              Row(
                children: ListUtils.insertBetweenEvery(
                  appListing.screenshotUrls
                      .map(
                        (url) => Expanded(
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 1,
                                  color: CupertinoColors.systemGrey.withOpacity(0.1),
                                ),
                              ],
                            ),
                            child: Image.asset(url),
                          ),
                        ),
                      )
                      .toList(),
                  16.horizontalSpace,
                ),
              ),
              24.verticalSpace,
              ...ListUtils.insertBetweenEvery(
                appListing.longDescriptionPost
                    .map(
                      (desc) => StyledText(
                        text: desc,
                        tags: tags,
                        style: defaultStyle,
                      ),
                    )
                    .toList(),
                16.verticalSpace,
              ),
            ],
          ),
        ),
        16.verticalSpace,
        _buildAppHighlight(context),
        72.verticalSpace,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: CupertinoButton(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              color: const CupertinoDynamicColor.withBrightness(
                color: CupertinoColors.lightBackgroundGray,
                darkColor: Color(0xFF242424),
              ),
              onPressed: () => _onTapShare(appListing),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    CupertinoIcons.share,
                    color: MediaQuery.of(context).platformBrightness == Brightness.light
                        ? CupertinoTheme.of(context).primaryColor
                        : CupertinoColors.white,
                    size: 18,
                  ),
                  8.horizontalSpace,
                  Text(
                    "Share Story",
                    style: TextStyle(
                      color: MediaQuery.of(context).platformBrightness == Brightness.light
                          ? CupertinoTheme.of(context).primaryColor
                          : CupertinoColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        72.verticalSpace,
        MediaQuery.of(context).padding.bottom.verticalSpace,
      ],
    );
  }

  void _onTapShare(AppListingDto appListing) async {
    await Share.shareUri(Uri.parse(appListing.storyUrl));
  }

  Widget _buildAppInstallBar(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _showInstallBarNotifier,
      builder: (context, onScreen, child) => FeaturedAppInstallBar(
        onScreen: onScreen,
        featuredApp: widget.arguments.featuredApp,
      ),
    );
  }

  Widget _buildAppHighlight(BuildContext context) {
    return Container(
      color: MediaQuery.of(context).platformBrightness == Brightness.light
          ? CupertinoColors.lightBackgroundGray
          : const Color(0xFF242424),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 32,
      ),
      child: Column(
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox.square(
                dimension: 86,
                child: Image.asset(widget.arguments.featuredApp.iconUrl),
              ),
            ),
          ),
          16.verticalSpace,
          Text(
            widget.arguments.featuredApp.title,
            style: CupertinoTheme.of(context)
                .textTheme
                .textStyle
                .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          8.verticalSpace,
          Text(
            widget.arguments.featuredApp.title,
            style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                  fontSize: 16,
                  color: CupertinoColors.systemGrey,
                ),
          ),
          32.verticalSpace,
          GetButton(
            hasInAppPurchases: widget.arguments.featuredApp.hasInappPurchases,
            prefersDarkText: null,
            centeredProgress: true,
          ),
        ],
      ),
    );
  }
}
