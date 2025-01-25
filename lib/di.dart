
import 'package:front/data/datasources/local_data_source/authentification_local_data_source.dart';
import 'package:front/data/datasources/remote_data_source/ingredient_remote_datasource.dart';
import 'package:front/data/datasources/remote_data_source/pizza_remote_datasource.dart';
import 'package:front/data/datasources/remote_data_source/user_remote_datasource.dart';
import 'package:front/data/repositories/ingredient_repository_impl.dart';
import 'package:front/data/repositories/pizza_repository_impl.dart';
import 'package:front/data/repositories/user_repository_impl.dart';
import 'package:front/domain/repositories/ingredient_repository.dart';
import 'package:front/domain/repositories/pizza_repository.dart';
import 'package:front/domain/repositories/user_repository.dart';
import 'package:front/domain/usecases/ingredient_usecases/get_all_ingredients.dart';
import 'package:front/domain/usecases/ingredient_usecases/get_ingredient_by_id.dart';
import 'package:front/domain/usecases/ingredient_usecases/get_ingredients_by_layer.dart';
import 'package:front/domain/usecases/pizza_usecases/get_all_pizzas.dart';
import 'package:front/domain/usecases/pizza_usecases/get_pizza_by_id.dart';
import 'package:front/domain/usecases/user_usecases/get_user_by_id.dart';
import 'package:front/domain/usecases/user_usecases/login_user.dart';
import 'package:front/domain/usecases/user_usecases/register_user.dart';
import 'package:front/domain/usecases/user_usecases/update_password.dart';
import 'package:front/domain/usecases/user_usecases/update_user.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /* repositories */
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(sl(), sl()),
  );
    sl.registerLazySingleton<PizzaRepository>(
      () =>  PizzaRepositoryImpl(pizzaRemoteDataSource: sl())

    );

 sl.registerLazySingleton<IngredientRepository>(
      () => IngredientRepositoryImpl(ingredientsRemoteDataSource: sl()));














  // sl.registerLazySingleton<CartRepository>(() => CartRepositoryImpl(sl()));
  // sl.registerLazySingleton<WishListRepository>(
  //     () => WishListRepositoryImpl(sl()));

  // /* data sources */

  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl());
  sl.registerLazySingleton<AuthenticationLocalDataSource>(
      () => AuthenticationLocalDataSourceImpl());
      sl.registerLazySingleton<PizzaRemoteDataSource>(
  () => PizzaRemoteDataSourceImpl(),
);


  // sl.registerLazySingleton<CartRemoteDataSource>(
  //     () => CartRemoteDataSourceImpl());
  // sl.registerLazySingleton<WishListRemoteDataSource>(
  //     () => WishListRemoteDataSourceImpl());

  /* usecases */
  //authentication//
  sl.registerLazySingleton(() => RegisterUser(sl()));
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => GetUserByIdUsecase(sl()));
  sl.registerLazySingleton(() => UpdateUserUsecase(sl()));
  sl.registerLazySingleton(() => UpdatePassword(sl()));
//pizza//
  sl.registerLazySingleton(() => getAllPizzasUseCase(sl()));
  sl.registerLazySingleton(() => GetPizzaByIdUsecase(sl()));

//ingredient 
  sl.registerLazySingleton(() => GetAllIngredients(sl()));
  sl.registerLazySingleton(() => GetIngredientById(sl()));
  sl.registerLazySingleton(() => GetIngredientsByLayer(sl()));



}