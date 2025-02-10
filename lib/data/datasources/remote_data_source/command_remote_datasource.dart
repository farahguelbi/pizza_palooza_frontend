import 'dart:convert';
import 'package:front/core/errors/exceptions/exceptions.dart';
import 'package:front/core/utils/api_const.dart';
import 'package:http/http.dart' as http;

import '../../models/command_model.dart';

abstract class CommandRemoteDataSource {
  // Future<CommandModel> createCommand(Map<String, dynamic> commandData);
  // Future<CommandModel> getCommandById(String commandId);
  // Future<List<CommandModel>> getAllCommands(String userId);
  // Future<void> cancelCommand(String commandId);
  // Future<void> completeCommand(String commandId);
  // Future<void> changePaymentStatus(String commandId, String status);
  // Future<void> changePaymentMethod(String commandId, String method);
   Future<CommandModel> createCommand(Map<String, dynamic> commandData);
  Future<List<CommandModel>> getAllCommands();
  Future<CommandModel> getCommandById(String id);
  Future<CommandModel> updateCommand(String id, Map<String, dynamic> commandData);
  Future<void> deleteCommand(String id);
}

class CommandRemoteDataSourceImpl implements CommandRemoteDataSource {

  CommandRemoteDataSourceImpl();

@override
Future<CommandModel> createCommand(Map<String, dynamic> commandData) async {
  final response = await http.post(
    Uri.parse(ApiConst.createCommand),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(commandData),
  );

  if (response.statusCode == 201) {
    final data = jsonDecode(response.body);
    return CommandModel.fromJson(data); // Assuming backend returns the created command
  } else {
    throw ServerException();
  }
}




  @override
  Future<CommandModel> getCommandById(String id) async {
    final response = await http.get
    (Uri.parse( '${ApiConst.getCommandById} + $id'));
    

    if (response.statusCode == 200) {
      return CommandModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to fetch command");
    }
  }

  @override
  Future<CommandModel> updateCommand(String id, Map<String, dynamic> commandData) async{
   final response = await http.post(
      Uri.parse('${ApiConst.updateCommand} + $id'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(commandData),
    );

    if (response.statusCode == 200) {
      return CommandModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to update command");
    }
  }
    @override
  Future<void> deleteCommand(String id) async {
    final response = await http.delete(Uri.parse(ApiConst.baseUrl + ApiConst.deleteCommand + id));

    if (response.statusCode != 200) {
      throw Exception("Failed to delete command");
    }
  }

  // @override
  // Future<CommandModel> getCommandById(String commandId) async {
  //   final response = await client.get(
  //     Uri.parse(ApiConst.getCommandById(commandId)),
  //     headers: {'Content-Type': 'application/json'},
  //   );

  //   if (response.statusCode == 200) {
  //     final Map<String, dynamic> jsonResponse = json.decode(response.body);
  //     return CommandModel.fromJson(jsonResponse);
  //   } else {
  //     throw ServerException();
  //   }
  // }

  // @override
  // Future<void> cancelCommand(String commandId) async {
  //   final response = await client.post(
  //     Uri.parse(ApiConst.cancelCommand),
  //     headers: {'Content-Type': 'application/json'},
  //     body: json.encode({'commandId': commandId}),
  //   );

  //   if (response.statusCode != 200) {
  //     throw ServerException();
  //   }
  // }

  // @override
  // Future<void> completeCommand(String commandId) async {
  //   final response = await client.post(
  //     Uri.parse(ApiConst.completeCommand),
  //     headers: {'Content-Type': 'application/json'},
  //     body: json.encode({'commandId': commandId}),
  //   );

  //   if (response.statusCode != 200) {
  //     throw ServerException();
  //   }
  // }

  // @override
  // Future<void> changePaymentStatus(String commandId, String status) async {
  //   final response = await client.post(
  //     Uri.parse(ApiConst.changePaymentStatus),
  //     headers: {'Content-Type': 'application/json'},
  //     body: json.encode({'commandId': commandId, 'status': status}),
  //   );

  //   if (response.statusCode != 200) {
  //     throw ServerException();
  //   }
  // }

  // @override
  // Future<void> changePaymentMethod(String commandId, String method) async {
  //   final response = await client.post(
  //     Uri.parse(ApiConst.changePaymentMethod),
  //     headers: {'Content-Type': 'application/json'},
  //     body: json.encode({'commandId': commandId, 'method': method}),
  //   );

  //   if (response.statusCode != 200) {
  //     throw ServerException();
  //   }
  // }
  @override
  Future<List<CommandModel>> getAllCommands() async {
    final response = await http.get(
      Uri.parse(ApiConst.getAllCommands),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      // final data = jsonDecode(response.body) as List;
      return jsonList.map((json) => CommandModel.fromJson(json)).toList();
    } else {
      throw ServerException();
    }
  }
}

