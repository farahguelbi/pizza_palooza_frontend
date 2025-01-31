import 'package:dartz/dartz.dart';
import '../../core/errors/failures/failures.dart';
import '../../domain/entities/sale.dart';
import '../../domain/repositories/sale_repository.dart';
import '../datasources/remote_data_source/sale_remote_data_source.dart';

class SaleRepositoryImpl implements SaleRepository {
  final SaleRemoteDataSource saleRemoteDataSource;

  SaleRepositoryImpl({required this.saleRemoteDataSource});

  @override
  Future<Either<Failure, List<Sale>>> getAllSales() async {
    try {
      final sales = await saleRemoteDataSource.getAllSales();
      return Right(sales);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Sale>> getSaleById(String saleId) async {
    try {
      final sale = await saleRemoteDataSource.getSaleById(saleId);
      return Right(sale);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

 

//  @override
//   Future<Either<Failure, Unit>> updateSale(Sale sale) async {
//     try {
//       // Prepare the sale data
//       final saleData = {
//         'userId': sale.userId,
//         'pizzaId': sale.pizzaId,
//         'pizzaQuantity': sale.pizzaQuantity,
//         'sides': sale.sides.map((side) => {
//           'sideId': side.side.id,
//           'quantity': side.quantity,
//         }).toList(),
//       };

//       // Call the remote data source
//       await saleRemoteDataSource.updateSale(sale.id!, saleData);

//       // Return success
//       return const Right(unit);
//     } catch (e) {
//       // Return a failure
//       return Left(ServerFailure());
//     }
//   }



  @override
  Future<Either<Failure, Unit>> deleteSale(String saleId) async {
    try {
      await saleRemoteDataSource.deleteSale(saleId);
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
  
  @override
  Future<Either<Failure, Sale>> createSale({required String userID, required String pizzaId, required int quantityPizza}) async {
   try {
      final saleData = {
        'userId': userID,
        'pizzaId': pizzaId,
        'pizzaQuantity': quantityPizza,
        // 'sides': sides.map((side) => {'sideId': side}).toList(),
        // 'quantitiesSides': quantitiesSides,
      };

      final sale = await saleRemoteDataSource.createSale(saleData);
      return Right(sale);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
  
  @override
  Future<Either<Failure, void>> addMultipleSides(String saleId, List<SaleSide> sides, double totalPrice) {
    // TODO: implement addMultipleSides
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, Unit>> updateSale(Sale sale) {
    // TODO: implement updateSale
    throw UnimplementedError();
  }
}
  

