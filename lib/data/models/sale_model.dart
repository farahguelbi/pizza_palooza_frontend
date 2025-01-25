import '../../domain/entities/sale.dart';
import 'side_model.dart';

class SaleModel extends Sale {
  const SaleModel({
    required String? id,
    required String pizzaId,
    required int pizzaQuantity,
    required String userId,
    required double totalPrice,
    required List<SaleSideModel> sides,
  }) : super(
          id: id,
          pizzaId: pizzaId,
          pizzaQuantity: pizzaQuantity,
          userId: userId,
          totalPrice: totalPrice,
          sides: sides,
        );

  factory SaleModel.fromJson(Map<String, dynamic> json) {
    return SaleModel(
      id: json['_id'],
      pizzaId: json['pizzaId'] ?? '',
      pizzaQuantity: json['quantitypizza'] ?? 0,
      userId: json['userId'] ?? '',
      totalPrice: (json['totalprice'] as num?)?.toDouble() ?? 0.0,
      sides: (json['sides'] as List<dynamic>? ?? [])
          .map((sideJson) => SaleSideModel.fromJson(sideJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'pizzaId': pizzaId,
      'quantitypizza': pizzaQuantity,
      'userId': userId,
      'totalprice': totalPrice,
      'sides': sides.map((side) => (side as SaleSideModel).toJson()).toList(),
    };
  }
}


/// Modèle pour les côtés associés à une vente
class SaleSideModel extends SaleSide {
  const SaleSideModel({
    required SideModel side,
    required int quantity,
  }) : super(
          side: side,
          quantity: quantity,
        );

  /// Convertir un JSON en une instance de `SaleSideModel`
  factory SaleSideModel.fromJson(Map<String, dynamic> json) {
    return SaleSideModel(
      side: SideModel.fromJson(json['side']),
      quantity: json['quantity'],
    );
  }

  /// Convertir une instance de `SaleSideModel` en JSON
  Map<String, dynamic> toJson() {
    return {
      'side': (side as SideModel).toJson(),
      'quantity': quantity,
    };
  }
}
