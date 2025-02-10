import 'package:equatable/equatable.dart';
import 'package:front/data/models/sale_model.dart';
import 'sale.dart';
import 'user.dart';

class Cart extends Equatable {
  final String id; 
  // final User user; 
  final String user; 

  final List<SaleModel> sales; 
  final double cartTotal; 

  const Cart({
    required this.id,
    required this.user,
    required this.sales,
    required this.cartTotal,
  });

  @override
  List<Object?> get props => [id, user, sales, cartTotal];
}
