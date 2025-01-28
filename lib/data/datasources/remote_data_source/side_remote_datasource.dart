import 'dart:convert';
import 'package:front/core/errors/exceptions/exceptions.dart';
import 'package:front/core/utils/api_const.dart';
import 'package:http/http.dart' as http;

import '../../models/side_model.dart';

abstract class SideRemoteDataSource {
  Future<List<SideModel>> getAllSides();
  Future<SideModel> getSideById(String id);

}

class SideRemoteDataSourceImpl implements SideRemoteDataSource {
  SideRemoteDataSourceImpl();


 @override
  Future<List<SideModel>> getAllSides() async {
        print('SideRepositoryImpl: Calling SideRemoteDataSource...');

    final response = await http.get(
      Uri.parse(ApiConst.getAllSides),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => SideModel.fromJson(data)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<SideModel> getSideById(String id) async {
    final response = await http.get(
      Uri.parse(ApiConst.getSideById(id)),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      return SideModel.fromJson(jsonResponse);
    } else {
      throw ServerException();
    }
  }

  // @override
  // Future<void> createSide(Map<String, dynamic> sideData) async {
  //   final response = await http.post(
  //     Uri.parse(ApiConst.createSide),
  //     headers: {'Content-Type': 'application/json'},
  //     body: json.encode(sideData),
  //   );

  //   if (response.statusCode != 201) {
  //     throw ServerException();
  //   }
  // }

  // @override
  // Future<void> deleteSide(String id) async {
  //   final response = await http.delete(
  //     Uri.parse(ApiConst.deleteSide(id)),
  //     headers: {'Content-Type': 'application/json'},
  //   );

  //   if (response.statusCode != 200) {
  //     throw ServerException();
  //   }
  // }
}
