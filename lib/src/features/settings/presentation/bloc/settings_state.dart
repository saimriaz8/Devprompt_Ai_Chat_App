part of 'settings_bloc.dart';

@immutable
sealed class SettingsState {}

@immutable
class SettingsLightModeState extends SettingsState {}

@immutable
class SettingsDarkModeState extends SettingsState {}
