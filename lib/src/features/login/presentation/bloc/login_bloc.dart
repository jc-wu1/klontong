import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../authentication/bloc/authentication_cubit.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(
    this.authCubit,
  ) : super(const LoginInitial()) {
    on<LoginUserEvent>(_onLoginUserEvent);
  }

  final AuthenticationCubit authCubit;

  Future<void> _onLoginUserEvent(
    LoginUserEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(const LoginLoading());
    try {
      if (event.email == 'usertesting' && event.password == 'usertesting') {
        authCubit.login(
          event.email,
        );
        emit(LoginSucceed(event.email));
      } else if (event.email == 'admin' && event.password == 'admin') {
        authCubit.login(
          event.email,
        );
        emit(LoginSucceed(event.email));
      } else {
        emit(
          const LoginFailure("Username dan password tidak ditemukan"),
        );
      }
    } catch (e) {
      emit(
        const LoginFailure("Username dan password tidak ditemukan"),
      );
    }
  }
}
