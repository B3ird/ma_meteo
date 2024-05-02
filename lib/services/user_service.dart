import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ma_meteo/models/bearer.dart';

import '../models/user.dart';

class UserService {

  Future<bool> logIn({String? mail, String? password}) async {
    FakeBearer bearer = FakeBearer();
    const storage = FlutterSecureStorage();
    await storage.write(key: "access_token", value: bearer.accessToken);
    await storage.write(key: "refresh_token", value: bearer.refreshToken);
    return true;
  }

  Future<User> getUser() async {
    /// Usually call api from a /user request as below to get user data from access token previously fetched with auth api
    // const storage = FlutterSecureStorage();
    // String? userAccessToken = await storage.read(key: "access_token");
    // print(userAccessToken);
    // final response = await http.get(Uri.https('my_api.com', '/user'),
    //   headers: {
    //     HttpHeaders.authorizationHeader: userAccessToken,
    //   },
    // );

    /// mock response in purpose for the test
    int statusCode = 200;
    String body =
        '{"id": 123,"mail": "julien.m@inc.com","phone": "0612345678","first_name": "Julien","last_name": "M.","address": "Grande Rue","city": "Dijon","zip": "21000"}';

    if (statusCode == 200) {
      final json = jsonDecode(body);
      final user = User.fromJson(json);

      if (kDebugMode) {
        print(user.toString());
      }

      return user;
    }

    throw Exception('Response Code: $statusCode - $body');
  }
}
