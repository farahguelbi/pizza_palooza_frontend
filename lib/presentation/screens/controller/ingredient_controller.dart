import 'dart:core';

import 'package:front/data/models/ingredient_model.dart';
import 'package:front/di.dart';
import 'package:front/domain/entities/ingredient.dart';
import 'package:front/domain/usecases/ingredient_usecases/get_all_ingredients.dart';
import 'package:front/domain/usecases/ingredient_usecases/get_ingredient_by_id.dart';
import 'package:front/domain/usecases/ingredient_usecases/get_ingredients_by_layer.dart';
import 'package:front/domain/usecases/pizza_usecases/get_all_pizzas.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class IngredientController extends GetxController {
   List<Ingredient> allingredients = [];
  List<Ingredient> ingredientsList = [];
   Map<String, List<Ingredient>>? groupedIngredients; 
  bool isLoading = false;
  Ingredient?selectedIngredient;
String msg='';
//fetch all ingredients 
Future<void> getAllIngredients() async {
  isLoading = true; 
  update(); 

  final res = await GetAllIngredients(sl())(); 

  isLoading = false; 

  res.fold(
    (failure) {
      // En cas d'échec
      msg = 'Failed to load ingredients';
      allingredients=[];
      update();
    },
    (ingredients) {
      // En cas de succès
      allingredients = ingredients;
      msg = '';
      update();
    },
  );
}

//fetch ingredients By Id 

Future<void>getIngredientById(String id) async{
  isLoading=true;
   final res = await GetIngredientById(sl())( id);
   isLoading=false;
   res.fold(
      (failure) {
        msg = 'Product not found';
        update();
      },
      (ingredient) {
        selectedIngredient = ingredient;
        msg = '';
        update();
      },

    );
  
  }
 Future<void> fetchIngredientsByLayer() async {
    isLoading = true;
    update();

    final res = await GetIngredientsByLayer(sl())();

    isLoading = false;

    res.fold(
      (failure) {
        msg = 'Failed to load ingredients by layer.';
        groupedIngredients = null;
        update();
      },
      (ingredients) {
        groupedIngredients = ingredients;
        msg = '';
        update();
      },
    );
 }

}

