import 'package:dartz/dartz.dart';
import '../../core/errors/failures/failures.dart';
import '../../domain/entities/sale.dart';
import '../../domain/repositories/sale_repository.dart';
import '../datasources/remote_data_source/sale_remote_data_source.dart';

class SaleRepositoryImpl implements SaleRepository {
  final SaleRemoteDataSource remoteDataSource;

  SaleRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Sale>>> getAllSales() async {
    try {
      final sales = await remoteDataSource.getAllSales();
      return Right(sales);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Sale>> getSaleById(String saleId) async {
    try {
      final sale = await remoteDataSource.getSaleById(saleId);
      return Right(sale);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

 

 @override
  Future<Either<Failure, Unit>> updateSale(Sale sale) async {
    try {
      // Prepare the sale data
      final saleData = {
        'userId': sale.userId,
        'pizzaId': sale.pizzaId,
        'pizzaQuantity': sale.pizzaQuantity,
        'sides': sale.sides.map((side) => {
          'sideId': side.side.id,
          'quantity': side.quantity,
        }).toList(),
      };

      // Call the remote data source
      await remoteDataSource.updateSale(sale.id!, saleData);

      // Return success
      return const Right(unit);
    } catch (e) {
      // Return a failure
      return Left(ServerFailure());
    }
  }



  @override
  Future<Either<Failure, Unit>> deleteSale(String saleId) async {
    try {
      await remoteDataSource.deleteSale(saleId);
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
  
  @override
  Future<Either<Failure, Sale>> createSale({required String userID, required String pizzaId, required int quantityPizza, required List<String> sides, required List<int> quantitiesSides}) async {
   try {
      final saleData = {
        'userId': userID,
        'pizzaId': pizzaId,
        'pizzaQuantity': quantityPizza,
        'sides': sides.map((side) => {'sideId': side}).toList(),
        'quantitiesSides': quantitiesSides,
      };

      final sale = await remoteDataSource.createSale(saleData);
      return Right(sale);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
  

