import 'package:front/data/models/pizza_model.dart';
import 'package:front/domain/entities/pizza.dart';

import '../../domain/entities/wishlist.dart';

class WishlistModel extends Wishlist {
 WishlistModel({
    required String id,
    required String userId,
    required List<Pizza> pizzas,
    // required List<String> pizzaIds,

  }) : super(
          id: id,
          userId: userId,
          pizzas: pizzas,
        );

  /// Convertir un JSON en une instance de `WishlistModel`
  factory WishlistModel.fromJson(Map<String, dynamic> json) {
    return WishlistModel(
      id: json['_id'],
      userId: json['userID'],
//  pizzaIds: (json['pizzas'] as List<dynamic>)
//           .map((pizzaJson) => PizzaModel.fromJson(pizzaJson as Map<String, dynamic>))
//           .toList(),
   pizzas: (json['pizzas'] as List)
          .map((pizza) => PizzaModel.fromJson(pizza))
          .toList(),
// pizzaIds: List<String>.from(json['pizzas']), 
    );    
  }

  /// Convertir une instance de `WishlistModel` en JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userID': userId,
      'pizzas': pizzas,
    };
  }
}
