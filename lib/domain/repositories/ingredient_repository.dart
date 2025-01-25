import 'package:dartz/dartz.dart';
import 'package:front/core/errors/failures/failures.dart';

import '../entities/ingredient.dart';

abstract class IngredientRepository {
Future<Either<Failure, List<Ingredient>>> getAllIngredients(); 
  Future<Either<Failure, Ingredient>> getIngredientById(String id);
  Future<Either<Failure, Map<String, List<Ingredient>>>> getIngredientsByLayer();
}
