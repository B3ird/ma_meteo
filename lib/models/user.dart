import 'package:flutter/material.dart';

class User {
  String? token;
  int? id;
  String? mail;
  String? phone;
  String firstName;
  String lastName;
  String zip;
  String? address;
  String? city;
  String? timezone;

  User({
    this.id,
    this.mail,
    this.phone,
    this.firstName = "",
    this.lastName = "",
    this.zip = "",
    this.address,
    this.city,
  });

  String get fullname => "$firstName $lastName";

  String get shortname {
    if (firstName.isNotEmpty && lastName.isNotEmpty) {
      return "${firstName.characters.first.toUpperCase()}${lastName.characters.first.toUpperCase()}";
    } else {
      return "??";
    }
  }

  @override
  String toString() {
    return 'User(id: $id, mail: $mail, firstName: $firstName, lastName: $lastName ...)';
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int?,
      mail: json['email'] as String?,
      phone: json['phone'] as String?,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      address: json['address'] as String?,
      city: json['city'] as String?,
      zip: json['zip'] as String,
    );
  }
}
