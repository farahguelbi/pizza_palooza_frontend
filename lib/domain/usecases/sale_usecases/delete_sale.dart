import '../../repositories/sale_repository.dart';
import '../../entities/sale.dart';
import 'package:dartz/dartz.dart';
import '../../../core/errors/failures/failures.dart';
class DeleteSale {
  final SaleRepository repository;

  DeleteSale(this.repository);

 Future<Either<Failure, Unit>> call(String saleId) async {
    return await repository.deleteSale(saleId);
  }
}
