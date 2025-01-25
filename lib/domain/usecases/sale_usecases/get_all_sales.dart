import 'package:dartz/dartz.dart';
import 'package:front/core/errors/failures/failures.dart';

import '../../entities/sale.dart';
import '../../repositories/sale_repository.dart';

class GetAllSales {
  final SaleRepository repository;

  GetAllSales(this.repository);

  Future<Either<Failure, List<Sale>>> call() async {
    return await repository.getAllSales();
  }
}
