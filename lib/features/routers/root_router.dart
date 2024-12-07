import "dart:ui";

import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:store/core/base_router.dart";
import "package:store/core/utils.dart";
import "package:store/features/app_listing_page/presentation/app_listing_page.dart";
import "package:store/features/app_listing_page/presentation/app_listing_page_arguments.dart";
import "package:store/features/home_page/presentation/home_page.dart";
import "package:store/features/home_page/today_page/presentation/featured_app_item/featured_app_item_card.dart";

class UnknownRootRouteException implements Exception {
  final String? routeName;
  const UnknownRootRouteException(this.routeName);

  @override
  String toString() => "$routeName did not match with any defined page routes";
}

class RootRouter extends BaseRouter {
  @override
  String get initialRoute => HomePage.route;

  @override
  Route onGenerateRoute(RouteSettings settings) {
    Widget? screen;
    AppListingPageArguments? appListingPageArguments;

    switch (settings.name) {
      case HomePage.route:
        screen = const HomePage();
        break;
      case AppListingPage.route:
        final arguments = settings.arguments as AppListingPageArguments;
        appListingPageArguments = arguments;
        screen = AppListingPage(arguments: arguments);
        break;
    }

    if (screen == null) {
      throw UnknownRootRouteException(settings.name);
    }

    switch (settings.name) {
      case AppListingPage.route:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => screen!,
          opaque: false,
          transitionDuration: Durations.medium2,
          reverseTransitionDuration: Durations.medium4,
          transitionsBuilder: (context, animation, secondaryAnimation, child) => AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              final screenSize = MediaQuery.of(context).size;
              final fullScreenRect = Rect.fromLTWH(
                0,
                0,
                screenSize.width,
                screenSize.height,
              );

              final calculatedRect = Rect.lerp(
                RectUtils.scaleCentered(
                  appListingPageArguments!.forwardItemRect,
                  appListingPageArguments.forwardScaleFactor,
                ),
                RectUtils.scaleCentered(
                  fullScreenRect,
                  appListingPageArguments.reverseScaleFactor,
                ),
                Curves.easeInOut.transform(animation.value),
              )!;

              return BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: animation.value * 50,
                  sigmaY: animation.value * 50,
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Positioned.fromRect(
                      rect: calculatedRect,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          (1 - animation.value) * FeaturedAppItemCard.cardRadius,
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: child!,
                      ),
                    ),
                  ],
                ),
              );
            },
            child: child,
          ),
        );
      default:
        return CupertinoPageRoute(builder: (context) => screen!);
    }
  }
}

final rootRouter = RootRouter();
NavigatorState get rootNavigator => rootRouter.navigator;
