import "package:flutter/material.dart";

abstract class BaseRouter {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  NavigatorState get navigator => navigatorKey.currentState!;

  String get initialRoute;

  Route onGenerateRoute(RouteSettings settings);
}
