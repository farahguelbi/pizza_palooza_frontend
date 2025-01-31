import 'package:equatable/equatable.dart';

class Ingredient extends Equatable {
  final String id;
  final String name;
  final double price;
  final String image;
  // final IngredientLayer layer;

  Ingredient({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    // required this.layer,
  });
  
  @override
  List<Object?> get props => [id,name,image];//layer];
  
    Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image': image,
      // 'layer': layer.value,
    };
  }
}






















// //enum layer
// enum IngredientLayer { dough, sauce, cheese, topping }
// /// Extension pour manipuler les valeurs de l'énumération IngredientLayer
// extension IngredientLayerExtension on IngredientLayer {
//   String get value {
//     switch (this) {
//       case IngredientLayer.dough:
//         return 'dough';
//       case IngredientLayer.sauce:
//         return 'sauce';
//       case IngredientLayer.cheese:
//         return 'cheese';
//       case IngredientLayer.topping:
//         return 'topping';
//     }
//   }

//   static IngredientLayer fromValue(String value) {
//     switch (value) {
//       case 'dough':
//         return IngredientLayer.dough;
//       case 'sauce':
//         return IngredientLayer.sauce;
//       case 'cheese':
//         return IngredientLayer.cheese;
//       case 'topping':
//         return IngredientLayer.topping;
//       default:
//         throw ArgumentError('Invalid IngredientLayer value: $value');
//     }
//   }
