import 'dart:convert';
import 'package:front/data/models/pizzaCustom_model.dart';
import 'package:front/domain/entities/ingredient.dart';
import 'package:http/http.dart' as http;
import 'package:front/core/errors/exceptions/exceptions.dart';
import 'package:front/core/utils/api_const.dart';

abstract class PizzaCustomRemoteDataSource {
  Future<List<PizzacustomModel>> getAllCustomPizzas();
  Future<PizzacustomModel> getCustomPizzaById(String id);
  Future<void> createPizza(String selectedSize, List<Map<String,dynamic>> ingredients, String userID , double price);
}

class PizzaCustomRemoteDataSourceImpl implements PizzaCustomRemoteDataSource {

  PizzaCustomRemoteDataSourceImpl();

  @override
  Future<List<PizzacustomModel>> getAllCustomPizzas() async {
    throw UnimplementedError();
    // try {
  
    //   final response = await http.get(
    //     Uri.parse(ApiConst.getAllCustomPizzas),
    //     headers: {'Content-Type': 'application/json'},
    //   );

    //   if (response.statusCode == 200) {
    //     final List<dynamic> jsonResponse = json.decode(response.body)['data'];
    //     return jsonResponse
    //         .map((data) => PizzacustomModel.fromJson(data))
    //         .toList();
    //   } else {
    //     throw ServerException();
    //   }
    // } catch (e) {
    //   print('Error fetching all pizzas: $e');
    //   throw ServerException();
    // }
  }

  @override
  Future<PizzacustomModel> getCustomPizzaById(String id) async {
    throw UnimplementedError();
    // try {
    //   final response = await http.get(
    //     Uri.parse(ApiConst.getCustomPizzaById +'/$id'),
    //     headers: {'Content-Type': 'application/json'},
    //   );

    //   if (response.statusCode == 200) {
    //     final Map<String, dynamic> jsonResponse = json.decode(response.body)['data'];
    //     return PizzacustomModel.fromJson(jsonResponse);
    //   } else {
    //     throw ServerException();
    //   }
    // } catch (e) {
    //   print('Error fetching pizza by ID: $e');
    //   throw ServerException();
    // }
  }

  @override
  Future<void> createPizza(String selectedSize, List<Map<String,dynamic>> ingredients , String userID , double price) async {
    try {
      print(ingredients);
      final response = await http.post(
        Uri.parse(ApiConst.createPizza),
        headers: {'Content-Type': 'application/json'},
        body:json.encode( {
          "size": selectedSize,
          "ingredients": ingredients,
          "userId" : userID,
          "price" : price
        },
      ));

      if (response.statusCode == 201) {
      } else {
        throw ServerException();
      }
    } catch (e) {
      print('Error creating pizza: ${e.toString()}');
      throw ServerException();
    }
  }
}
