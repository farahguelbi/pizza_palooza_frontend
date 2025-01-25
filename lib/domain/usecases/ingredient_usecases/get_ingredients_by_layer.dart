import 'package:dartz/dartz.dart';
import 'package:front/core/errors/failures/failures.dart';

import '../../entities/ingredient.dart';
import '../../repositories/ingredient_repository.dart';

class GetIngredientsByLayer {
  final IngredientRepository repository;

  GetIngredientsByLayer(this.repository);

 Future<Either<Failure, Map<String, List<Ingredient>>>> call() async {
    return repository.getIngredientsByLayer();
  }
}
