
import 'package:equatable/equatable.dart';
import 'package:front/domain/entities/ingredient.dart';
import 'package:front/domain/entities/pizza.dart';

class PizzaCustom extends Equatable {
  final String id;
  final String name;
  final double price;
  
  final List<Map<String,dynamic>> ingredients;
  final String size;
    final String image; 


  PizzaCustom({
    required this.id,
    required this.name,
    required this.price,
    required this.ingredients,
    required this.size,
        required this.image,

  });
  
  @override
  List<Object?> get props => [id,name,price,ingredients,size,image];


}
class PizzaSize {
  final double small;
  final double medium;
  final double large;
  PizzaSize({required this.small, required this.medium, required this.large});



Map<String, dynamic> toJson() {
    return {
      'small': {'price': small},
      'medium': {'price': medium},
      'large': {'price': large},
    };
  }
  }
