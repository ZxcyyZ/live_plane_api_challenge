import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:plane_api_coding_challenge/Data/Repositories/live_plane_repository.dart';



class LivePlaneApiService {
  final http.Client _client;

   LivePlaneApiService (
    this._client,
  );

  static const String auth = "https://auth.opensky-network.org/auth/realms/opensky-network/protocol/openid-connect/token";
  static const String BASEURL = "https://opensky-network.org/api";
  static const List<String> APIOPTIONS = ["/states/all"];
  static const String clientId = String.fromEnvironment('OPENSKY_CLIENT_ID');
  static const String clientSecret = String.fromEnvironment('OPENSKY_CLIENT_SECRET');

  Future<PlaneData> fetchPlanes(LatLngBounds bounds) async{
    final token = await _getToken();

    try {
      final response = await _client.get(
        Uri.parse(
          '$BASEURL${APIOPTIONS[0]}?lamin=${
            bounds.southwest.latitude
            }&lomin=${
              bounds.southwest.longitude
            }&lamax=${
              bounds.northeast.latitude
            }&lomax=${bounds.northeast.longitude}'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      ).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        return PlaneData.fromJson(json);
      } else {
        throw Exception('Failed to load planes: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to hit endpoint: $e');
    }
  }

  Future<String> _getToken() async{
   try {
     final response = await _client.post(
      Uri.parse(auth),
      body: {
        "grant_type": "client_credentials",
        "client_id": clientId,
        "client_secret": clientSecret,
      },
    );

    if (response.statusCode == 200){
      final responseData = jsonDecode(response.body);
      final key = responseData["access_token"];
      return key;
    } else {
      throw Exception("Failed to retrieve token ");
    }
   } catch (e){
      throw Exception("Error Found: $e");
   }
  }

}

