import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:front/core/errors/exceptions/exceptions.dart';
import 'package:front/core/utils/api_const.dart';
import 'package:front/data/datasources/local_data_source/authentification_local_data_source.dart';
import 'package:front/data/datasources/local_data_source/settings_local_data_source.dart';
import 'package:front/data/models/token_model.dart';
import 'package:front/data/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http_parser/http_parser.dart';




abstract class UserRemoteDataSource {
  Future<TokenModel?> autoLogin();
  Future<String> registerUser({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
     String? address,
     String? phone,
   String? image,
     DateTime? birthDate,
     String? gender,
  });

  Future<TokenModel> loginUser({
    required String email,
    required String password,
  });

  Future<UserModel> getUserById(String userId);

  Future<List<UserModel>> getAllUsers();

  Future<void> updateUser({
    required String id,
    required String firstName,
    required String lastName,
    required String address,
    required String phone,
    required String gender,
    required DateTime birthDate,
  });

  Future<void> updatePassword({
    required String userId,
    required String oldPassword,
    required String newPassword,
  });

  Future<void> updateImage({
    required String userId,
    required File image,
  });

  Future<void> logout();

  Future<void> resetPassword({
    required String email,
    required String password,
  });

  Future<void> deleteUser(String id);

   Future<void> verifyOTP(String email, int otp);

  Future<void> forgetPassword({
    required String email,
    required String destination,
  });
    Future<void> clearUserImage(String userId);



}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {

   Future<TokenModel?> get token async {
    return await AuthenticationLocalDataSourceImpl().getUserInformations();
  }

  Future<String> get locale async {
    return await SettingsLocalDataSourcImpl().loadLocale();
  }

@override
Future<String> registerUser({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
     String? address,
     String? phone,
     String? image,
      DateTime? birthDate,
     String? gender,
  }) async {
    try {
      // AppLocalizations t=await AppLocalizations.delegate.load(Locale(await locale) );
      final response = await http.post(
        Uri.parse(ApiConst.RegisterUser),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
          'password': password,
          'address': address??'',
          'phone': phone??'',
          'imageUrl': image??'',
          'birthDate': birthDate?.toIso8601String(),
          'gender': gender??'',
        }),
      );

      // Handle the response
      if (response.statusCode == 201) {
        // Successful registration, return user ID
        final responseData = jsonDecode(response.body);
        // Ensure `uId` exists in the response
      if (responseData["uId"] == null) {
        throw ServerException(message: "User ID not returned by server.");
      }

        return responseData["uId"];
      } else if (response.statusCode == 403) {
        // Email already used
        throw RegistrationException("email_already_used");
      } else {
        throw ServerException(
            message: "Unexpected error occurred: ${response.body}");
      }
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }


 @override
Future<TokenModel> loginUser({
  required String email,
  required String password,
}) async {
  try {
    print(
      '$email :$password'
    );
    // final response = await http.post(
    //   Uri.parse(ApiConst.login),
    //   body: {'email': "yyt@gmail.com", 'password': "12345678"},
    Map<String, dynamic> user = {'email': email, 'password': password};
      final url = Uri.parse(ApiConst.login);
      final res = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user),
      );
    

    if (res.statusCode == 200) {
      return TokenModel.fromJson(json.decode(res.body));
    } else if (res.statusCode == 400) {
      throw LoginException("Invalid email or password");
    } else {
      throw ServerException(
          message: "Unexpected error occurred: ${res.body}");
    }
  } catch (e) {
    print("Error during login: $e");

    rethrow;
  }
}



 @override
Future<UserModel> getUserById(String userId) async {
  try {
    final response = await http.get(Uri.parse('${ApiConst.getOneUser}/$userId'));
    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body)['user']);

    } else if (response.statusCode == 404) {
      throw DataNotFoundException("User with ID $userId not found.");
    } else {
      // Unexpected server response
      throw ServerException(
          message: "Unexpected error occurred: ${response.body}");
    }
  } catch (e) {
    // Log the error for debugging purposes
    print("Error fetching user by ID: $e");

    // Rethrow the caught error for higher-level handling
    rethrow;
  }
}


@override
Future<List<UserModel>> getAllUsers() async {
  try {
    final response = await http.get(Uri.parse(ApiConst.getAllUsers));

    if (response.statusCode == 200) {
      // Successfully fetched users, parse the JSON data
      final data = json.decode(response.body) as List;
      return data.map((user) => UserModel.fromJson(user)).toList();
    } else if (response.statusCode == 404) {
      // No users found, throw DataNotFoundException
      throw DataNotFoundException("No users found.");
    } else {
      // Unexpected server response
      throw ServerException(
          message: "Unexpected error occurred: ${response.body}");
    }
  } catch (e) {
    // Log the error for debugging
    print("Error fetching all users: $e");

    // Rethrow the error for higher-level handling
    rethrow;
  }
}

 @override
Future<void> updateUser({
  required String id,
  required String firstName,
  required String lastName,
  required String address,
  required String phone,
  required String gender,
  required DateTime birthDate,
}) async {
  try {
     Map<String, dynamic> userModel = {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'address': address,
        'phone': phone,
        'gender': gender,
        'birthDate': birthDate.toString(),
      };
    String authToken = await token.then((value) => value!.token);
      final url = Uri.parse(ApiConst.updateUser);

    
    final response = await http.put(
      Uri.parse('${ApiConst.updateUser}/$id'),
      headers: {'Content-Type': 'application/json',
                'Authorization': 'Bearer $authToken',

      
      },
        body: jsonEncode(userModel),
    );

    if (response.statusCode == 200) {
      // Successfully updated user
      return;
    } else if (response.statusCode == 404) {
      // User not found, throw DataNotFoundException
      throw DataNotFoundException("User with ID $id not found.");
    } else {
      // Unexpected server response
      throw ServerException(
          message: "Unexpected error occurred: ${response.body}");
    }
  } catch (e) {
    // Log the error for debugging
    print("Error updating user with ID $id: $e");

    // Rethrow the error for higher-level handling
    rethrow;
  }
}



