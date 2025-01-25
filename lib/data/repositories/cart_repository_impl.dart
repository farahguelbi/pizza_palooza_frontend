import 'package:dartz/dartz.dart';
import 'package:front/core/errors/failures/failures.dart';

import '../../domain/entities/cart.dart';
import '../../domain/repositories/cart_repository.dart';
import '../../data/datasources/remote_data_source/cart_remote_datasource.dart';
import '../models/cart_model.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource remoteDataSource;

  CartRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, Cart>> createOrGetCart(String userId) async {
    try {
      final cartModel = await remoteDataSource.createOrGetCart(userId);
      return Right(cartModel);
    } catch (e) {
      return Left(ServerFailure());
    }
  }


 @override
Future<Either<Failure, Unit>> addSaleToCart(String userId, String saleId) async {
  try {
    // Wrap the saleId into a Map
    await remoteDataSource.addSaleToCart(userId, {'saleId': saleId});
    return const Right(unit);
  } catch (e) {
    return Left(ServerFailure());
  }
}



 @override
  Future<Either<Failure, Cart>> getCart(String userId) async {
    try {
      final cartModel = await remoteDataSource.getCart(userId);
      return Right(Cart(
        id: cartModel.id,
        user: cartModel.user,
        sales: cartModel.sales,
        cartTotal: cartModel.cartTotal,
      ));
    } catch (e) {
      return Left(ServerFailure());
    }
  }


 @override
  Future<Either<Failure, Unit>> removeSaleFromCart(String userId, String saleId) async {
    try {
      await remoteDataSource.removeSaleFromCart(userId, saleId);
      return Right(unit);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

   @override
  Future<Either<Failure, Unit>> clearCart(String userId) async {
    try {
      await remoteDataSource.clearCart(userId);
      return Right(unit);
    } catch (e) {
      return Left(ServerFailure());
    }
    }
}
