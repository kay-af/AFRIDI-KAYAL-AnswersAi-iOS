// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'featured_app_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FeaturedAppDtoImpl _$$FeaturedAppDtoImplFromJson(Map<String, dynamic> json) =>
    _$FeaturedAppDtoImpl(
      id: (json['id'] as num).toInt(),
      keywords: json['keywords'] as String,
      descriptionContent: json['descriptionContent'] as String,
      descriptionFooter: json['descriptionFooter'] as String,
      descriptionHeader: json['descriptionHeader'] as String,
      iconUrl: json['iconUrl'] as String,
      imageUrl: json['imageUrl'] as String,
      title: json['title'] as String,
      hasInappPurchases: json['hasInappPurchases'] as bool,
      prefersDarkText: json['prefersDarkText'] as bool,
    );

Map<String, dynamic> _$$FeaturedAppDtoImplToJson(
        _$FeaturedAppDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'keywords': instance.keywords,
      'descriptionContent': instance.descriptionContent,
      'descriptionFooter': instance.descriptionFooter,
      'descriptionHeader': instance.descriptionHeader,
      'iconUrl': instance.iconUrl,
      'imageUrl': instance.imageUrl,
      'title': instance.title,
      'hasInappPurchases': instance.hasInappPurchases,
      'prefersDarkText': instance.prefersDarkText,
    };
