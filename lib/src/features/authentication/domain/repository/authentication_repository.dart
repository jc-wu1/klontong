import 'package:fpdart/fpdart.dart';

abstract class AuthenticationRepository {
  Future<void> saveAuthToken(String authData);

  Future<Either<String, String?>> getAuthToken();

  Future<bool> hasAuthToken();

  Future<void> deleteAuthData();
}
