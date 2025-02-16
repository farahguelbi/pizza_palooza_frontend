import 'package:equatable/equatable.dart';
import 'sides.dart'; 

class Sale extends Equatable {
  final String? id; 
  final String pizzaId; 
  final int pizzaQuantity; 
  final String userId;
  final double totalPrice; 
  final List<SaleSide> sides; 
 final String pizzaType; 

const Sale({
    required this.id,
    required this.pizzaId,
    required this.pizzaQuantity,
    required this.userId,
    required this.totalPrice,
    required this.sides,
    required this.pizzaType,
  });

  @override
  List<Object?> get props => [
        id,
        pizzaId,
        pizzaQuantity,
        userId,
        totalPrice,
        sides,
        pizzaType,
      
      ];
}

class SaleSide extends Equatable {
  final String sideId; 
  final int quantity; 

  const SaleSide({
    required this.sideId,
    required this.quantity,
  });

  @override
  List<Object?> get props => [sideId, quantity];
  
}
