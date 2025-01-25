import 'package:dartz/dartz.dart';
import 'package:front/core/errors/failures/failures.dart';

import '../../entities/sale.dart';
import '../../repositories/sale_repository.dart';

class GetSaleById {
  final SaleRepository repository;

  GetSaleById(this.repository);

   Future<Either<Failure, Sale>> call(String saleId) async {
    return await repository.getSaleById(saleId);
  }
}
