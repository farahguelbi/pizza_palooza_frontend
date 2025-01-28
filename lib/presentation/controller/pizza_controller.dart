import 'package:front/core/errors/failures/failures.dart';
import 'package:front/di.dart';
import 'package:front/domain/entities/pizza.dart';
import 'package:front/domain/usecases/pizza_usecases/get_all_pizzas.dart';
import 'package:front/domain/usecases/pizza_usecases/get_pizza_by_id.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class PizzaController extends GetxController {
  List<Pizza> allPizzas = [];
  List<Pizza> pizzasList = [];
  bool isLoading = false;
  String msg = '';
  Pizza ?selectedPizza;

// 
   Future<bool> getAllpizzas() async {
    isLoading = true;
    update();
    final res = await getAllPizzasUseCase(sl())();
    isLoading = false;

    res.fold(
      (failure) {
        msg = 'Failed to load products';
        allPizzas=[];
        update();
        return false;
      },
      (pizzas) {
        allPizzas = pizzas;
        msg = '';
        update();
        return true;
      },
    );
    return true;
  }
 // Fetch a single product by ID
  Future<bool> getPizzatById(String id) async {
    isLoading = true;

    final res = await GetPizzaByIdUsecase(sl())( id:id);
    isLoading = false;

    res.fold(
      (failure) {
        msg = 'Product not found';
        selectedPizza=null;
        update();
        return false;
      },
      (pizza) {
        selectedPizza = pizza;
        msg = '';
        update();
        return true;
     
      },

    );
    return true;

  }


  
}
