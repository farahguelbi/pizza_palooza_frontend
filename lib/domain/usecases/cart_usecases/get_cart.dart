import 'package:dartz/dartz.dart';
import 'package:front/core/errors/failures/failures.dart';

import '../../entities/cart.dart';
import '../../repositories/cart_repository.dart';

class GetCartUseCase {
  final CartRepository repository;

  GetCartUseCase(this.repository);
  Future<Either<Failure, Cart?>> call(String userId) async {
    return repository.getCart(userId);
  }
}
