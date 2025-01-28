import 'package:equatable/equatable.dart';
import 'ingredient.dart';

class Pizza extends Equatable {
  final String id;
  final String name;
  final String image; 
  final String reference;
  final String description; 
  final double price; 

  final String type;
  final PizzaSize sizes;

  const Pizza({
    required this.id,
    required this.name,
    required this.image,
    required this.reference,
    required this.description,
    required this.price,
 
    required this.type,
    required this.sizes,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        image,
        reference,
        description,
        price,
        type,
        sizes,
      ];
}
class PizzaSize {
  final double small;
  final double medium;
  final double large;
  PizzaSize({required this.small, required this.medium, required this.large});
}










// /// Enum for Pizza Sizes
// enum PizzaSizeType { small, medium, large }

// /// Extension for PizzaSizeType to handle string conversion
// extension PizzaSizeTypeExtension on PizzaSizeType {
//   String get value {
//     switch (this) {
//       case PizzaSizeType.small:
//         return 'small';
//       case PizzaSizeType.medium:
//         return 'medium';
//       case PizzaSizeType.large:
//         return 'large';
//     }
//   }

//   static PizzaSizeType fromValue(String value) {
//     switch (value) {
//       case 'small':
//         return PizzaSizeType.small;
//       case 'medium':
//         return PizzaSizeType.medium;
//       case 'large':
//         return PizzaSizeType.large;
//       default:
//         throw ArgumentError('Invalid PizzaSizeType value: $value');
//     }
//   }
// }
// class PizzaIngredient extends Equatable {
//   final Ingredient ingredient; 
//   final int quantity; 

//   const PizzaIngredient({
//     required this.ingredient,
//     required this.quantity,
//   });

//   @override
//   List<Object?> get props => [ingredient, quantity];
// }


// class PizzaSize extends Equatable {
//   final String size; 
//   final double price; 
//   const PizzaSize({
//     required this.size,
//     required this.price,
//   });

//   @override
//   List<Object?> get props => [size, price];
// 