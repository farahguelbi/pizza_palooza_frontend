import 'package:dartz/dartz.dart';
import 'package:front/core/errors/failures/failures.dart';

import '../../repositories/cart_repository.dart';

class AddSaleToCartUseCase {
  final CartRepository repository;


  AddSaleToCartUseCase(this.repository);
  
 Future<Either<Failure, Unit>> call(String userId, String saleId) async {
    return repository.addSaleToCart(userId, saleId);
  }
}
