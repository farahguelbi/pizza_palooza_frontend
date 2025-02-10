import 'package:dartz/dartz.dart';
import 'package:front/core/errors/failures/failures.dart';

import '../../domain/entities/cart.dart';
import '../../domain/repositories/cart_repository.dart';
import '../../data/datasources/remote_data_source/cart_remote_datasource.dart';
import '../models/cart_model.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource cartremoteDataSource;

  CartRepositoryImpl({required this.cartremoteDataSource});

  @override
  Future<Either<Failure, Cart>> createOrGetCart(String userId) async {
    try {
      final cartModel = await cartremoteDataSource.createOrGetCart(userId);
      return Right(cartModel);
    } catch (e) {
      return Left(ServerFailure());
    }
  }


 @override
Future<Either<Failure, Unit>> addSaleToCart(String userId, String saleId) async {
  try {
    // Wrap the saleId into a Map
    await cartremoteDataSource.addSaleToCart(userId, saleId);
    return const Right(unit);
  } catch (e) {
    return Left(ServerFailure());
  }
}



 @override
  Future<Either<Failure, Cart>> getCart(String userId) async {
    try {
      final cartModel = await cartremoteDataSource.getCart(userId);
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
      await cartremoteDataSource.removeSaleFromCart(userId, saleId);
      return Right(unit);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

   @override
  Future<Either<Failure, Unit>> clearCart(String userId) async {
    try {
      await cartremoteDataSource.clearCart(userId);
      return Right(unit);
    } catch (e) {
      return Left(ServerFailure());
    }
    }
}
