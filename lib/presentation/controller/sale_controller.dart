import 'package:front/domain/usecases/sale_usecases/create_sale.dart';
import 'package:get/get.dart';

import '../../data/models/sale_model.dart';
import '../../di.dart';

class SaleController extends GetxController {
   List<SaleModel> sales = [];
  SaleModel? selectedSale;
  bool isLoading = false;
  String errorMessage = '';
  /// Create a new sale

Future<void> createSale(Map<String, dynamic> saleData) async {
  isLoading = true; // Set loading state
  errorMessage = ''; // Clear any previous error
  update(); // Notify UI of changes

  try {
    // Call the CreateSale use case with the injected dependency
    final newSale = await CreateSale(sl());

    // Add the newly created sale to the sales list
    sales.add(newSale as SaleModel);

    // Notify the user of the success
    Get.snackbar('Success', 'Sale created successfully');
  } catch (e) {
    // Handle and log the error
    errorMessage = 'Failed to create sale: ${e.toString()}';
    Get.snackbar('Error', errorMessage);
  } finally {
    isLoading = false; // Reset loading state
    update(); // Notify UI of changes
  }
}

}