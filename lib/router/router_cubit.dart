import 'package:flutter_bloc/flutter_bloc.dart';
import '/router/router_state.dart';

class RouterCubit extends Cubit<RouterState> {
  RouterCubit() : super(const LoginPageState());

  void goToLoginPage([String? text]) => emit(LoginPageState(text));

  void goToMainPage([String? text]) => emit(MainPageState(text));

  void goToWelcomePage([String? text]) => emit(WelcomePageState(text));

  void goToRegistrationEmployerPage([String? text]) =>
      emit(RegistrationPageState(text));

  void goToRegistrationModelPage([String? text]) =>
      emit(RegistrationModelPageState(text));

  void popExtra() {
    if (state is MainPageState) {
      goToMainPage();
    }
    if (state is RegistrationPageState) {
      goToWelcomePage();
    }
    if (state is RegistrationModelPageState) {
      goToWelcomePage();
    } else {
      goToLoginPage();
    }
  }
}
