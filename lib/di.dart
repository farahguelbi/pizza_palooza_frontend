
import 'package:front/data/datasources/local_data_source/authentification_local_data_source.dart';
import 'package:front/data/datasources/remote_data_source/pizza_remote_datasource.dart';
import 'package:front/data/datasources/remote_data_source/user_remote_datasource.dart';

import 'package:front/data/repositories/pizza_repository_impl.dart';

import 'package:front/data/repositories/user_repository_impl.dart';


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
import 'package:front/domain/usecases/wishlist_usecases/create_wishlist.dart';

import 'package:get_it/get_it.dart';

import 'data/datasources/remote_data_source/side_remote_datasource.dart';
import 'data/datasources/remote_data_source/wishlist_remote_datasource.dart';
import 'data/repositories/side_repository_impl.dart';
import 'data/repositories/wishlist_repository_impl.dart';
import 'domain/repositories/Side_repository.dart';
import 'domain/repositories/wishlist_repository.dart';
import 'domain/usecases/side_usecases/get_all_sides.dart';
import 'domain/usecases/side_usecases/get_side_by_id.dart';
import 'domain/usecases/wishlist_usecases/add_to_wishlist.dart';
import 'domain/usecases/wishlist_usecases/get_wishlist.dart';
import 'domain/usecases/wishlist_usecases/remove_from_wishlist.dart';


final sl = GetIt.instance;

Future<void> init() async {

 // /* data sources */
  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl());
  sl.registerLazySingleton<AuthenticationLocalDataSource>(
      () => AuthenticationLocalDataSourceImpl());
  sl.registerLazySingleton<PizzaRemoteDataSource>(
  () => PizzaRemoteDataSourceImpl(),);

   sl.registerLazySingleton<WishlistRemoteDataSource>(
    () => WishlistRemoteDataSourceImpl(),
  );
    sl.registerLazySingleton<SideRemoteDataSource>(
    () => SideRemoteDataSourceImpl(),
  );



  /* repositories */
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(sl(), sl()),
  );
    sl.registerLazySingleton<PizzaRepository>(
      () =>  PizzaRepositoryImpl(pizzaRemoteDataSource: sl())
    );


 sl.registerLazySingleton<WishlistRepository>(
      () => WishlistRepositoryImpl(wishlistRemoteDataSource: sl()));


sl.registerLazySingleton<SideRepository>(
  ()=>SideRepositoryImpl(sideRemoteDataSource: sl())
  
);


  // sl.registerLazySingleton<CartRepository>(() => CartRepositoryImpl(sl()));
  // sl.registerLazySingleton<WishListRepository>(
  //     () => WishListRepositoryImpl(sl()));

 


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
//sides 
sl.registerLazySingleton(() => GetAllSidesUseCase(sl()));
sl.registerLazySingleton(() => GetSideById(sl()));
//wishlist
sl.registerLazySingleton(() => CreateWishListUseCase(sl()));
sl.registerLazySingleton(() => GetWishlist(sl()));
sl.registerLazySingleton(() => RemoveFromWishlist(sl()));
sl.registerLazySingleton(() => AddToWishlist(sl()));


}