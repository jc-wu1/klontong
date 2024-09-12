part of 'authentication_cubit.dart';

enum AuthStatus {
  unknown,
  authenticated,
  waiting,
  unauthenticated,
}

class AuthenticationState extends Equatable {
  final AuthStatus status;
  final bool isAdmin;
  final String user;

  const AuthenticationState._({
    this.status = AuthStatus.unknown,
    this.isAdmin = false,
    this.user = "",
  });

  const AuthenticationState.authenticated(
    bool isAdmin,
    String user,
  ) : this._(
          status: AuthStatus.authenticated,
          isAdmin: isAdmin,
          user: user,
        );

  const AuthenticationState.waiting()
      : this._(
          status: AuthStatus.waiting,
        );

  const AuthenticationState.unauthenticated()
      : this._(
          status: AuthStatus.unauthenticated,
        );

  @override
  List<Object?> get props => [status, isAdmin, user];
}
