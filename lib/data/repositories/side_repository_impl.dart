// lib/data/repositories/side_repository_impl.dart
import 'package:dartz/dartz.dart';
import '../../core/errors/failures/failures.dart';
import '../../domain/entities/sides.dart';
import'../../data/datasources/remote_data_source/side_remote_datasource.dart';
import '../../domain/repositories/Side_repository.dart';
class SideRepositoryImpl implements SideRepository  {
  final SideRemoteDataSource remoteDataSource;

  SideRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Side>>> getAllSides() async {
    try {
      final sides = await remoteDataSource.getAllSides();
      return Right(sides);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Side>> getSideById(String id) async {
    try {
      final side = await remoteDataSource.getSideById(id);
      return Right(side);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
