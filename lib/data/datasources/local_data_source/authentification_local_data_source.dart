import 'dart:convert';
import 'package:front/data/datasources/local_data_source/settings_local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utils/string_const.dart';
import '../../../core/errors/exceptions/exceptions.dart';
import '../../models/token_model.dart';

abstract class AuthenticationLocalDataSource {
  Future<void> saveUserInformations(TokenModel token);
  Future<TokenModel?> getUserInformations();
  Future<void> logout();
  
}

class AuthenticationLocalDataSourceImpl
    implements AuthenticationLocalDataSource {
       Future<TokenModel?>get token async {
    return await AuthenticationLocalDataSourceImpl().getUserInformations();
  }
   Future<String>get locale async {
    return await SettingsLocalDataSourcImpl().loadLocale();
  }
  @override
  Future<void> saveUserInformations(TokenModel token) async {
    try {
      final sp = await SharedPreferences.getInstance();
      sp.setString(StringConst.SP_TOKEN_KEY, json.encode(token.toJson()));
    } catch (e) {
      throw LocalStorageException();
    }
  }

  @override
  Future<TokenModel?> getUserInformations() async {
    try {
      final sp = await SharedPreferences.getInstance();
      print(sp.getString("access"));
      if( sp.getString(StringConst.SP_TOKEN_KEY)=='' || sp.getString(StringConst.SP_TOKEN_KEY)==null ){
       return null;

      }
       final data = sp.getString(StringConst.SP_TOKEN_KEY);
       TokenModel token = TokenModel.fromJson(json.decode(data.toString()));
      return token;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      final sp = await SharedPreferences.getInstance();
      sp.setString(StringConst.SP_TOKEN_KEY, '');
      print('logout');
      print(sp.getString("access"));
    } catch (e) {
      throw LocalStorageException();
    }
  }




}