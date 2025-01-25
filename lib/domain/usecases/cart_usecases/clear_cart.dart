import 'package:dartz/dartz.dart';
import 'package:front/core/errors/failures/failures.dart';

import '../../repositories/cart_repository.dart';

class ClearCartUseCase {
  final CartRepository repository;

  ClearCartUseCase(this.repository);

   Future<Either<Failure, Unit>> call(String userId) async {
    return repository.clearCart(userId);
  }
}
