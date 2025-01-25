import 'package:equatable/equatable.dart';
import 'cart.dart';
import 'user.dart';
class Command extends Equatable {
  final String id; 
  final User user; 
  final String address;
  final Cart cart; 
  final OrderStatus orderStatus; 
  final PaymentStatus paymentStatus; 
  final PaymentMethod paymentMethod; 
  final double totalPrice; 

  const Command({
    required this.id,
    required this.user,
    required this.address,
    required this.cart,
    required this.orderStatus,
    required this.paymentStatus,
    required this.paymentMethod,
    required this.totalPrice,
  });

  @override
  List<Object?> get props => [
        id,
        user,
        address,
        cart,
        orderStatus,
        paymentStatus,
        paymentMethod,
        totalPrice,
      ];
}

/// Enum for Order Status
enum OrderStatus { pending, completed, cancelled }

/// Extension for OrderStatus to handle string conversion
extension OrderStatusExtension on OrderStatus {
  String get value {
    switch (this) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.completed:
        return 'Completed';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }

  static OrderStatus fromValue(String value) {
    switch (value) {
      case 'Pending':
        return OrderStatus.pending;
      case 'Completed':
        return OrderStatus.completed;
      case 'Cancelled':
        return OrderStatus.cancelled;
      default:
        throw ArgumentError('Invalid OrderStatus value: $value');
    }
  }
}

/// Enum for Payment Status
enum PaymentStatus { paid, unpaid }

/// Extension for PaymentStatus to handle string conversion
extension PaymentStatusExtension on PaymentStatus {
  String get value {
    switch (this) {
      case PaymentStatus.paid:
        return 'Paid';
      case PaymentStatus.unpaid:
        return 'Unpaid';
    }
  }

  static PaymentStatus fromValue(String value) {
    switch (value) {
      case 'Paid':
        return PaymentStatus.paid;
      case 'Unpaid':
        return PaymentStatus.unpaid;
      default:
        throw ArgumentError('Invalid PaymentStatus value: $value');
    }
  }
}

/// Enum for Payment Method
enum PaymentMethod { online, delivery }

/// Extension for PaymentMethod to handle string conversion
extension PaymentMethodExtension on PaymentMethod {
  String get value {
    switch (this) {
      case PaymentMethod.online:
        return 'Online';
      case PaymentMethod.delivery:
        return 'Delivery';
    }
  }

  static PaymentMethod fromValue(String value) {
    switch (value) {
      case 'Online':
        return PaymentMethod.online;
      case 'Delivery':
        return PaymentMethod.delivery;
      default:
        throw ArgumentError('Invalid PaymentMethod value: $value');
    }
  }
}
