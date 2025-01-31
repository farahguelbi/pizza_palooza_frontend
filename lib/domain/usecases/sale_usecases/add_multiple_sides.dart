import 'package:dartz/dartz.dart';
import 'package:front/core/errors/failures/failures.dart';
import 'package:front/domain/entities/sale.dart';
import 'package:front/domain/repositories/sale_repository.dart';

class AddMultipleSides {
  final SaleRepository repository;

  AddMultipleSides(this.repository);

  Future<Either<Failure, void>> call({
      required String saleId, 
      required List<SaleSide> sides,
      required double totalPrice
      }) {
    return repository.addMultipleSides(saleId, sides, totalPrice);
  }
}
