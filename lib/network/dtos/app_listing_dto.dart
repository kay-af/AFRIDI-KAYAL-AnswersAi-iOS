import "package:freezed_annotation/freezed_annotation.dart";

part "app_listing_dto.freezed.dart";
part "app_listing_dto.g.dart";

@freezed
class AppListingDto with _$AppListingDto {
  factory AppListingDto({
    required List<String> longDescriptionPre,
    required List<String> screenshotUrls,
    required List<String> longDescriptionPost,
    required String storyUrl,
  }) = _AppListingDto;

  factory AppListingDto.fromJson(Map<String, dynamic> json) => _$AppListingDtoFromJson(json);
}
