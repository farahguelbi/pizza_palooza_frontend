import 'package:dartz/dartz.dart';
import 'package:front/core/errors/failures/failures.dart';

import '../../entities/sides.dart';
import '../../repositories/side_repository.dart';

class GetSideById {
  final SideRepository repository;

  GetSideById(this.repository);
  
 Future<Either<Failure, Side>> call(String id) async {
    return repository.getSideById(id);
  }
}
