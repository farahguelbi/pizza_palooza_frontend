// lib/data/repositories/side_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:front/data/datasources/remote_data_source/side_remote_datasource.dart';
import '../../core/errors/failures/failures.dart';
import '../../domain/entities/sides.dart';
import '../../domain/repositories/Side_repository.dart';
class SideRepositoryImpl implements SideRepository {
  final SideRemoteDataSource sideRemoteDataSource;

  SideRepositoryImpl({required this.sideRemoteDataSource});
  @override
  Future<Either<Failure, List<Side>>> getAllSides() async {

    try {

      final sides = await sideRemoteDataSource.getAllSides();
      return Right(sides);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Side>> getSideById(String id) async {
    try {
      final side = await sideRemoteDataSource.getSideById(id);
      return Right(side);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
