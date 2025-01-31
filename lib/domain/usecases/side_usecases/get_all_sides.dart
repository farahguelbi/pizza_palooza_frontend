import 'package:dartz/dartz.dart';
import 'package:front/core/errors/failures/failures.dart';
import 'package:front/domain/repositories/sides_repository.dart';

import '../../entities/sides.dart';

class GetAllSidesUseCase {
  final SidesRepository repository;

  GetAllSidesUseCase(this.repository);

  Future<Either<Failure, List<Side>>> call() async {
    
    return repository.getAllSides();
  }
}
