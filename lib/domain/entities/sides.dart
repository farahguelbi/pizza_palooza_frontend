import 'package:equatable/equatable.dart';

class Side extends Equatable {
  final String id; 
  final String name; 
  final double price; 
  final SideType type; 

  const Side({
    required this.id,
    required this.name,
    required this.price,
    required this.type,
  });

  @override
  List<Object?> get props => [id, name, price, type];
}

/// Enumération pour les types d'accompagnements
enum SideType { drinks, fries }

/// Extension pour gérer les valeurs de l'enum SideType
extension SideTypeExtension on SideType {
  String get value {
    switch (this) {
      case SideType.drinks:
        return 'drinks';
      case SideType.fries:
        return 'fries';
    }
  }

  static SideType fromValue(String value) {
    switch (value) {
      case 'drinks':
        return SideType.drinks;
      case 'fries':
        return SideType.fries;
      default:
        throw ArgumentError('Invalid SideType value: $value');
    }
  }
}
