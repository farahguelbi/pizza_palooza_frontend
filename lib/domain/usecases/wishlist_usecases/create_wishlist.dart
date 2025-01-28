import 'package:dartz/dartz.dart';
import 'package:front/core/errors/failures/failures.dart';
import 'package:front/domain/repositories/wishlist_repository.dart';


class CreateWishListUseCase {
  final WishlistRepository _repository;

  const CreateWishListUseCase(this._repository);

  Future<Either<Failure, Unit>> call({required String userId}) async =>
      await _repository.createWishList(userId: userId);
}