part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {}

@immutable
class SwitchToDarkModeEvent extends SettingsEvent {}

@immutable
class SwitchToLightModeEvent extends SettingsEvent {}