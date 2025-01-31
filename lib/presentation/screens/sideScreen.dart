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
  double totalPrice = 0.0;
  Map<String, int> quantities = {};

  @override
  void initState() {
    super.initState();
    sideController = Get.find<SideController>();
    print('SideController initialized in SideScreen');
    sideController.getAllsides();
  }

  /// Increment side quantity and update total price
  void incrementSide(Side side) {
    setState(() {
      quantities[side.id] = (quantities[side.id] ?? 0) + 1;
      totalPrice += side.price;
    });
  }

  /// Decrement side quantity and update total price
  void decrementSide(Side side) {
    if (quantities[side.id] != null && quantities[side.id]! > 0) {
      setState(() {
        quantities[side.id] = quantities[side.id]! - 1;
        totalPrice -= side.price;
      });
    }
  }

  /// Handle "Order Now" button press
  void orderNow() {
   

    print("Order placed: $quantities");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Order placed! Total: \$${totalPrice.toStringAsFixed(2)}")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB17C46), // Background color
      appBar: AppBar(
        backgroundColor: const Color(0xFF790303),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
       
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Title
              const Text(
                'Add Sides',
                style: TextStyle(
                  fontFamily: 'Yellowtail',
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF790303),
                ),
              ),
              const SizedBox(height: 20),

              // Sides List
              GetBuilder<SideController>(
                builder: (controller) {
                  if (controller.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (controller.msg.isNotEmpty) {
                    return Center(
                      child: Text(
                        controller.msg,
                        style: const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    );
                  }

                  return Column(
                    children: controller.AllSides.map((side) {
                      return SideCart(
                        side: side,
                        onIncrement: () => incrementSide(side),
                        onDecrement: () => decrementSide(side),
                        quantity: quantities[side.id] ?? 0,
                      );
                    }).toList(),
                  );
                },
              ),
              const SizedBox(height: 20),

              // Total Price
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Total Price: \$${totalPrice.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'Lobster',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // "Order Now" Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: orderNow,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF790303),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      'Order Now',
                      style: TextStyle(
                        fontSize: 21,
                        fontFamily: 'Roboto',
                        color: Color(0xFFD8CAB8),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SideCart extends StatelessWidget {
  final Side side;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final int quantity;

  const SideCart({
    Key? key,
    required this.side,
    required this.onIncrement,
    required this.onDecrement,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFD9D9D9).withOpacity(0.8),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ListTile(
          title: Text(
            side.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          subtitle: Text(
            "\$${side.price.toStringAsFixed(2)}",
            style: const TextStyle(color: Colors.black54, fontSize: 14),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle, color: Color(0xFF790303)),
                onPressed: quantity > 0 ? onDecrement : null,
              ),
              Text(
                "$quantity",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle, color: Color(0xFF790303)),
                onPressed: onIncrement,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
