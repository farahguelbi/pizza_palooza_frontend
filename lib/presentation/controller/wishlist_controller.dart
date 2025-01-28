// import 'package:front/domain/entities/wishlist.dart';
// import 'package:front/domain/usecases/wishlist_usecases/add_to_wishlist.dart';
// import 'package:front/domain/usecases/wishlist_usecases/get_wishlist.dart';
// import 'package:front/domain/usecases/wishlist_usecases/remove_from_wishlist.dart';
// import 'package:get/get.dart';

// import '../../di.dart';

// class WishlistController extends GetxController {
//     late Wishlist currentWishlist;

//     List<Wishlist> Allwishlist = [];
//   List<Wishlist> WishlistList = [];
//   bool isLoading = false;
//   String msg = '';
//   Wishlist ?selectedWishlist;
  
//   //get wishlist
//    Future<bool> getWishlistById(String id) async {
    
//     isLoading = true;

//     final res = await GetWishlist(sl())( id);
//     isLoading = false;

//     res.fold(
//       (failure) {
//         msg = 'Wishlist not found';
//         selectedWishlist=null;
//         update();
//         return false;
//       },
//       (Wishlist) {
//         selectedWishlist = Wishlist;
//         msg = '';
//         update();
//         return true;
     
//       },

//     );
//     return true;


//   }
//   //add to wishlist 
//   Future<void> addToWishlist(String userId, String pizzaId) async {
//     isLoading = true;
//     update();

//     final res = await AddToWishlist(sl())(userId, pizzaId); // Appel au use case
//     isLoading = false;

//     res.fold(
//       (failure) {
//         msg = 'Failed to add pizza to wishlist';
//         update();
//       },
//       (_) async {
//         msg = 'Pizza added successfully';
//         // Recharge la wishlist après ajout
//         await getWishlistById(userId);
//       },
//     );
//   }
//  // **Supprimez un élément de la wishlist**
//   Future<void> removeFromWishlist(String userId, String pizzaId) async {
//     isLoading = true;
//     update();

//     final res = await RemoveFromWishlist(sl())(userId, pizzaId); // Appel au use case
//     isLoading = false;

//     res.fold(
//       (failure) {
//         msg = 'Failed to remove pizza from wishlist';
//         update();
//       },
//       (_) async {
//         msg = 'Pizza removed successfully';
//         // Recharge la wishlist après suppression
//         await getWishlistById(userId);
//       },
//     );
//   }

// }
import 'package:front/domain/usecases/wishlist_usecases/create_wishlist.dart';
import 'package:get/get.dart';
import '../../domain/entities/wishlist.dart';
import '../../di.dart';
import '../../domain/usecases/wishlist_usecases/add_to_wishlist.dart';
import '../../domain/usecases/wishlist_usecases/get_wishlist.dart';
import '../../domain/usecases/wishlist_usecases/remove_from_wishlist.dart';

class WishlistController extends GetxController {
  List<Wishlist> wishlistItems = [];

  Wishlist? userWishlist;
  bool isLoading = false;
  String errorMessage = '';

//create wishlist 


// Create a wishlist for a user
 Future<bool> createWishlist(String userId) async {
    isLoading = true;
    update(); // Met à jour l'état pour indiquer le chargement

    final res = await CreateWishListUseCase(sl())(userId: userId);
    isLoading = false;

    return res.fold(
      (failure) {
        errorMessage = 'Failed to create wishlist';
        update();
        return false;
      },
      (_) {
        errorMessage = '';
        update();
        return true;
      },
    );
  }
  // Fetch wishlist for a user
  Future<bool> getWishlistByUserId(String userId) async {
    isLoading = true;
    errorMessage = '';
    update();

    final result = await GetWishlist(sl())(userId);
     isLoading=false;
    result.fold(
      (failure) {
        errorMessage = 'Failed to fetch wishlist. Please try again later.';
        userWishlist = null;
      },
      (wishlist) {
          userWishlist = wishlist;
          errorMessage="";
      },
    );
    update();

    isLoading = false;
    update();
    return userWishlist!=null;
  }

  // Add a pizza to the wishlist
  Future<bool> addPizzaToWishlist(String userId, String pizzaId) async {
    isLoading = true;
    errorMessage = '';
    update();

    final result = await AddToWishlist(sl())(userId,  pizzaId);
       bool success = false;
    result.fold(
      (failure) {
        errorMessage = 'Failed to add pizza to wishlist.';
      },
      (_) async {
        success = true;

        await getWishlistByUserId(userId);
      },
    );

    isLoading = false;
    update();
          return success;

  }

  // Remove a pizza from the wishlist
  Future<bool> removePizzaFromWishlist(String userId, String pizzaId) async {
    isLoading = true;
    errorMessage = '';
    update();

    final result = await RemoveFromWishlist(sl())(userId,  pizzaId);
     bool success = false;
    result.fold(
      (failure) {
        errorMessage = 'Failed to remove pizza from wishlist.';
        update();
      },
      (_) async {
        success = true;
        // Refresh the wishlist after successful removal
        await getWishlistByUserId(userId);
      },
    );

    isLoading = false;
    update();
     return success;
  }
  /// Réinitialise la wishlist (utile lors de la déconnexion ou d'un nettoyage)
  void resetWishlist() {
    userWishlist = null;
    errorMessage = '';
    update();
  }

  /// Récupère l'ID de la wishlist actuelle si elle est chargée
  String? getWishlistIdForUser(String? userId) {
    if (userId == null) return null;
    return userWishlist?.id;
  }
}
