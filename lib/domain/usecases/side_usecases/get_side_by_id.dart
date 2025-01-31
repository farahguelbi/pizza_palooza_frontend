import 'package:dartz/dartz.dart';
import 'package:front/core/errors/failures/failures.dart';
import 'package:front/domain/repositories/sides_repository.dart';

import '../../entities/sides.dart';

class GetSideById {
  final SidesRepository repository;

  GetSideById(this.repository);
  
 Future<Either<Failure, Side>> call(String id) async {
    return repository.getSideById(id);
  }
}
