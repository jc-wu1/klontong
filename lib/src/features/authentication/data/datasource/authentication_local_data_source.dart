import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants.dart';

abstract class AuthenticationLocalDataSource {
  Future<void> saveAuthData(String authData);

  Future<String?> getAuthData();

  Future<void> deleteAuthData();
}

class AuthenticationLocalDataSourceImpl
    implements AuthenticationLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthenticationLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<String?> getAuthData() async {
    final String? authData = sharedPreferences.getString(
      authTokenKey,
    );

    return authData;
  }

  @override
  Future<void> saveAuthData(String authData) async {
    sharedPreferences.setString(authTokenKey, authData);
  }

  @override
  Future<void> deleteAuthData() async {
    sharedPreferences.remove(authTokenKey);
  }
}
