import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:store/network/dtos/featured_app_dto.dart";
import "package:store/network/mock_api.dart";

final featuredAppsProvider = FutureProvider<List<FeaturedAppDto>>(
  (ref) => MockApi.fetchFeaturedApps(),
);
