import '../../domain/entities/pizza.dart';
import '../../domain/entities/ingredient.dart';
import 'ingredient_model.dart';

class PizzaModel extends Pizza {
  const PizzaModel({
    required String id,
    required String name,
    required String image,
    required String reference,
    required String description,
    required double price,
    required List<PizzaIngredientModel> ingredients,
    required String type,
    required List<PizzaSizeModel> sizes,
  }) : super(
          id: id,
          name: name,
          image: image,
          reference: reference,
          description: description,
          price: price,
          ingredients: ingredients,
          type: type,
          sizes: sizes,
        );

  /// Méthode pour convertir un JSON en une instance de PizzaModel
  factory PizzaModel.fromJson(Map<String, dynamic> json) {
    return PizzaModel(
      id: json['id']??'',
      name: json['name']??'',
      image: json['image']??'',
      reference: json['reference']??'',
      description: json['description']??'',
      price: (json['price'] as num).toDouble(),
        ingredients: (json['ingredients'] as List?)?.map((ingredientJson) {
            return PizzaIngredientModel.fromJson(ingredientJson);
          }).toList() ??
          [],
      type: json['type']['name'] ?? '',
      sizes: (json['sizes'] as List)
          .map((sizeJson) => PizzaSizeModel.fromJson(sizeJson))
          .toList(),
    );
  }

  /// Méthode pour convertir une instance de PizzaModel en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'reference': reference,
      'description': description,
      'price': price,
      'ingredients': ingredients
          .map((ingredient) => (ingredient as PizzaIngredientModel).toJson())
          .toList(),
      'type': type,
      'sizes': sizes
          .map((size) => (size as PizzaSizeModel).toJson())
          .toList(),
    };
  }
}
class PizzaSizeModel extends PizzaSize {
  const PizzaSizeModel({
    required String size,
    required double price,
  }) : super(
          size: size,
          price: price,
        );

  /// Méthode pour convertir un JSON en une instance de PizzaSizeModel
  factory PizzaSizeModel.fromJson(Map<String, dynamic> json) {
    return PizzaSizeModel(
      size: json['size'],
      price: (json['price'] as num).toDouble(),
    );
  }

  /// Méthode pour convertir une instance de PizzaSizeModel en JSON
  Map<String, dynamic> toJson() {
    return {
      'size': size,
      'price': price,
    };
  }
}


class PizzaIngredientModel extends PizzaIngredient {
  const PizzaIngredientModel({
    required IngredientModel ingredient,
    required int quantity,
  }) : super(
          ingredient: ingredient,
          quantity: quantity,
        );

  /// Méthode pour convertir un JSON en une instance de PizzaIngredientModel
  factory PizzaIngredientModel.fromJson(Map<String, dynamic> json) {
    return PizzaIngredientModel(
      ingredient: IngredientModel.fromJson(json['ingredient']),
      quantity: json['quantity'],
    );
  }

  /// Méthode pour convertir une instance de PizzaIngredientModel en JSON
  Map<String, dynamic> toJson() {
    return {
      'ingredient': (ingredient as IngredientModel).toJson(),
      'quantity': quantity,
    };
    }}