@override
Future<void> updatePassword({
  required String userId,
  required String oldPassword,
  required String newPassword,
}) async {
  try {
    String authToken=await token.then((value)=>value!.token);
    
    final response = await http.post(
      Uri.parse(ApiConst.updateUserPassword),
      headers: {'Content-Type': 'application/json',
                'Authorization':'Bearer $authToken',
      },
      body: json.encode({
        'id':userId,
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      }),
    );

    if (response.statusCode == 200) {
      // Successfully updated password
      return;
    } else if (response.statusCode == 401) {
      // Unauthorized, old password may be incorrect
      throw NotAuthorizedException();
    } else if (response.statusCode == 404) {
      // User not found
      throw DataNotFoundException("User with ID $userId not found.");
    } else {
      // Unexpected server response
      throw ServerException(
          message: "Unexpected error occurred: ${response.body}");
    }
  } catch (e) {
    // Log the error for debugging
    print("Error updating password for user with ID $userId: $e");

    // Rethrow the error for higher-level handling
    rethrow;
  }
}


 @override
  Future<void> updateImage({required String userId,  required File image}) async {
    try {
      final url =
          Uri.parse(ApiConst.updateUserImage); 
      // Create a multipart request
      var request = http.MultipartRequest('POST', url);

      // Add fields
      request.fields['id'] = userId;

      // Add the file
      var fileName = image.path.split('/').last;
      request.files.add(
        await http.MultipartFile.fromPath(
          'file', // This should match the field name expected by the server
          image.path,
          contentType: MediaType('image', 'jpeg'),
        ),
      );

      // Send the request
      var response = await request.send();
    } catch (e) {
      throw ServerException(message: 'cannot update image');
    }
  }
 @override
  Future<void> clearUserImage(String userId) async {
    try {
      Map<String, dynamic> model = {'id': userId, 'imageUrl': ''};
      await http.put(
        Uri.parse(ApiConst.updateUser),
        body: model,
        headers: {
          "authorization":
              "Bearer ${await token.then((value) => value!.token)}",
        },
      );
    } catch (e) {
      throw ServerException(message: 'cannot update profile');
    }
  }

  @override
Future<void> logout() async {
  try {
    final response = await http.post(Uri.parse(ApiConst.logout));

    if (response.statusCode == 200) {
      // Successfully logged out
      return;
    } else {
      // Unexpected server response
      throw ServerException(
          message: "Unexpected error occurred: ${response.body}");
    }
  } catch (e) {
    // Log the error for debugging
    print("Error during logout: $e");

    rethrow;
  }
}

 @override
Future<void> resetPassword({
  required String email,
  required String password,
}) async {
  try {
    final response = await http.post(
      Uri.parse(ApiConst.resetPassword),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // Successfully reset the password
      return;
    } else if (response.statusCode == 404) {
      // Email not found, throw DataNotFoundException
      throw DataNotFoundException("Email $email not found.");
    } else {
      // Unexpected server response
      throw ServerException(
          message: "Unexpected error occurred: ${response.body}");
    }
  } catch (e) {
    // Log the error for debugging
    print("Error resetting password for email $email: $e");

    rethrow;
  }
}


@override
Future<void> deleteUser(String id) async {
  try {
    final response = await http.delete(
      Uri.parse('${ApiConst.delete}/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // Successfully deleted the user
      return;
    } else if (response.statusCode == 404) {
      // User not found
      throw DataNotFoundException("User with ID $id not found.");
    } else {
      // Unexpected server response
      throw ServerException(
          message: "Unexpected error occurred: ${response.body}");
    }
  } catch (e) {
    // Log the error for debugging purposes
    print("Error deleting user with ID $id: $e");

    rethrow;
  }
}

@override

  Future<void> verifyOTP(String email, int otp) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConst.verfiyCode),
        body: jsonEncode({"email": email, "otp": otp}),
        headers: {"Content-Type": "application/json"},
      );

    if (response.statusCode == 200) {
      return;
    } else if (response.statusCode == 400) {
      throw BadOTPException("expired code ");
    } else if (response.statusCode == 404) {
      throw BadOTPException("Invalid OTP provided for email $email.");
    } else {
      throw ServerException(
          message: "Unexpected error occurred: ${response.body}");
    }
  } catch (e) {
    print("Error verifying OTP for email $email: $e");

    rethrow;
  }
}


 @override
Future<void> forgetPassword({
  required String email,
  required String destination,
}) async {
  try {
    final response = await http.post(
      Uri.parse(ApiConst.forgetPassword),
      body: json.encode({
        'email': email,
        'destination': destination,
      }),
      headers: {'Content-Type': 'application/json'},

    );
    print("Response Status Code: ${response.statusCode}");
  print("Response Body: ${response.body}");

    if (response.statusCode == 404) {
        throw DataNotFoundException("email not registred");
      } else if (response.statusCode == 500) {
        throw ServerException(message: "server error");
      }
    } catch (e) {
      rethrow;
    }
  }
  @override
  Future<TokenModel?> autoLogin() async {
    try {
      return await token;
    } catch (e) {
      print(e);
      rethrow;
    } 
  }
  

  


  }
