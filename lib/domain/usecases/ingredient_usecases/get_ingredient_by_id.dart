import 'package:dartz/dartz.dart';
import 'package:front/core/errors/failures/failures.dart';

import '../../entities/ingredient.dart';
import '../../repositories/ingredient_repository.dart';

class GetIngredientById {
  final IngredientRepository repository;

  GetIngredientById(this.repository);

  Future<Either<Failure, Ingredient>> call(String id) async {
    return repository.getIngredientById(id);
  }
}
