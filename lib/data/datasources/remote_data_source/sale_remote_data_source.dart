import 'dart:convert';
import 'package:front/core/errors/exceptions/exceptions.dart';
import 'package:front/core/utils/api_const.dart';
import 'package:front/data/datasources/local_data_source/authentification_local_data_source.dart';
import 'package:front/data/datasources/local_data_source/settings_local_data_source.dart';
import 'package:front/data/models/token_model.dart';
import 'package:front/domain/entities/sale.dart';
import 'package:http/http.dart' as http;

import '../../models/sale_model.dart';

abstract class SaleRemoteDataSource {
  Future<SaleModel> createSale( String userID,
     String pizzaId,
   int quantityPizza,double totalPrice);
  
  Future<List<SaleModel>> getAllSales();
  Future<SaleModel> getSaleById(String id);
  Future<void> updateSale( Map<String, dynamic> saleData);
  Future<void> deleteSale(String id);
   Future<void> addMultipleSides(String saleId, List<SaleSide> sides, double totalPrice);


}

class SaleRemoteDataSourceImpl implements SaleRemoteDataSource {

 Future<TokenModel?> get token async {
    return await AuthenticationLocalDataSourceImpl().getUserInformations();
  }

  Future<String> get locale async {
    return await SettingsLocalDataSourcImpl().loadLocale();
  }
  @override
  Future<SaleModel> createSale(  String userID,String pizzaId,int quantityPizza,double totalPrice) async {
    final response = await http.post(
      Uri.parse(ApiConst.createSale),
      headers: {'Content-Type': 'application/json'},
body: json.encode({
          'userId': userID,
          'pizzaId': pizzaId,
          'quantitypizza': quantityPizza,
          'totalPrice':totalPrice
        }),    );

    if (response.statusCode == 201) {
      // Parse the response body into a SaleModel
      final data = jsonDecode(response.body);
      // Extract the `sale` object and pass it to `SaleModel.fromJson`
    final saleData = data['sale'];
    print("Parsed Sale Data: $saleData");

    return SaleModel.fromJson(saleData);
  } else {
    // Handle error cases by throwing an exception
    throw Exception('Failed to create sale: ${response.body}');
  }
}

  @override
  Future<List<SaleModel>> getAllSales() async {
    final response = await http.get(
      Uri.parse(ApiConst.getAllSales),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => SaleModel.fromJson(data)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<SaleModel> getSaleById(String id) async {
    final response = await http.get(
      Uri.parse(ApiConst.getSaleById(id)),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      return SaleModel.fromJson(jsonResponse);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> updateSale( Map<String, dynamic> saleData) async {
    final response = await http.post(
      Uri.parse(ApiConst.updateSale),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(saleData),
    );

    if (response.statusCode != 200) {
      throw ServerException();
    }
  }

  @override
  Future<void> deleteSale(String id) async {
    final response = await http.delete(
      Uri.parse(ApiConst.deleteSale(id)),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 204) {
      throw ServerException();
    }
  }
 @override
  Future<void> addMultipleSides(String saleId, List<SaleSide> sides, double totalPrice) async {
   try{
  final Map<String, dynamic> body = {
    "saleId": saleId,
    "sides": sides.map((side) => SaleSideModel(
      sideId: side.sideId,
      quantity: side.quantity,
    ).toJson()).toList(), 
    "totalPrice": totalPrice,
  };

    final response = await http.post(
     Uri.parse(ApiConst.AddMultipleSides),
    
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),

    );
      // Log the response
    print("Response Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Sides added successfully.");
    } else {
      print("Failed to add sides. Status: ${response.statusCode}, Body: ${response.body}");
      throw Exception('Failed to add sides: ${response.body}');
    }
  } catch (e) {
    print("Error in addMultipleSides: $e");
    throw Exception("Error adding multiple sides: $e");
  }
}

}

