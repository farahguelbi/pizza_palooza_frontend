

import 'package:dartz/dartz.dart';
import 'package:front/core/errors/failures/failures.dart';
import 'package:front/domain/entities/sides.dart';

abstract class SidesRepository {
  Future<Either<Failure, List<Side>>> getAllSides();
  Future<Either<Failure, Side>> getSideById(String id);
}
