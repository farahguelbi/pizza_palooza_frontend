import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:front/presentation/controller/side_controller.dart';
import 'package:front/domain/entities/sides.dart';

class SideScreen extends StatefulWidget {
  const SideScreen({Key? key}) : super(key: key);

  @override
  _SideScreenState createState() => _SideScreenState();
}

class _SideScreenState extends State<SideScreen> {
  late SideController sideController;

  @override
  void initState() {
    super.initState();
    // Obtenir une instance du contrôleur enregistrée dans GetX
    sideController = Get.find<SideController>();
    print('SideController initialized in SideScreen');

    // Récupérer tous les sides au démarrage
    sideController.getAllsides();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Sides"),
        backgroundColor: const Color(0xFF790303),
      ),
      body: GetBuilder<SideController>(
        builder: (controller) {
          // Chargement
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Erreur
          if (controller.msg.isNotEmpty) {
            return Center(
              child: Text(
                controller.msg,
                style: const TextStyle(fontSize: 18, color: Colors.black),
              ),
            );
          }

          // Liste des sides
          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: controller.AllSides.length,
            itemBuilder: (context, index) {
              final side = controller.AllSides[index];
              return SideCart(side: side); // Affiche chaque side avec SideCart
            },
          );
        },
      ),
    );
  }
}

class SideCart extends StatelessWidget {
  final Side side;

  const SideCart({Key? key, required this.side}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10),
         
          ),
          title: Text(
            side.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          subtitle: Text(
            "\$${side.price.toStringAsFixed(2)}",
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.add_circle, color: Colors.red),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("${side.name} added to cart"),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
