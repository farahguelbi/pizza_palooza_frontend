import 'package:equatable/equatable.dart';

class Token extends Equatable {
  final String token;
  final String userId;
  final DateTime expiryDate;

  const Token({required this.token, required this.expiryDate, required this.userId});
  @override
  List<Object?> get props => [token, expiryDate,userId];

}