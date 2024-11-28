// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_listing_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AppListingDtoImpl _$$AppListingDtoImplFromJson(Map<String, dynamic> json) =>
    _$AppListingDtoImpl(
      longDescriptionPre: (json['longDescriptionPre'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      screenshotUrls: (json['screenshotUrls'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      longDescriptionPost: (json['longDescriptionPost'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      storyUrl: json['storyUrl'] as String,
    );

Map<String, dynamic> _$$AppListingDtoImplToJson(_$AppListingDtoImpl instance) =>
    <String, dynamic>{
      'longDescriptionPre': instance.longDescriptionPre,
      'screenshotUrls': instance.screenshotUrls,
      'longDescriptionPost': instance.longDescriptionPost,
      'storyUrl': instance.storyUrl,
    };
