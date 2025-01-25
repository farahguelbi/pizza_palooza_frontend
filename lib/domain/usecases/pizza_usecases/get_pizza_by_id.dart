import 'package:dartz/dartz.dart';
import 'package:front/core/errors/failures/failures.dart';

import '../../entities/pizza.dart';
import '../../repositories/pizza_repository.dart';

class GetPizzaByIdUsecase {
  final PizzaRepository repository;

  GetPizzaByIdUsecase(this.repository);

Future<Either<Failure, Pizza>> call({required String id}) async {
    return repository.getPizzaById(id: id);
  }
}
