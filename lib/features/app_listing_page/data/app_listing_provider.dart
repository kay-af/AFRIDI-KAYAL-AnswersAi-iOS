import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:store/network/mock_api.dart";

final appListingProvider = FutureProvider.family((ref, int id) => MockApi.fetchAppListing(id));
