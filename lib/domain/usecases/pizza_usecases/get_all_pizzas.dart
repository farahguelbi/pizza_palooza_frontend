import 'package:dartz/dartz.dart';
import 'package:front/core/errors/failures/failures.dart';

import '../../entities/pizza.dart';
import '../../repositories/pizza_repository.dart';

class getAllPizzasUseCase {
  final PizzaRepository repository;

  getAllPizzasUseCase(this.repository);

  Future<Either<Failure, List<Pizza>>> call() async {
    return repository.getAllPizzas();
  }
}
