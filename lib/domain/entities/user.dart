import 'dart:io';

import 'package:equatable/equatable.dart';

class User extends Equatable{
  final String? id;
  final String firstName;
  final String lastName;
  final String email;
  final String ?imageUrl;
  final String? address;
  final String ?phone;
  final String ?gender;
 final DateTime? birthDate;
   User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
     this.imageUrl,
     this.address,
     this.phone,
     this.gender,
    this.birthDate,
  });
   @override
  List<Object?> get props => [firstName,lastName,email,phone,id,imageUrl,address,gender,birthDate];

}