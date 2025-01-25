import 'package:dartz/dartz.dart';
import 'package:front/core/errors/failures/failures.dart';

import '../../entities/pizza.dart';
import '../../repositories/pizza_repository.dart';

class GetPizzaByType {
  final PizzaRepository repository;

  GetPizzaByType(this.repository);

  Future<Either<Failure, List<Pizza>>> call(String type) async {
    return repository.getPizzaByType(type);
  }
  }

