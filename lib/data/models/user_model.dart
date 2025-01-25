import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel(
      {super.id,
       super.address,
       super.imageUrl,
      required super.firstName,
      required super.lastName,
      required super.email,
       super.phone,
     
       super.birthDate,
       super.gender});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json['_id'],
      imageUrl: json['imageUrl'],
      address: json['address'],
      gender: json['gender'],
      birthDate: DateTime.parse(json['birthDate']),

      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phone: json['phone'],
     );

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'birthDate': birthDate?.toString(),
        'gender': gender,
        'phone': phone,
        'address': address,
     
        'imageUrl': imageUrl
      };
}
