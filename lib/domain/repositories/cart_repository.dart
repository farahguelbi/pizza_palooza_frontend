import 'package:dartz/dartz.dart';
import 'package:front/core/errors/failures/failures.dart';

import '../entities/cart.dart';
import '../entities/sale.dart';

abstract class CartRepository {
 Future<Either<Failure, Cart>> createOrGetCart(String userId);
  Future<Either<Failure, Unit>> addSaleToCart(String userId, String saleId);
  Future<Either<Failure, Cart>> getCart(String userId);
  Future<Either<Failure, Unit>> removeSaleFromCart(String userId, String saleId);
  Future<Either<Failure, Unit>> clearCart(String userId);
}
