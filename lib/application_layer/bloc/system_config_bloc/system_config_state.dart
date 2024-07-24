part of 'system_config_bloc.dart';

@immutable
abstract class SystemConfigBlocState {}

class ConfigLoading extends SystemConfigBlocState {}

class ConfigSuccess extends SystemConfigBlocState {
  final String mobileRegex;
  final String passwordRegex;
  final String incorrectPasswordMessage;
  final String countryCode;

  ConfigSuccess({
    required this.mobileRegex,
    required this.passwordRegex,
    required this.incorrectPasswordMessage,
    required this.countryCode,
  });
}

class ConfigError extends SystemConfigBlocState {
  final String message;

  ConfigError({required this.message});
}

class NavigationsBlocInitial extends SystemConfigBlocState {}
