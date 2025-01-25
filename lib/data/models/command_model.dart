import '../../domain/entities/command.dart';
import 'cart_model.dart';
import 'user_model.dart';

class CommandModel extends Command {
  const CommandModel({
    required String id,
    required UserModel user,
    required String address,
    required CartModel cart,
    required OrderStatus orderStatus,
    required PaymentStatus paymentStatus,
    required PaymentMethod paymentMethod,
    required double totalPrice,
  }) : super(
          id: id,
          user: user,
          address: address,
          cart: cart,
          orderStatus: orderStatus,
          paymentStatus: paymentStatus,
          paymentMethod: paymentMethod,
          totalPrice: totalPrice,
        );

  factory CommandModel.fromJson(Map<String, dynamic> json) {
    return CommandModel(
      id: json['_id'],
      user: UserModel.fromJson(json['user']),
      address: json['address'],
      cart: CartModel.fromJson(json['cart']),
      orderStatus: OrderStatusExtension.fromValue(json['orderStatus']),
      paymentStatus: PaymentStatusExtension.fromValue(json['paymentStatus']),
      paymentMethod: PaymentMethodExtension.fromValue(json['paymentMethod']),
      totalPrice: (json['totalPrice'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': (user as UserModel).toJson(),
      'address': address,
      'cart': (cart as CartModel).toJson(),
      'orderStatus': orderStatus.value,
      'paymentStatus': paymentStatus.value,
      'paymentMethod': paymentMethod.value,
      'totalPrice': totalPrice,
    };
  }

  static CommandModel fromEntity(Command command) {
    return CommandModel(
      id: command.id,
      user: command.user as UserModel,
      address: command.address,
      cart: command.cart as CartModel,
      orderStatus: command.orderStatus,
      paymentStatus: command.paymentStatus,
      paymentMethod: command.paymentMethod,
      totalPrice: command.totalPrice,
    );
  }

  Command toEntity() {
    return Command(
      id: id,
      user: user,
      address: address,
      cart: cart,
      orderStatus: orderStatus,
      paymentStatus: paymentStatus,
      paymentMethod: paymentMethod,
      totalPrice: totalPrice,
    );
  }
}
