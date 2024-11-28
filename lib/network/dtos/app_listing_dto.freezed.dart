// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_listing_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AppListingDto _$AppListingDtoFromJson(Map<String, dynamic> json) {
  return _AppListingDto.fromJson(json);
}

/// @nodoc
mixin _$AppListingDto {
  List<String> get longDescriptionPre => throw _privateConstructorUsedError;
  List<String> get screenshotUrls => throw _privateConstructorUsedError;
  List<String> get longDescriptionPost => throw _privateConstructorUsedError;
  String get storyUrl => throw _privateConstructorUsedError;

  /// Serializes this AppListingDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AppListingDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppListingDtoCopyWith<AppListingDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppListingDtoCopyWith<$Res> {
  factory $AppListingDtoCopyWith(
          AppListingDto value, $Res Function(AppListingDto) then) =
      _$AppListingDtoCopyWithImpl<$Res, AppListingDto>;
  @useResult
  $Res call(
      {List<String> longDescriptionPre,
      List<String> screenshotUrls,
      List<String> longDescriptionPost,
      String storyUrl});
}

/// @nodoc
class _$AppListingDtoCopyWithImpl<$Res, $Val extends AppListingDto>
    implements $AppListingDtoCopyWith<$Res> {
  _$AppListingDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppListingDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? longDescriptionPre = null,
    Object? screenshotUrls = null,
    Object? longDescriptionPost = null,
    Object? storyUrl = null,
  }) {
    return _then(_value.copyWith(
      longDescriptionPre: null == longDescriptionPre
          ? _value.longDescriptionPre
          : longDescriptionPre // ignore: cast_nullable_to_non_nullable
              as List<String>,
      screenshotUrls: null == screenshotUrls
          ? _value.screenshotUrls
          : screenshotUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      longDescriptionPost: null == longDescriptionPost
          ? _value.longDescriptionPost
          : longDescriptionPost // ignore: cast_nullable_to_non_nullable
              as List<String>,
      storyUrl: null == storyUrl
          ? _value.storyUrl
          : storyUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppListingDtoImplCopyWith<$Res>
    implements $AppListingDtoCopyWith<$Res> {
  factory _$$AppListingDtoImplCopyWith(
          _$AppListingDtoImpl value, $Res Function(_$AppListingDtoImpl) then) =
      __$$AppListingDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String> longDescriptionPre,
      List<String> screenshotUrls,
      List<String> longDescriptionPost,
      String storyUrl});
}

/// @nodoc
class __$$AppListingDtoImplCopyWithImpl<$Res>
    extends _$AppListingDtoCopyWithImpl<$Res, _$AppListingDtoImpl>
    implements _$$AppListingDtoImplCopyWith<$Res> {
  __$$AppListingDtoImplCopyWithImpl(
      _$AppListingDtoImpl _value, $Res Function(_$AppListingDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppListingDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? longDescriptionPre = null,
    Object? screenshotUrls = null,
    Object? longDescriptionPost = null,
    Object? storyUrl = null,
  }) {
    return _then(_$AppListingDtoImpl(
      longDescriptionPre: null == longDescriptionPre
          ? _value._longDescriptionPre
          : longDescriptionPre // ignore: cast_nullable_to_non_nullable
              as List<String>,
      screenshotUrls: null == screenshotUrls
          ? _value._screenshotUrls
          : screenshotUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      longDescriptionPost: null == longDescriptionPost
          ? _value._longDescriptionPost
          : longDescriptionPost // ignore: cast_nullable_to_non_nullable
              as List<String>,
      storyUrl: null == storyUrl
          ? _value.storyUrl
          : storyUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AppListingDtoImpl implements _AppListingDto {
  _$AppListingDtoImpl(
      {required final List<String> longDescriptionPre,
      required final List<String> screenshotUrls,
      required final List<String> longDescriptionPost,
      required this.storyUrl})
      : _longDescriptionPre = longDescriptionPre,
        _screenshotUrls = screenshotUrls,
        _longDescriptionPost = longDescriptionPost;

  factory _$AppListingDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppListingDtoImplFromJson(json);

  final List<String> _longDescriptionPre;
  @override
  List<String> get longDescriptionPre {
    if (_longDescriptionPre is EqualUnmodifiableListView)
      return _longDescriptionPre;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_longDescriptionPre);
  }

  final List<String> _screenshotUrls;
  @override
  List<String> get screenshotUrls {
    if (_screenshotUrls is EqualUnmodifiableListView) return _screenshotUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_screenshotUrls);
  }

  final List<String> _longDescriptionPost;
  @override
  List<String> get longDescriptionPost {
    if (_longDescriptionPost is EqualUnmodifiableListView)
      return _longDescriptionPost;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_longDescriptionPost);
  }

  @override
  final String storyUrl;

  @override
  String toString() {
    return 'AppListingDto(longDescriptionPre: $longDescriptionPre, screenshotUrls: $screenshotUrls, longDescriptionPost: $longDescriptionPost, storyUrl: $storyUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppListingDtoImpl &&
            const DeepCollectionEquality()
                .equals(other._longDescriptionPre, _longDescriptionPre) &&
            const DeepCollectionEquality()
                .equals(other._screenshotUrls, _screenshotUrls) &&
            const DeepCollectionEquality()
                .equals(other._longDescriptionPost, _longDescriptionPost) &&
            (identical(other.storyUrl, storyUrl) ||
                other.storyUrl == storyUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_longDescriptionPre),
      const DeepCollectionEquality().hash(_screenshotUrls),
      const DeepCollectionEquality().hash(_longDescriptionPost),
      storyUrl);

  /// Create a copy of AppListingDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppListingDtoImplCopyWith<_$AppListingDtoImpl> get copyWith =>
      __$$AppListingDtoImplCopyWithImpl<_$AppListingDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppListingDtoImplToJson(
      this,
    );
  }
}

abstract class _AppListingDto implements AppListingDto {
  factory _AppListingDto(
      {required final List<String> longDescriptionPre,
      required final List<String> screenshotUrls,
      required final List<String> longDescriptionPost,
      required final String storyUrl}) = _$AppListingDtoImpl;

  factory _AppListingDto.fromJson(Map<String, dynamic> json) =
      _$AppListingDtoImpl.fromJson;

  @override
  List<String> get longDescriptionPre;
  @override
  List<String> get screenshotUrls;
  @override
  List<String> get longDescriptionPost;
  @override
  String get storyUrl;

  /// Create a copy of AppListingDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppListingDtoImplCopyWith<_$AppListingDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
