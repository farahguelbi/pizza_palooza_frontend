import 'dart:convert';

import 'package:front/core/errors/exceptions/exceptions.dart';
import 'package:front/core/utils/api_const.dart';
import 'package:http/http.dart' as http;
import '../../models/wishlist_model.dart';

abstract class WishlistRemoteDataSource {
    Future<void> createWishList({required String userId});
  Future<void> addToWishlist({required String userId, required String pizzaId});
  Future<void> removeFromWishlist({required String userId, required String pizzaId});
  Future<WishlistModel> getWishlist({required String userId});
}

class WishlistRemoteDataSourceImpl implements WishlistRemoteDataSource {
 @override
  Future<void> createWishList({required String userId}) async {
    try {
      final url = Uri.parse(ApiConst.createWishList);
      final body = jsonEncode({'userId': userId, 'pizzasId': []});
      print(body);
      final res = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );
      if (res.statusCode != 200) {
        throw ServerException(message: "Failed to create wishlist");
      }
    } catch (e) {
      rethrow;
    }
  }
@override
Future<void> addToWishlist({required String userId, required String pizzaId}) async {
  try {
    // Log the payload for debugging
    print('Sending request to add pizza to wishlist:');
    print('URL: ${ApiConst.addToWishlist}');
    print('Payload: {"userID": "$userId", "pizzaId": "$pizzaId"}');

    // Send the HTTP request
    final response = await http.post(
      Uri.parse(ApiConst.addToWishlist),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'userID': userId, 'pizzaId': pizzaId}), // Use 'userId'
    );

    // Log the server response
    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode != 200) {
      // Parse and log the error message
      final responseBody = json.decode(response.body);
      final errorMessage = responseBody['message'] ?? 'Unknown error occurred';
      throw ServerException(
        message: 'Failed to add pizza to wishlist. Status code: ${response.statusCode}, Error: $errorMessage',
      );
    }

    // Log success for debugging
    print('Pizza successfully added to wishlist.');
  } catch (e) {
    // Log and rethrow the exception
    print('Error in addToWishlist: $e');
    throw ServerException(message: 'Error adding pizza to wishlist: $e');
  }
}


//  @override
//   Future<void> addToWishlist({required String userId, required String pizzaId}) async {
//     try {
//       final response = await http.post(
//         Uri.parse(ApiConst.addToWishlist),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode({'userId': userId, 'pizzaId': pizzaId}),
//       );
        
//       if (response.statusCode != 200) {
//         final responseBody = json.decode(response.body);
//       final errorMessage = responseBody['message'] ?? 'Unknown error occurred';
//         throw ServerException(message: 'Failed to add pizza to wishlist. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw ServerException(message: 'Error adding pizza to wishlist: $e');
//     }
//   }
  @override
  Future<void> removeFromWishlist({required String userId, required String pizzaId}) async {
    try {
      final response = await http.delete(
        Uri.parse('${ApiConst.removeFromWishlist}/$userId/$pizzaId'),
        headers: {'Content-Type': 'application/json'},
        // body: json.encode({'userId': userId, 'pizzaId': pizzaId}),
      );

      if (response.statusCode != 200) {
        throw ServerException(message: 'Failed to remove pizza from wishlist. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw ServerException(message: 'Error removing pizza from wishlist: $e');
    }
  }

  @override
  Future<WishlistModel> getWishlist({required String userId}) async {
      print('[RemoteDataSource] Fetching wishlist for userId: $userId');

    try {
      final response = await http.get(
        Uri.parse(ApiConst.getWishlist(userId)),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        try {
          final Map<String, dynamic> jsonResponse = json.decode(response.body);
          print(WishlistModel.fromJson(jsonResponse));
                print('[RemoteDataSource] Parsed Response: $jsonResponse');


          return WishlistModel.fromJson(jsonResponse);
        } catch (e) {
          throw ParsingException(message: 'Error parsing wishlist response: $e');
        }
      } else {
            print('[RemoteDataSource] Server Error: Status Code ${response.statusCode}');

        throw ServerException(message: 'Failed to fetch wishlist. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print(e.toString());
      throw ServerException(message: 'Error fetching wishlist: $e');
    }
  }
}