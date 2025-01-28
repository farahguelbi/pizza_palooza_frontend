import 'package:front/di.dart';
import 'package:front/domain/entities/sides.dart';
import 'package:front/domain/usecases/side_usecases/get_all_sides.dart';
import 'package:front/domain/usecases/side_usecases/get_side_by_id.dart';
import 'package:get/get.dart';

class SideController extends GetxController {
   List<Side> AllSides = [];
  List<Side> SidesList = [];
  bool isLoading = false;
  String msg = '';
  Side ?selectedSide;
   Future<bool> getAllsides() async {
    isLoading = true;
    update();
    final res = await GetAllSidesUseCase(sl())();
    isLoading = false;

    res.fold(
      (failure) {
        msg = 'Failed to load products';
        AllSides=[];
        update();
        return false;
      },
      (sides) {
        AllSides = sides;
        msg = '';
        update();
        return true;
      },
    );
    return true;
  }
  // Fetch a single product by ID
  Future<bool> getSideById(String id) async {
    isLoading = true;

    final res = await GetSideById(sl())( id);
    isLoading = false;

    res.fold(
      (failure) {
        msg = 'Product not found';
        selectedSide=null;
        update();
        return false;
      },
      (side) {
        selectedSide = side;
        msg = '';
        update();
        return true;
     
      },

    );
    return true;
}

}