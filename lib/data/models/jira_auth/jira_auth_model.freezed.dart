// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'jira_auth_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JiraAuthModel {

@JsonKey(name: 'apiToken') String get apiToken;@JsonKey(name: 'email') String get email;@JsonKey(name: 'workspace') String get workspace;
/// Create a copy of JiraAuthModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JiraAuthModelCopyWith<JiraAuthModel> get copyWith => _$JiraAuthModelCopyWithImpl<JiraAuthModel>(this as JiraAuthModel, _$identity);

  /// Serializes this JiraAuthModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JiraAuthModel&&(identical(other.apiToken, apiToken) || other.apiToken == apiToken)&&(identical(other.email, email) || other.email == email)&&(identical(other.workspace, workspace) || other.workspace == workspace));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,apiToken,email,workspace);

@override
String toString() {
  return 'JiraAuthModel(apiToken: $apiToken, email: $email, workspace: $workspace)';
}


}

/// @nodoc
abstract mixin class $JiraAuthModelCopyWith<$Res>  {
  factory $JiraAuthModelCopyWith(JiraAuthModel value, $Res Function(JiraAuthModel) _then) = _$JiraAuthModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'apiToken') String apiToken,@JsonKey(name: 'email') String email,@JsonKey(name: 'workspace') String workspace
});




}
/// @nodoc
class _$JiraAuthModelCopyWithImpl<$Res>
    implements $JiraAuthModelCopyWith<$Res> {
  _$JiraAuthModelCopyWithImpl(this._self, this._then);

  final JiraAuthModel _self;
  final $Res Function(JiraAuthModel) _then;

/// Create a copy of JiraAuthModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? apiToken = null,Object? email = null,Object? workspace = null,}) {
  return _then(_self.copyWith(
apiToken: null == apiToken ? _self.apiToken : apiToken // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,workspace: null == workspace ? _self.workspace : workspace // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [JiraAuthModel].
extension JiraAuthModelPatterns on JiraAuthModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JiraAuthModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JiraAuthModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JiraAuthModel value)  $default,){
final _that = this;
switch (_that) {
case _JiraAuthModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JiraAuthModel value)?  $default,){
final _that = this;
switch (_that) {
case _JiraAuthModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'apiToken')  String apiToken, @JsonKey(name: 'email')  String email, @JsonKey(name: 'workspace')  String workspace)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JiraAuthModel() when $default != null:
return $default(_that.apiToken,_that.email,_that.workspace);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'apiToken')  String apiToken, @JsonKey(name: 'email')  String email, @JsonKey(name: 'workspace')  String workspace)  $default,) {final _that = this;
switch (_that) {
case _JiraAuthModel():
return $default(_that.apiToken,_that.email,_that.workspace);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'apiToken')  String apiToken, @JsonKey(name: 'email')  String email, @JsonKey(name: 'workspace')  String workspace)?  $default,) {final _that = this;
switch (_that) {
case _JiraAuthModel() when $default != null:
return $default(_that.apiToken,_that.email,_that.workspace);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JiraAuthModel implements JiraAuthModel {
  const _JiraAuthModel({@JsonKey(name: 'apiToken') required this.apiToken, @JsonKey(name: 'email') required this.email, @JsonKey(name: 'workspace') required this.workspace});
  factory _JiraAuthModel.fromJson(Map<String, dynamic> json) => _$JiraAuthModelFromJson(json);

@override@JsonKey(name: 'apiToken') final  String apiToken;
@override@JsonKey(name: 'email') final  String email;
@override@JsonKey(name: 'workspace') final  String workspace;

/// Create a copy of JiraAuthModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JiraAuthModelCopyWith<_JiraAuthModel> get copyWith => __$JiraAuthModelCopyWithImpl<_JiraAuthModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JiraAuthModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JiraAuthModel&&(identical(other.apiToken, apiToken) || other.apiToken == apiToken)&&(identical(other.email, email) || other.email == email)&&(identical(other.workspace, workspace) || other.workspace == workspace));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,apiToken,email,workspace);

@override
String toString() {
  return 'JiraAuthModel(apiToken: $apiToken, email: $email, workspace: $workspace)';
}


}

/// @nodoc
abstract mixin class _$JiraAuthModelCopyWith<$Res> implements $JiraAuthModelCopyWith<$Res> {
  factory _$JiraAuthModelCopyWith(_JiraAuthModel value, $Res Function(_JiraAuthModel) _then) = __$JiraAuthModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'apiToken') String apiToken,@JsonKey(name: 'email') String email,@JsonKey(name: 'workspace') String workspace
});




}
/// @nodoc
class __$JiraAuthModelCopyWithImpl<$Res>
    implements _$JiraAuthModelCopyWith<$Res> {
  __$JiraAuthModelCopyWithImpl(this._self, this._then);

  final _JiraAuthModel _self;
  final $Res Function(_JiraAuthModel) _then;

/// Create a copy of JiraAuthModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? apiToken = null,Object? email = null,Object? workspace = null,}) {
  return _then(_JiraAuthModel(
apiToken: null == apiToken ? _self.apiToken : apiToken // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,workspace: null == workspace ? _self.workspace : workspace // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
