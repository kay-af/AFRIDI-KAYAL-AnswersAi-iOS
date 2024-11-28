import "package:freezed_annotation/freezed_annotation.dart";

part "featured_app_dto.freezed.dart";
part "featured_app_dto.g.dart";

@freezed
class FeaturedAppDto with _$FeaturedAppDto {
  factory FeaturedAppDto({
    required int id,
    required String keywords,
    required String descriptionContent,
    required String descriptionFooter,
    required String descriptionHeader,
    required String iconUrl,
    required String imageUrl,
    required String title,
    required bool hasInappPurchases,
    required bool prefersDarkText,
  }) = _FeaturedAppDto;

  factory FeaturedAppDto.fromJson(Map<String, dynamic> json) => _$FeaturedAppDtoFromJson(json);
}
