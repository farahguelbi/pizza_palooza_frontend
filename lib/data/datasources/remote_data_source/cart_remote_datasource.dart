import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:front/data/datasources/local_data_source/authentification_local_data_source.dart';
import 'package:front/data/datasources/local_data_source/settings_local_data_source.dart';
import 'package:front/data/datasources/remote_data_source/user_remote_datasource.dart';
import 'package:front/data/models/token_model.dart';
import 'package:http/http.dart' as http;
import 'package:front/core/errors/exceptions/exceptions.dart';
import 'package:front/core/utils/api_const.dart';
import '../../models/cart_model.dart';

abstract class CartRemoteDataSource {
  Future<CartModel> createOrGetCart(String userId);
  Future<void> addSaleToCart(String userId, Map<String, dynamic> saleData);
  Future<CartModel> getCart(String userId);
  Future<void> removeSaleFromCart(String userId, String saleId);
  Future<void> clearCart(String userId);
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final http.Client client;
   Future<TokenModel?>get token async {
    return await AuthenticationLocalDataSourceImpl().getUserInformations();
  }
     Future<String>get locale async {
    return await SettingsLocalDataSourcImpl().loadLocale();
  }

    Future<void> verifyToken () async {
     return await token.then((value) async{
      if(value!.expiryDate.isBefore(DateTime.now())){
        
      }
    });
  }
   final dio = Dio(BaseOptions(
  baseUrl: ApiConst.baseUrl,
  contentType: Headers.jsonContentType,
  validateStatus: (int? status) {
    return status != null;
  },
));
  CartRemoteDataSourceImpl({required this.client});

  @override
  Future<CartModel> createOrGetCart(String userId) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConst.createOrGetCart),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'userId': userId}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return CartModel.fromJson(jsonResponse);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> addSaleToCart(String userId, Map<String, dynamic> saleData) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConst.addSaleToCart),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'userId': userId, ...saleData}),
      );

      if (response.statusCode != 200) {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<CartModel> getCart(String userId) async {
    try {
      final response = await http.get(
        Uri.parse(ApiConst.getCart(userId)),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return CartModel.fromJson(jsonResponse);
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> removeSaleFromCart(String userId, String saleId) async {
    try {
      final response = await http.delete(
        Uri.parse(ApiConst.removeSaleFromCart),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'userId': userId, 'saleId': saleId}),
      );

      if (response.statusCode != 200) {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> clearCart(String userId) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConst.clearCart),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'userId': userId}),
      );

      if (response.statusCode != 200) {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}


