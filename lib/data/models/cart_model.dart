import '../../domain/entities/cart.dart';
import '../../domain/entities/sale.dart';
import 'sale_model.dart';
import 'user_model.dart';

class CartModel extends Cart {
  const CartModel({
    required String id,
    required String user,
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
      id: json['_id']??'',
      // user: UserModel.fromJson(json['user']),
      user: json['userId']??'',
      // sales: (json['sales'] as List<dynamic>)
      //     .map((sale) => SaleModel.fromJson(sale))
      //     .toList(),
       sales: json['salesID'] != null && json['salesID'] is List
          ? (json['salesID'] as List<dynamic>)
              .map((saleJson) => SaleModel.fromJson(saleJson))
              .toList()
          : [],
      cartTotal: (json['cartTotal'] as num).toDouble(),
    );
  }

  
  
  /// Convertir une instance de `CartModel` en JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': user,
      // 'salesID': sales.map((sale) => (sale).toJson()).toList(),
            'salesID': sales.map((sale) => sale.toJson()).toList(), // ✅ Correction ici

      'cartTotal': cartTotal,
    };
  }
}
