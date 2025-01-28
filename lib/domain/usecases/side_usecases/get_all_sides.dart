import 'package:dartz/dartz.dart';
import 'package:front/core/errors/failures/failures.dart';

import '../../entities/sides.dart';
import '../../repositories/side_repository.dart';

class GetAllSidesUseCase {
  final SideRepository repository;

  GetAllSidesUseCase(this.repository);

  Future<Either<Failure, List<Side>>> call() async {
    
    return repository.getAllSides();
  }
}
