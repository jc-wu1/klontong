part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginSucceed extends LoginState {
  final String response;

  const LoginSucceed(this.response);

  @override
  List<Object> get props => [response];
}

class LoginFailure extends LoginState {
  final String errorModel;

  const LoginFailure(this.errorModel);

  @override
  List<Object> get props => [errorModel];
}
