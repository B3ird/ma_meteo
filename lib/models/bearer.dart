import 'package:mockito/mockito.dart';

class Bearer {
  String? accessToken;
  String? refreshToken;
  String? tokenType;
  int? expires;

  Bearer({
    this.accessToken,
    this.refreshToken,
    this.tokenType,
    this.expires,
  });

  @override
  String toString() {
    return 'Bearer(accessToken: $accessToken, refreshToken: $refreshToken, tokenType: $tokenType, expires: $expires)';
  }

  factory Bearer.fromJson(Map<String, dynamic> json) {
    return Bearer(
      accessToken: json['access_token'] as String?,
      refreshToken: json['refresh_token'] as String?,
      tokenType: json['token_type'] as String?,
      expires: json['expires'] as int,
    );
  }
}

class FakeBearer extends Fake implements Bearer {

  @override
  String get accessToken => "AYjcyMzY6ZDhiNmJkMTY";

  @override
  String get refreshToken => "RjY4NjM5MzA5OWJjuE7c";
}
