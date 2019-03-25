import 'dart:convert';

import 'package:aqua/annict/models.dart';
import 'package:http/http.dart' as http;

abstract class Annict {

  String getAuthorizeUrl(String clientId, String redirectUri, {String scope});

  Future<AccessToken> authorize(String clientId, String clientSecret, String redirectUri, String code);

  Future<Works> works(String accessToken);
}

class AnnictImpl extends Annict {

  static const String baseUrl = "https://api.annict.com";

  String getAuthorizeUrl(String clientId, String redirectUri, {String scope = "write read"}) {
    return "https://annict.jp/oauth/authorize?" +
        "client_id=$clientId&" +
        "response_type=code&" +
        "redirect_uri=${Uri.encodeFull(redirectUri)}&" +
        "scope=$scope";
  }

  @override
  Future<AccessToken> authorize(String clientId, String clientSecret, String redirectUri, String code) async {
    final url = "$baseUrl/oauth/token";
    final params = {
      'client_id': clientId,
      'client_secret': clientSecret,
      'grant_type': 'authorization_code',
      'redirect_uri': redirectUri,
      'code': code,
    };

    final response = await http.post(url, body: params);
    if (response.statusCode == 200) {
      return AccessToken.fromJson(json.decode(response.body));
    }

    throw Exception('fail to authorize');
  }

  Future<Works> works(String accessToken, ) async {
    final url = "$baseUrl/v1/works";
    final headers = {'Authorization': "bearer $accessToken"};

    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      return Works.fromJson(json.decode(response.body));
    }

    throw Exception('fail to get works');
  }
}