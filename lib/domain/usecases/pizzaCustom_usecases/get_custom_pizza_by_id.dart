// lib/domain/usecases/get_pizza_by_id.dart
import 'package:dartz/dartz.dart';
import 'package:front/core/errors/failures/failures.dart';
import 'package:front/domain/entities/pizzaCustom.dart';
import 'package:front/domain/repositories/pizza_custom_repository.dart';

class GetCustomPizzaById {
  final PizzaCustomRepository repository;

  GetCustomPizzaById(this.repository);

  Future<Either<Failure, PizzaCustom>> call(String id) async {
    return await repository.getCustomPizzaById(id);
  }
}
