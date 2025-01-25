import 'package:equatable/equatable.dart';

class Wishlist extends Equatable {
  final String id;
  final String userId; 
  final List<String> pizzaIds; 


  Wishlist({
    required this.id,
    required this.userId,
    required this.pizzaIds,

  });
  
  @override
  List<Object?> get props => [id,userId,pizzaIds];
}