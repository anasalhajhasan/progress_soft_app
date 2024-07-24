part of 'system_config_bloc.dart';

@immutable
abstract class SystemConfigEvent {}

class SystemConfigLoadEvent extends SystemConfigEvent {
  SystemConfigLoadEvent();
}
