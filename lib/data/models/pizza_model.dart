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
    required String type,
    required  sizes,
  }) : super(
          id: id,
          name: name,
          image: image,
          reference: reference,
          description: description,
          price: price,
          type: type,
          sizes: sizes,
        );

  /// Méthode pour convertir un JSON en une instance de PizzaModel
  factory PizzaModel.fromJson(Map<String, dynamic> json) {
    return PizzaModel(
      id: json['_id']??'',
      name: json['name']??'',
      image: json['image']??'',
      reference: json['reference']??'',
      description: json['description']??'',
      price: double.parse(json['price'].toString()),
        // ingredients: (json['ingredients'] as List?)?.map((ingredientJson) {
        //     return PizzaIngredientModel.fromJson(ingredientJson);
        //   }).toList() ??
        //   [],
      // type: json['type']['name'] ?? '',
       type: json['type'] ?? '',

      sizes: PizzaSizeModel.fromJson(json['size']));

    
  }

//   /// Méthode pour convertir une instance de PizzaModel en JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'image': image,
//       'reference': reference,
//       'description': description,
//       'price': price,
//       // 'ingredients': ingredients
//       //     .map((ingredient) => (ingredient as PizzaIngredientModel).toJson())
//       //     .toList(),
//       'type': type,
//       'sizes': sizes
//           .map((size) => (size as PizzaSizeModel).toJson())
//           .toList(),
//     };
//   }
 }
class PizzaSizeModel extends PizzaSize {
  PizzaSizeModel({required super.small,required  super.medium,required  super.large});

  factory PizzaSizeModel.fromJson(Map<String, dynamic> json) =>
      PizzaSizeModel(
          small: double.parse( json["small"].toString()),
          medium:double.parse(  json["medium"].toString()),
          large: double.parse( json["large"].toString())
          );
}




// class PizzaIngredientModel extends PizzaIngredient {
//   const PizzaIngredientModel({
//     required IngredientModel ingredient,
//     required int quantity,
//   }) : super(
//           ingredient: ingredient,
//           quantity: quantity,
//         );
//         }

  // /// Méthode pour convertir un JSON en une instance de PizzaIngredientModel
  // factory PizzaIngredientModel.fromJson(Map<String, dynamic> json) {
  //   return PizzaIngredientModel(
  //     ingredient: IngredientModel.fromJson(json['ingredient']),
  //     quantity: json['quantity'],
  //   );
  // }

  // /// Méthode pour convertir une instance de PizzaIngredientModel en JSON
  // Map<String, dynamic> toJson() {
  //   return {
  //     'ingredient': (ingredient as IngredientModel).toJson(),
  //     'quantity': quantity,
  //   };
  //   }}