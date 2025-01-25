import 'package:dartz/dartz.dart';
import 'package:front/core/errors/failures/failures.dart';

import '../../repositories/cart_repository.dart';

class RemoveSaleFromCartUseCase {
  final CartRepository repository;

  RemoveSaleFromCartUseCase(this.repository);

 Future<Either<Failure, Unit>> call(String userId, String saleId) async {
    return repository.removeSaleFromCart(userId, saleId);
  }
}
