import 'package:equatable/equatable.dart';
import 'package:front/domain/entities/pizza.dart';

class Wishlist extends Equatable {
  final String id;
  final String userId; 
  final List<Pizza> pizzas; 
  // final List<String> pizzaIds; 



  Wishlist({
    required this.id,
    required this.userId,
    required this.pizzas,

  });

  
  @override
  List<Object?> get props => [id,userId,pizzas];
}