// import 'package:dartz/dartz.dart';
// import 'package:front/core/errors/failures/failures.dart';
// import 'package:front/domain/entities/pizzaCustom.dart';
// import 'package:front/domain/repositories/pizza_custom_repository.dart';

// class CreatePizza {
//   final PizzaCustomRepository repository;

//   CreatePizza(this.repository);

//   Future<Either<Failure, Unit>> call(
//     String selectedSize,
//     List<Map<String,dynamic>> ingredients,
//   ) async {
//     return await repository.createPizza(selectedSize, ingredients);
//   }
// }
import 'package:dartz/dartz.dart';
import 'package:front/core/errors/failures/failures.dart';
import 'package:front/domain/entities/pizzaCustom.dart';
import 'package:front/domain/repositories/pizza_custom_repository.dart';

class CreatePizza {
  final PizzaCustomRepository repository;

  CreatePizza(this.repository);

  Future<Either<Failure, String>> call(
    String selectedSize,
    List<Map<String,dynamic>> ingredients,String userID , double price
  ) async {
    return await repository.createPizza(selectedSize, ingredients, userID ,  price);
  }
}