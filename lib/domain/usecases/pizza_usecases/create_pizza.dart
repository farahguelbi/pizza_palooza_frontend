import 'package:dartz/dartz.dart';
import 'package:front/core/errors/failures/failures.dart';

import '../../entities/pizza.dart';
import '../../repositories/pizza_repository.dart';

class CreatePizza {
  final PizzaRepository repository;

  CreatePizza(this.repository);

  Future<Either<Failure, Unit>> call(Pizza pizza) async {
    return repository.createPizza(pizza);
  }
}
