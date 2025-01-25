import 'package:dartz/dartz.dart';
import 'package:front/core/errors/failures/failures.dart';

import '../../entities/cart.dart';
import '../../repositories/cart_repository.dart';

class CreateOrGetCartUseCase {
  final CartRepository repository;

  CreateOrGetCartUseCase(this.repository);
  
Future<Either<Failure, Cart>> call(String userId) async {
    return repository.createOrGetCart(userId);
  }
}
