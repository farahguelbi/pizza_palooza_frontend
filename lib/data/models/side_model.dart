import '../../domain/entities/sides.dart';

class SideModel extends Side {
  const SideModel({
    required String id,
    required String name,
    required double price,
    required SideType type,
  }) : super(
          id: id,
          name: name,
          price: price,
          type: type,
        );

  /// Convertir un JSON en une instance de `SideModel`
  factory SideModel.fromJson(Map<String, dynamic> json) {
    return SideModel(
      id: json['_id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      type: SideTypeExtension.fromValue(json['type']),
    );
  }

  /// Convertir une instance de `SideModel` en JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'price': price,
      'type': type.value,
    };
  }
}
