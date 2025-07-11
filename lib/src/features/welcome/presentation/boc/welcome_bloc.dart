import 'package:bloc/bloc.dart';
import 'package:devprompt/src/features/welcome/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:devprompt/src/features/welcome/welcome_injection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'welcome_event.dart';
part 'welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(WelcomeInitialState()) {
    final SignInWithGoogleUsecase signInWithGoogleUsecase =
        sl<SignInWithGoogleUsecase>();
    on<SignInWithGoogleEvent>((event, emit) async {
      emit(WelcomeLoadingState());
      try {
        final user = await signInWithGoogleUsecase();
        user != null
            ? emit(WelcomeSuccessState(user))
            : emit(WelcomeInitialState());
      } catch (e) {
        emit(WelcomeFailureState(e.toString()));
      }
    });
  }
}
