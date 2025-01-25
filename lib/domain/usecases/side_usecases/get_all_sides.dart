import 'package:dartz/dartz.dart';
import 'package:front/core/errors/failures/failures.dart';

import '../../entities/sides.dart';
import '../../repositories/side_repository.dart';

class GetAllSides {
  final SideRepository repository;

  GetAllSides(this.repository);

  Future<Either<Failure, List<Side>>> call() async {
    return repository.getAllSides();
  }
}
