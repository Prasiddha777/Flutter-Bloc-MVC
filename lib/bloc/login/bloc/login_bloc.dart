import 'package:bloc_mvc/repository/auth/login_repository.dart';
import 'package:bloc_mvc/services/session_manager/session_controller.dart';
import 'package:bloc_mvc/utils/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginStates> {
  LoginRepository loginRepository;
  LoginBloc({required this.loginRepository}) : super(const LoginStates()) {
    on<EmailChanged>(onEmailChanged);
    on<PasswordChanged>(onPasswordChanged);
    on<LoginApi>(_loginApi);
  }

  void onEmailChanged(EmailChanged event, Emitter<LoginStates> emit) {
    emit(state.copyWith(email: event.email));
  }

  void onPasswordChanged(PasswordChanged event, Emitter<LoginStates> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _loginApi(LoginApi event, Emitter<LoginStates> emit) async {
    emit(state.copyWith(postApiStatus: PostApiStatus.loading));

    Map data = {
      "email": state.email,
      "password": state.password,
    };
    await loginRepository.loginApi(data).then(
      (value) async {
        if (value.error.isEmpty) {
          await SessionController().saveUserInPreferences(value);
          await SessionController().getUserFromPreferences();

          emit(state.copyWith(error: 'Success', postApiStatus: PostApiStatus.success));
        } else {
          emit(state.copyWith(
              error: value.error.toString(), postApiStatus: PostApiStatus.error));
        }
      },
    ).onError((error, stackTrace) {
      emit(state.copyWith(error: error.toString(), postApiStatus: PostApiStatus.error));
    });
  }
}
