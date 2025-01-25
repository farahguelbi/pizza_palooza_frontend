import 'package:flutter/material.dart';
import 'package:front/presentation/screens/controller/authentification_controller.dart';
import 'package:front/presentation/screens/controller/pizza_controller.dart';
import 'package:front/presentation/screens/screens/edit_profile_screen.dart';
import 'package:front/presentation/screens/screens/login_page.dart';
import 'package:front/presentation/screens/widget/app_bar.dart';
import 'package:front/presentation/screens/widget/drawer_widget.dart';
import 'package:front/presentation/screens/widget/pizza_item.dart';
import 'package:front/presentation/screens/widget/search_input.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    final PizzaController pizzaController = Get.put(PizzaController());
@override
  void initState() {
    super.initState();
    pizzaController.getAllpizzas(); // Charger les pizzas dès le démarrage
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB17C46), // Background color
      // AppBar en haut
      appBar:  const CustomAppBar(),
      // Drawer pour la navigation
      drawer: const CustomDrawer(),

         body: Column(
          
         
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
               const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0), 
            child: SearchInput(), 
            
          ),
          const SizedBox(height: 20,),
 Expanded(
            child: GetBuilder<PizzaController>(
              builder: (controller) {
                if (controller.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(), 
                  );
                }

                if (controller.allPizzas.isEmpty) {
                  return const Center(
                    child: Text(
                      "No pizzas availa!",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  );
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: controller.allPizzas.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Nombre d'éléments par ligne
                    crossAxisSpacing: 10, // Espacement horizontal
                    mainAxisSpacing: 10, // Espacement vertical
                    childAspectRatio: 0.75, // Proportion largeur/hauteur
                  ),
                  itemBuilder: (context, index) {
                    return PizzaItem(pizza: controller.allPizzas[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}