import "package:flutter/material.dart";
import "package:store/network/dtos/featured_app_dto.dart";

class AppListingPageArguments {
  final FeaturedAppDto featuredApp;
  final Rect forwardItemRect;
  double forwardScaleFactor;
  double reverseScaleFactor;

  AppListingPageArguments({
    required this.featuredApp,
    required this.forwardItemRect,
    required this.forwardScaleFactor,
  }) : reverseScaleFactor = 1.0;
}
