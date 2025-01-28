import 'package:dartz/dartz.dart';
import 'package:front/core/errors/failures/failures.dart';
import '../entities/sides.dart';

abstract class SideRepository {
  Future<Either<Failure, List<Side>>> getAllSides();
  Future<Either<Failure, Side>> getSideById(String id);
}
