import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../domain/usecase/authentication_usecases.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AuthenticationUsecases _usecases;
  AuthenticationCubit({required AuthenticationUsecases usecases})
      : _usecases = usecases,
        super(
          const AuthenticationState.unauthenticated(),
        );

  void login(String authData) async {
    _usecases.saveAuthToken(authData);

    if (authData == "admin") {
      return emit(AuthenticationState.authenticated(true, authData));
    }
    return emit(AuthenticationState.authenticated(false, authData));
  }

  void logout() async {
    _usecases.deleteAuthData();
    emit(const AuthenticationState.unauthenticated());
  }

  void checkAuth() async {
    emit(const AuthenticationState.waiting());

    /// seolah olah delay ke server.
    Future.delayed(
      const Duration(seconds: 2),
      () async {
        final authData = await _usecases.getAuthToken();

        await authData.fold(
          (l) async {
            emit(const AuthenticationState.unauthenticated());
          },
          (r) async {
            if (r == "\"admin\"") {
              return emit(AuthenticationState.authenticated(
                true,
                r!,
              ));
            } else {
              return emit(AuthenticationState.authenticated(
                false,
                r!,
              ));
            }
          },
        );
      },
    );
  }
}
