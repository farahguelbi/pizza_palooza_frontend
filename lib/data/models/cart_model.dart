import '../../domain/entities/cart.dart';
import '../../domain/entities/sale.dart';
import 'sale_model.dart';
import 'user_model.dart';

class CartModel extends Cart {
  const CartModel({
    required String id,
    required UserModel user,
    required List<SaleModel> sales,
    required double cartTotal,
  }) : super(
          id: id,
          user: user,
          sales: sales,
          cartTotal: cartTotal,
        );

  /// Convertir un JSON en une instance de `CartModel`
  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['_id'],
      user: UserModel.fromJson(json['user']),
      sales: (json['sales'] as List<dynamic>)
          .map((sale) => SaleModel.fromJson(sale))
          .toList(),
      cartTotal: (json['cartTotal'] as num).toDouble(),
    );
  }

  /// Convertir une instance de `CartModel` en JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': (user as UserModel).toJson(),
      'sales': sales.map((sale) => (sale as SaleModel).toJson()).toList(),
      'cartTotal': cartTotal,
    };
  }
}
