import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsLightModeState()) {
    on<SwitchToDarkModeEvent>((event, emit) {
      emit(SettingsDarkModeState());
    });

    on<SwitchToLightModeEvent>((event, emit) {
      emit(SettingsLightModeState());
    });
  }
}
