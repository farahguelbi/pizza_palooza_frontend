import 'package:dartz/dartz.dart';
import 'package:front/core/errors/failures/failures.dart';

import '../../entities/pizza.dart';
import '../../repositories/pizza_repository.dart';

class SearchPizzas {
  final PizzaRepository repository;

  SearchPizzas(this.repository);

 Future<Either<Failure, List<Pizza>>> call(String name) async {
    return repository.searchPizzas(name);
  }
}
