import 'package:fpdart/fpdart.dart';

import '../repository/authentication_repository.dart';

class AuthenticationUsecases {
  final AuthenticationRepository _repository;

  const AuthenticationUsecases({
    required AuthenticationRepository repository,
  }) : _repository = repository;

  Future<void> deleteAuthData() async {
    return _repository.deleteAuthData();
  }

  Future<Either<String, String?>> getAuthToken() async {
    return _repository.getAuthToken();
  }

  Future<bool> hasAuthToken() async {
    return _repository.hasAuthToken();
  }

  Future<void> saveAuthToken(String authToken) async {
    return _repository.saveAuthToken(authToken);
  }
}
