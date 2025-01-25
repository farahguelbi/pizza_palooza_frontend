import '../../repositories/sale_repository.dart';
import '../../entities/sale.dart';
import 'package:dartz/dartz.dart';
import '../../../core/errors/failures/failures.dart';

class UpdateSale {
  final SaleRepository repository;

  UpdateSale(this.repository);

  Future<Either<Failure, Unit>> call(Sale sale) async {
    return await repository.updateSale(sale);
  }
}
