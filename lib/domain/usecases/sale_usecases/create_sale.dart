import '../../entities/sale.dart';
import '../../repositories/sale_repository.dart';
import '../../../core/errors/failures/failures.dart';
import 'package:dartz/dartz.dart';

 class CreateSale{
  final SaleRepository repository;

  CreateSale(this.repository);

  Future<Either<Failure, String>> call({
    required String userID,
    required String pizzaId,
    required int quantityPizza,
    required double totalPrice,
    // required List<String> sides,
    // required List<int> quantitiesSides,
    required String pizzaType
  }) async {
    return await repository.createSale(
      userID: userID,
      pizzaId: pizzaId,
      quantityPizza: quantityPizza,
      totalPrice:totalPrice,
      pizzaType:pizzaType,
      // sides: sides,
      // quantitiesSides: quantitiesSides,
    );
  }
}
