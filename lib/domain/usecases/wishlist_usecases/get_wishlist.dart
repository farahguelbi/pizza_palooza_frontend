import 'package:dartz/dartz.dart';
import 'package:front/core/errors/failures/failures.dart';

import '../../entities/wishlist.dart';
import '../../repositories/wishlist_repository.dart';

class GetWishlist {
  final WishlistRepository repository;

  GetWishlist(this.repository);

   Future<Either<Failure, Wishlist>> call(String userId) {
    return repository.getWishlist(userId);
  }
}
