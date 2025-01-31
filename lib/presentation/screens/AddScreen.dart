import 'dart:math';
import 'package:flutter/material.dart';
import 'package:front/presentation/controller/pizza_controller.dart';
import 'package:get/get.dart';
import '../controller/ingredient_controller.dart';
import '../controller/custom_pizza_controller.dart';  // Import CustomPizzaController

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> with SingleTickerProviderStateMixin {
  String selectedSize = 'S'; // Default size selection
  late AnimationController _controller; // Animation controller
  late Animation<double> _rotationAnimation;
  late Animation<double> _sizeAnimation;
  final IngredientController ingredientController = Get.put(IngredientController());
  final CustomPizzaController customPizzaController = Get.put(CustomPizzaController()); 

  List<Map<String, dynamic>> selectedIngredients = []; // To store the selected ingredients and their quantities
  double totalPrice = 0;

  // Pizza sizes
  final Map<String, double> sizeMap = {
    'S': 200,
    'M': 250,
    'L': 300,
  };

  Map<String, double> selectedPizzaPrices = {
    'S': 8.0,  // Initial price for small pizza
    'M': 10.0, // Initial price for medium pizza
    'L': 12.0, // Initial price for large pizza
  };

  String getSize(String S){
    switch (S) {
      case 'S':return 'small';
       case 'M':return 'medium';
       case 'L':return 'large';
      default:
      return 'small';
    }

  }

  double currentSize = 200; // Default pizza size

  @override
  void initState() {
    super.initState();
    //initialize the total price
    totalPrice = selectedPizzaPrices['S'] ?? 8.0;

    // Initialize the animation controller
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500), // Animation duration
      vsync: this,
    );

    // Initialize the rotation animation
    _rotationAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Initialize the size animation
    _sizeAnimation = Tween<double>(begin: 200, end: 200).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Fetch ingredients
    ingredientController.getAllIngredients();
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the controller
    super.dispose();
  }

  void _updatePizzaSize(String size) {
    if (size == selectedSize) return; // Skip if the size is the same

    setState(() {
      selectedSize = size;
      double newSize = sizeMap[size] ?? 200;

      // Update the size animation
      _sizeAnimation = Tween<double>(begin: currentSize, end: newSize).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
      );

      currentSize = newSize; // Update the current size
    });
    // Update the total price based on the selected size
    totalPrice = selectedPizzaPrices[selectedSize] ?? 0;
    // Start the animation
    _controller.forward(from: 0);
  }

  void _addIngredient(String ingredient) {
    // Check if the ingredient is already added, and increase the quantity if it is
    bool ingredientExists = false;
    for (var item in selectedIngredients) {
      if (item['ingredient'] == ingredient) {
        item['quantity']++;
        ingredientExists = true;
        break;
      }
    }

    if (!ingredientExists) {
      selectedIngredients.add({'ingredient' : ingredient , 'quantity': 1});
    

    // // Update the total price
    // totalPrice = selectedPizzaPrices[selectedSize] ?? 0; // Start with the pizza size price
    // selectedIngredients.forEach((item) {
    //   totalPrice += item['ingredient'].price * item['quantity'];
    // }
    // );

    setState(() {});
  }
  }
  void _removeIngredient(ingredient) {
    // Check if the ingredient exists, and decrease the quantity if it's more than 1, otherwise remove it
    for (var item in selectedIngredients) {
      if (item['ingredient'] == ingredient['ingredient']) {
        if (item['quantity'] > 1) {
          item['quantity']--;
        } else {
          selectedIngredients.remove(item);
        }
        break;
      }
    }

    // // Update the total price
    // totalPrice = selectedPizzaPrices[selectedSize] ?? 0; // Start with the pizza size price
    // selectedIngredients.forEach((item) {
    //   totalPrice += item['ingredient'].price * item['quantity'];
    // });

    setState(() {});
  }

  // Call the createCustomPizza function from the CustomPizzaController
  void _addToCart(String selectedSize,List<Map<String,dynamic>>ingredients) async {
    
  Map<String, dynamic> ingredientsData = {
        'selectedSize':selectedSize ,  
        'ingredients':ingredients
      };

    // Call the createPizza usecase via the controller
    bool result = await customPizzaController.createCustomPizza( getSize(selectedSize) , ingredients);

    if (result) {
      // Handle success, maybe navigate to a new screen or show a success message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Pizza added to cart!")));
    } else {
      // Handle failure (e.g., show an error message)
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to add pizza")));
    }
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB17C46), // Background color
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(Icons.arrow_back, color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Animated Pizza on Plate
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Wooden Plate
                    Container(
                      height: 350,
                      width: 350,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/images/plate.png'), // Plate image
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Animated Pizza
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: _rotationAnimation.value * 6.2832, // Full rotation (2 * pi)
                          child: Container(
                            height: _sizeAnimation.value,
                            width: _sizeAnimation.value,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage('assets/images/pizza_main.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    // Stack to display the ingredients added on top of the pizza
                    ...selectedIngredients.map((item) {
                      return Positioned(
                        top: sizeMap[selectedSize]! / 2, // Adjust based on pizza size
                        left:sizeMap[selectedSize]! / 2-10 , // Adjust based on pizza size
                        child: Image.network(
                          item['ingredient'].image,
                          height: 130, // Adjust the size of the ingredient image
                          width: 130,  // Adjust the size of the ingredient image
                          errorBuilder: (context, error, stackTrace) =>
                              Icon(Icons.error),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Size Selector
              Container(
                height: 40,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildSizeOption('S'),
                    _buildSizeOption('M'),
                    _buildSizeOption('L'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Ingredients Table
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GetBuilder<IngredientController>(builder: (controller) {
                  if (controller.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (controller.allingredients.isEmpty) {
                    return Center(
                      child: Text("No ingredients available."),
                    );
                  }

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columnSpacing: 30.0, // Slightly increased column spacing
                      dataRowHeight: 70.0, // Moderately increased row height
                      headingRowHeight: 50.0, // Moderately increased header height
                      columns: const [
                        DataColumn(
                          label: Text("Image", style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        DataColumn(
                          label: Text("Name", style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        DataColumn(
                          label: Text("Price (\$)", style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        DataColumn(
                          label: Text("Action", style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                      rows: controller.allingredients.map((ingredient) {
                        return DataRow(
                          cells: [
                            DataCell(
                              Container(
                                width: 80, // Adjusted width for image
                                height: 80, // Adjusted height for image
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage(ingredient.image),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            DataCell(Text(ingredient.name ?? "Unknown", style: TextStyle(fontSize: 16))),
                            DataCell(Text(ingredient.price.toStringAsFixed(2), style: TextStyle(fontSize: 16))),
                            DataCell(
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () {
                                      _addIngredient(ingredient.id);
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.remove),
                                    onPressed: () {
                                      // _removeIngredient(ingredient);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 40),
              // Add to Cart Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton(
                  onPressed:( ){_addToCart(selectedSize,selectedIngredients);}, // Call the create pizza method
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF790303),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  ),
                  child: const Text(
                    "Add to Cart",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.amber),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Total Price Display
              Text(
                'Total: \$${totalPrice.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSizeOption(String size) {
    bool isSelected = size == selectedSize;
    return GestureDetector(
      onTap: () {
        _updatePizzaSize(size);
      },
      child: Container(
        height: 50,
        width: 100,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF790303) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        child: Text(
          size,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.orange.shade800,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}