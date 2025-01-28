import 'package:dartz/dartz.dart';
import 'package:front/core/errors/exceptions/exceptions.dart';
import 'package:front/core/errors/failures/failures.dart';

import '../../domain/entities/wishlist.dart';
import '../../domain/repositories/wishlist_repository.dart';
import '../../data/datasources/remote_data_source/wishlist_remote_datasource.dart';
import '../models/wishlist_model.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  final WishlistRemoteDataSource wishlistRemoteDataSource;

  WishlistRepositoryImpl({required this.wishlistRemoteDataSource});

   @override
  Future<Either<Failure, Unit>> addToWishlist(String userId, String pizzaId) async {
    try {
      await wishlistRemoteDataSource.addToWishlist( userId:userId, pizzaId: pizzaId);
      return Right(unit);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

   @override
  Future<Either<Failure, Unit>> removeFromWishlist(String userId, String pizzaId) async {
    try {
      await wishlistRemoteDataSource.removeFromWishlist( userId:userId,pizzaId:pizzaId);
      return Right(unit);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
 @override
  Future<Either<Failure, Wishlist>> getWishlist(String userId) async {
    try {
      final wishlist = await wishlistRemoteDataSource.getWishlist(userId: userId);
      return Right(wishlist);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
  
  @override
  Future<Either<Failure, Unit>> createWishList({required String userId}) async {
     try {
      // ignore: unused_local_variable
      final res = await wishlistRemoteDataSource.createWishList(userId: userId);
      return Right(unit);
    } on RegistrationException catch (e) {
      return Left(RegistrationFailure(e.message));
    }
  }
}