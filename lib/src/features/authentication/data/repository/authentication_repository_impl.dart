import 'dart:convert';

import 'package:fpdart/fpdart.dart';

import '../../domain/repository/authentication_repository.dart';
import '../datasource/authentication_local_data_source.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationLocalDataSource _localDataSource;

  const AuthenticationRepositoryImpl({
    required AuthenticationLocalDataSource localDataSource,
  }) : _localDataSource = localDataSource;

  @override
  Future<void> saveAuthToken(String authData) async {
    String jsonString = jsonEncode(authData);

    await _localDataSource.saveAuthData(jsonString);
  }

  @override
  Future<Either<String, String?>> getAuthToken() async {
    try {
      final authData = await _localDataSource.getAuthData();
      if (authData != null) {
        return Right(authData);
      } else {
        return const Left("Username atau password tidak ditemukan");
      }
    } catch (e) {
      return const Left("Unknown error");
    }
  }

  @override
  Future<bool> hasAuthToken() async {
    try {
      final authToken = await _localDataSource.getAuthData();
      if (authToken == null) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> deleteAuthData() async {
    await _localDataSource.deleteAuthData();
  }
}
