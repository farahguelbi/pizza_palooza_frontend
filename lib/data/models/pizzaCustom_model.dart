import 'package:front/data/models/ingredient_model.dart';
import 'package:front/domain/entities/pizzaCustom.dart';

class PizzacustomModel extends PizzaCustom {
   PizzacustomModel({
    required String id,
    required String name,
    required double price,
    required PizzaSize size,
    required List<Map<String,dynamic>> ingredients,
  }) : super(
          id: id,
          name: name,
          price: price,
          ingredients: ingredients,
          size: size,
        );

  // // Method to convert JSON into a PizzacustomModel instance
  // factory PizzacustomModel.fromJson(Map<String, dynamic> json) {
  //   return PizzacustomModel(
  //     id: json['_id'] ?? '',
  //     name: json['name'] ?? '',
  //     price: double.parse(json['price'].toString()),
  //     size: PizzaSizeModel.fromJson(json['size']),
  //     ingredients: (json['ingredients'] as List)
  //         .map((ingredientJson) => IngredientModel.fromJson(ingredientJson))
  //         .toList(),
  //   );
  // }

  // Method to convert PizzacustomModel instance into JSON
  Map<String, dynamic> toJson() {
    return {
     
      'name': name,
      'price': price,
      'size': size.toJson(),
      'ingredients':ingredients,
    };
  }
}

class PizzaSizeModel extends PizzaSize {
  PizzaSizeModel({
    required double small,
    required double medium,
    required double large,
  }) : super(small: small, medium: medium, large: large);

  factory PizzaSizeModel.fromJson(Map<String, dynamic> json) {
    return PizzaSizeModel(
      small: double.parse(json['small']['price'].toString()),
      medium: double.parse(json['medium']['price'].toString()),
      large: double.parse(json['large']['price'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'small': {'price': small},
      'medium': {'price': medium},
      'large': {'price': large},
    };
  }
}
