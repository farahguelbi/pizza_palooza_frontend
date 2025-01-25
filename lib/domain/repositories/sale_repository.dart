import 'package:front/data/models/sale_model.dart';

import '../entities/sale.dart';
import '../../core/errors/failures/failures.dart';
import '../entities/sale.dart';
import 'package:dartz/dartz.dart';
abstract class SaleRepository {
 Future<Either<Failure, List<Sale>>>getAllSales();
 Future<Either<Failure, Sale>> getSaleById(String saleId);
  Future<Either<Failure, Sale>> createSale({  
    required String userID,
    required String pizzaId,
    required int quantityPizza,
    required List<String> sides,
    required List<int> quantitiesSides,});
 
  Future<Either<Failure, Unit>> updateSale(Sale sale);
 
  Future<Either<Failure, Unit>> deleteSale(String saleId);
}
