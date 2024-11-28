import "package:flutter/cupertino.dart";
import "package:store/core/base_router.dart";
import "package:store/features/app_listing_page/presentation/app_listing_page.dart";
import "package:store/features/app_listing_page/presentation/app_listing_page_arguments.dart";
import "package:store/features/home_page/presentation/home_page.dart";

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

    switch (settings.name) {
      case HomePage.route:
        screen = const HomePage();
        break;
      case AppListingPage.route:
        screen = AppListingPage(arguments: settings.arguments as AppListingPageArguments);
        break;
    }

    if (screen == null) {
      throw UnknownRootRouteException(settings.name);
    }

    switch (settings.name) {
      case AppListingPage.route:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => screen!,
          transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(
            opacity: animation,
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
