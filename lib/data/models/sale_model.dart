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

  // factory SaleModel.fromJson(Map<String, dynamic> json) {
  //   return SaleModel(
  //     id: json['_id'],
  //     pizzaId: json['pizzaId'] ?? '',
  //     pizzaQuantity: json['quantitypizza'] ?? 0,
  //     userId: json['userId'] ?? '',
  //     totalPrice: (json['totalPrice'] as num?)?.toDouble() ?? 0.0,
      
  //     sides: (json['sides'] as List<dynamic>? ?? [])
  //         .map((sideJson) => SaleSideModel.fromJson(sideJson))
  //         .toList(),
  //   );
  // }
factory SaleModel.fromJson(Map<String, dynamic> json) {
  print("📌 Parsing Sale JSON: $json"); // Debugging

  // Extract sale object if it exists
  final saleData = json.containsKey('sale') ? json['sale'] : json;

  return SaleModel(
    id: saleData['_id'] ?? '',
    pizzaId: saleData['pizzaId']?['_id'] ?? '', // Extract pizza ID correctly
    pizzaQuantity: saleData['quantitypizza'] ?? 0,
    userId: saleData['userId'] ?? '',
    totalPrice: (saleData['totalPrice'] is num) ? (saleData['totalPrice'] as num).toDouble() : 0.0,
    sides: (saleData['sides'] as List<dynamic>).map((side) => SaleSideModel.fromJson(side)).toList(),
  );
}

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'pizzaId': pizzaId,
      'quantitypizza': pizzaQuantity,
      'userId': userId,
      'totalPrice': totalPrice,
      'sides': sides.map((side) => (side as SaleSideModel).toJson()).toList(),
    };
  }
}


/// Modèle pour les côtés associés à une vente
class SaleSideModel extends SaleSide {
  const SaleSideModel({
    required String sideId,
    required int quantity,
  }) : super(
          sideId: sideId,
          quantity: quantity,
        );

  /// Convertir un JSON en une instance de `SaleSideModel`
  factory SaleSideModel.fromJson(Map<String, dynamic> json) {
    return SaleSideModel(
      sideId: (json['sideId']as String),
      quantity: json['quantity'],
    );
  }

  /// Convertir une instance de `SaleSideModel` en JSON
  Map<String, dynamic> toJson() {
    return {
 'sideId': sideId??"",
    'quantity': quantity??"",
    };
  }
}
