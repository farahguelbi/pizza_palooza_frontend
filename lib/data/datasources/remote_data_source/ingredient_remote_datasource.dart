import 'dart:convert';
import 'package:front/core/errors/exceptions/exceptions.dart';
import 'package:front/core/utils/api_const.dart';
import 'package:http/http.dart' as http;

import '../../models/ingredient_model.dart';

abstract class IngredientsRemoteDataSource {
  Future<List<IngredientModel>> getAllIngredients();
  Future<IngredientModel> getIngredientById(String id);
  Future<List<IngredientModel>> getIngredientsByLayer(String layer);
}

class IngredientsRemoteDataSourceImpl implements IngredientsRemoteDataSource {


  @override
  Future<List<IngredientModel>> getAllIngredients() async {
    final response = await http.get(
      Uri.parse(ApiConst.getAllIngredients),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => IngredientModel.fromJson(data)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<IngredientModel> getIngredientById(String id) async {
    final response = await http.get(
      Uri.parse('${ApiConst.getIngredientById}/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      return IngredientModel.fromJson(jsonResponse);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<IngredientModel>> getIngredientsByLayer(String layer) async {
    final response = await http.get(
      Uri.parse('${ApiConst.getIngredientsByLayer}/$layer'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => IngredientModel.fromJson(data)).toList();
    } else {
      throw ServerException();
    }
  }
}
