// lib/data/repositories/pizza_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:front/data/models/ingredient_model.dart';
import 'package:front/data/models/pizza_model.dart';

import '../../core/errors/failures/failures.dart';
import '../../core/errors/exceptions/exceptions.dart';
import '../../domain/entities/pizza.dart';
import '../../domain/repositories/pizza_repository.dart';
import '../datasources/remote_data_source/pizza_remote_datasource.dart';

class PizzaRepositoryImpl implements PizzaRepository {
  final PizzaRemoteDataSource pizzaRemoteDataSource;

  PizzaRepositoryImpl({required this.pizzaRemoteDataSource});

  @override
  Future<Either<Failure, List<Pizza>>> getAllPizzas() async {
    try {
      final pizzas = await pizzaRemoteDataSource.getAllPizzas();
      return Right(pizzas);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Pizza>> getPizzaById({required String id}) async {
    try {
      final pizza = await pizzaRemoteDataSource.getPizzaById(id);
      return Right(pizza);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

/*@override
Future<Either<Failure, Unit>> createPizza(Pizza pizza) async {
  try {
    final pizzaModel = PizzaModel(
      id: pizza.id,
      name: pizza.name,
      image: pizza.image,
      reference: pizza.reference,
      description: pizza.description,
      price: pizza.price,
      ingredients: pizza.ingredients
          .map((ingredient) => PizzaIngredientModel(
                ingredient: IngredientModel(
                  id: ingredient.ingredient.id,
                  name: ingredient.ingredient.name,
                  price: ingredient.ingredient.price,
                  image: ingredient.ingredient.image,
                  layer: ingredient.ingredient.layer,
                ),
                quantity: ingredient.quantity,
              ))
          .toList(),
      type: pizza.type,
      sizes: pizza.sizes
          .map((size) => PizzaSizeModel(
                size: size.size,
                price: size.price,
              ))
          .toList(),
    );

    await pizzaRemoteDataSource.createPizza(pizzaModel.toJson());
    return Right(unit);
  } catch (e) {
    return Left(ServerFailure());
  }
}

*/
  @override
  Future<Either<Failure, List<Pizza>>> getPizzaByType(String type) async {
    try {
      final pizzas = await pizzaRemoteDataSource.getPizzaByType(type);
      return Right(pizzas);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Pizza>>> searchPizzas(String name) async {
    try {
      final pizzas = await pizzaRemoteDataSource.searchPizzas(name);
      return Right(pizzas);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
  
  @override
  Future<Either<Failure, Unit>> createPizza(Pizza pizza) {
    // TODO: implement createPizza
    throw UnimplementedError();
  }
  

}
