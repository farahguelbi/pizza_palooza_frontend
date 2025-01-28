// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:front/data/models/pizza_model.dart';
// import 'package:front/domain/entities/pizza.dart';

// class PizzaItem extends StatelessWidget {
//   final Pizza pizza;
//   const PizzaItem({super.key ,required this.pizza});

//   @override
//   Widget build(BuildContext context) {
    
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 6.0),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(15),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.2),
//               spreadRadius: 2,
//               blurRadius: 5,
//               offset: const Offset(0, 3),
//             ),
            
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ClipRRect(
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(15),
//                 topRight: Radius.circular(15),

//               ),
//               child: Image.network(
//                 pizza.image,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             Expanded(
//               child: Padding
//               (padding: const EdgeInsets.all(10.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     pizza.name??'--no Name Available',
//                     style: TextStyle(
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   Text(
//                     pizza.reference??'No description Available',
//                      style: TextStyle(
//                         fontSize: 12.sp,
//                         color: Colors.grey[700],
//                       ),
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                    Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           '${pizza.price.toStringAsFixed(2)}D',
//                           style: TextStyle(
//                             fontSize: 16.sp,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black,
//                           ),
//                         ),
//                         IconButton(
//                           onPressed: () {
//                             // Add favorite functionality here
//                           },
//                           icon: Icon(
//                             Icons.favorite_border,
//                             color: Colors.grey[600],
//                           ),
//                         )
//                 ],
//               ),
//                 ]
//               )
//             )
//             )
//           ],
//         ),
//       ),
//       );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:front/domain/entities/pizza.dart';
// import 'package:front/presentation/screens/pizza_details_screen.dart';


// class PizzaItem extends StatelessWidget {
//   final Pizza pizza;

//   const PizzaItem({Key? key, required this.pizza}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: (){
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context)=>PizzaDetailsScreen(pizza: pizza)
//           ),
//           );
//       },
    
  
    
//     child :Container(
//       height: 250,
//       decoration: BoxDecoration(
//         color: Color(0xFFFD9D9D9),
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Image de la pizza
//           ClipRRect(
//             borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(15),
//               topRight: Radius.circular(15),
//             ),
//             child: Image.network(
//               pizza.image,
//               height: 120,
//               width: double.infinity,
//               fit: BoxFit.cover,
//             ),
//           ),
//           // Contenu texte
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Nom de la pizza
//                 Text(
//                   pizza.name,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                   ),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 const SizedBox(height: 4),
//                 // Description ou référence de la pizza
//                 Text(
//                   pizza.reference,
//                   style: const TextStyle(
//                     fontSize: 12,
//                     color: Colors.grey,
//                   ),
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 const SizedBox(height: 8),
//                 // Ligne avec prix et bouton favori
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       '${pizza.sizes.medium.toStringAsFixed(2)} \$',
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                     IconButton(
//                       icon: const Icon(
//                         Icons.favorite_border,
//                         color: Colors.grey,
//                       ),
//                       onPressed: () {
                      
//                       },
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ),
      
//         ],
//       ),
//     ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:front/domain/entities/pizza.dart';
import 'package:front/presentation/controller/authentification_controller.dart';
import 'package:front/presentation/controller/wishlist_controller.dart';
import 'package:front/presentation/screens/pizza_details_screen.dart';
import 'package:get/get.dart';

/// Widget pour afficher un élément de pizza avec gestion de l'état de wishlist
class PizzaItem extends StatefulWidget {
  final Pizza pizza;

  const PizzaItem({Key? key, required this.pizza}) : super(key: key);

  @override
  _PizzaItemState createState() => _PizzaItemState();
}

class _PizzaItemState extends State<PizzaItem> {
  late bool isInWishlist; // Indique si l'article est dans la wishlist

  @override
  void initState() {
    super.initState();
    isInWishlist = false; // Valeur par défaut
    _checkWishlistStatus(); // Vérification initiale
  }

  /// Vérifie si la pizza est dans la wishlist (synchronisation avec le backend)
  void _checkWishlistStatus() {
    final WishlistController wishlistController = Get.find();
    final AuthenticationController authenticationController = Get.find();
    final String? currentUserId = authenticationController.currentUser?.id;

    if (currentUserId != null) {
      wishlistController.getWishlistByUserId(currentUserId).then((success) {
        if (success && wishlistController.userWishlist != null) {
          // Synchronise l'état local avec la liste du backend
          setState(() {
            isInWishlist = wishlistController.userWishlist!.pizzas.contains(widget.pizza.id);
          });
        }
      });
    }
  }

  /// Gère l'ajout ou la suppression de la pizza dans la wishlist
  void _toggleFavorite() async {
    final WishlistController wishlistController = Get.find();
    final AuthenticationController authenticationController = Get.find();
    final String? currentUserId = authenticationController.currentUser?.id;

    if (currentUserId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please log in to manage your wishlist')),
      );
      return;
    }

    // Inverse l'état local
    bool newWishlistState = !isInWishlist;
    setState(() {
      isInWishlist = newWishlistState; // Met à jour l'état immédiatement pour une meilleure UX
    });

    // Effectue l'ajout ou la suppression
    final success = isInWishlist
        ? await wishlistController.addPizzaToWishlist(currentUserId, widget.pizza.id)
        : await wishlistController.removePizzaFromWishlist(currentUserId, widget.pizza.id);

    // Si l'opération échoue, réinitialise l'état local
    if (!success) {
      setState(() {
        isInWishlist = !isInWishlist;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update wishlist')),
      );
    }

    // Ajoutez des journaux pour déboguer
    print(isInWishlist
        ? 'Pizza added to wishlist: ${widget.pizza.id}'
        : 'Pizza removed from wishlist: ${widget.pizza.id}');
  }

  @override
  Widget build(BuildContext context) {
    
    return InkWell(
      onTap: () {
        // Navigate vers l'écran des détails de la pizza
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PizzaDetailsScreen(pizza: widget.pizza)),
        ).then((_) {
          // Revérifie l'état de la wishlist après le retour
          _checkWishlistStatus();
        });
      },
      child: Container(
        height: 250,
        decoration: BoxDecoration(
          color: const Color(0xFFFD9D9D9),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image de la pizza
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: Image.network(
                widget.pizza.image,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            // Informations texte
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nom de la pizza
                  Text(
                    widget.pizza.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  // Référence ou description
                  Text(
                    widget.pizza.reference,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  // Prix et icône de wishlist
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${widget.pizza.sizes.medium.toStringAsFixed(2)} \$',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      IconButton(
                        onPressed: _toggleFavorite,
                        icon: Icon(
                          isInWishlist ? Icons.favorite : Icons.favorite_border,
                          color: isInWishlist ? Colors.red : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
