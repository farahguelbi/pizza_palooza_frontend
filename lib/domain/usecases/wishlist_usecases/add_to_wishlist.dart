import 'package:dartz/dartz.dart';
import 'package:front/core/errors/failures/failures.dart';

import '../../repositories/wishlist_repository.dart';

class AddToWishlist{
  final WishlistRepository repository;

  AddToWishlist(this.repository);

  Future<Either<Failure, Unit>> call(String userId, String pizzaId) {
    return repository.addToWishlist(userId, pizzaId);
  }
}