import 'package:dartz/dartz.dart';
import 'package:front/core/errors/failures/failures.dart';

import '../../entities/ingredient.dart';
import '../../repositories/ingredient_repository.dart';

class GetAllIngredients {
  final IngredientRepository repository;

  GetAllIngredients(this.repository);

  Future<Either<Failure, List<Ingredient>>> call() async {
    return repository.getAllIngredients();
  }
}
