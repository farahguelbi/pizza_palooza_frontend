import '../../entities/sale.dart';
import '../../repositories/sale_repository.dart';
import '../../../core/errors/failures/failures.dart';
import 'package:dartz/dartz.dart';

 class CreateSale {
  final SaleRepository repository;

  CreateSale(this.repository);

  Future<Either<Failure, Sale>> call({
    required String userID,
    required String pizzaId,
    required int quantityPizza,
    required List<String> sides,
    required List<int> quantitiesSides,
  }) async {
    return await repository.createSale(
      userID: userID,
      pizzaId: pizzaId,
      quantityPizza: quantityPizza,
      sides: sides,
      quantitiesSides: quantitiesSides,
    );
  }
}
