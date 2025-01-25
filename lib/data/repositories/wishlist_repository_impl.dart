import 'package:dartz/dartz.dart';
import 'package:front/core/errors/failures/failures.dart';

import '../../domain/entities/wishlist.dart';
import '../../domain/repositories/wishlist_repository.dart';
import '../../data/datasources/remote_data_source/wishlist_remote_datasource.dart';
import '../models/wishlist_model.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  final WishlistRemoteDataSource remoteDataSource;

  WishlistRepositoryImpl(this.remoteDataSource);

   @override
  Future<Either<Failure, Unit>> addToWishlist(String userId, String pizzaId) async {
    try {
      await remoteDataSource.addToWishlist( userId:userId, pizzaId: pizzaId);
      return Right(unit);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

   @override
  Future<Either<Failure, Unit>> removeFromWishlist(String userId, String pizzaId) async {
    try {
      await remoteDataSource.removeFromWishlist( userId:userId,pizzaId:pizzaId);
      return Right(unit);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
 @override
  Future<Either<Failure, Wishlist>> getWishlist(String userId) async {
    try {
      final wishlist = await remoteDataSource.getWishlist(userId: userId);
      return Right(wishlist);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
