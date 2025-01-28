import 'package:dartz/dartz.dart';
import 'package:front/core/errors/failures/failures.dart';

import '../entities/wishlist.dart';

abstract class WishlistRepository {
    Future<Either<Failure, Unit>> createWishList({required String userId});
  Future<Either<Failure, Unit>> addToWishlist(String userId, String pizzaId);
  Future<Either<Failure, Unit>> removeFromWishlist(String userId, String pizzaId);
 Future<Either<Failure, Wishlist>> getWishlist(String userId);
}