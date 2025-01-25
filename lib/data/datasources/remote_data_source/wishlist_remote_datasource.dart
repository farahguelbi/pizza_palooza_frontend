import 'dart:convert';

import 'package:front/core/errors/exceptions/exceptions.dart';
import 'package:front/core/utils/api_const.dart';
import 'package:http/http.dart' as http;
import '../../models/wishlist_model.dart';

abstract class WishlistRemoteDataSource {
  Future<void> addToWishlist({required String userId, required String pizzaId});
  Future<void> removeFromWishlist({required String userId, required String pizzaId});
  Future<WishlistModel> getWishlist({required String userId});
}

class WishlistRemoteDataSourceImpl implements WishlistRemoteDataSource {


  @override
  Future<void> addToWishlist({required String userId, required String pizzaId}) async {
    final response = await http.post(
      Uri.parse(ApiConst.addToWishlist),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'userId': userId, 'pizzaId': pizzaId}),
    );

    if (response.statusCode != 200) {
      throw ServerException();
    }
  }

  @override
  Future<void> removeFromWishlist({required String userId, required String pizzaId}) async {
    final response = await http.post(
      Uri.parse(ApiConst.removeFromWishlist),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'userId': userId, 'pizzaId': pizzaId}),
    );

    if (response.statusCode != 200) {
      throw ServerException();
    }
  }

  @override
  Future<WishlistModel> getWishlist({required String userId}) async {
    final response = await http.get(
      Uri.parse(ApiConst.getWishlist(userId)),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      return WishlistModel.fromJson(jsonResponse);
    } else {
      throw ServerException();
    }
  }
}
