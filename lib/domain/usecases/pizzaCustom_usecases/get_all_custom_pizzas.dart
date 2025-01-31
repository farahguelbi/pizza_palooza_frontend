// lib/domain/usecases/get_all_pizzas.dart
import 'package:dartz/dartz.dart';
import 'package:front/core/errors/failures/failures.dart';
import 'package:front/domain/entities/pizzaCustom.dart';
import 'package:front/domain/repositories/pizza_custom_repository.dart';

class GetAllCustomPizzas {
  final PizzaCustomRepository repository;

  GetAllCustomPizzas(this.repository);

  Future<Either<Failure, List<PizzaCustom>>> call() async {
    return await repository.getAllCustomPizzas();
  }
}
