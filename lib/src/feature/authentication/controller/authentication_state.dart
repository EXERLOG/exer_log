import 'package:freezed_annotation/freezed_annotation.dart';

part 'authentication_state.freezed.dart';

@freezed
class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState.initial() = Initial;

  const factory AuthenticationState.loading() = Loading;

  const factory AuthenticationState.success() = Success;

  const factory AuthenticationState.error({String? message}) = Error;
}
