import 'dart:convert';

import 'package:latlong2/latlong.dart';
import 'package:ma_meteo/models/forecast_day.dart';
import 'package:http/http.dart' as http;
import 'api_key.dart';

class ForecastService {
  String dns = "api.openweathermap.org";

  Future<List<ForecastDay>> fetchForecasts(LatLng location) async {
    var client = http.Client();
    return fetchForecastsWithClient(client, location);
  }

  Future<List<ForecastDay>> fetchForecastsWithClient(
      http.Client client, LatLng location) async {
    try {
      final queryParameters = {
        "lat": location.latitude.toString(),
        "lon": location.longitude.toString(),
        "appid": apiKey,
        "units": "metric", //to obtain °C instead of Kelvin
        "lang": "fr"
      };
      final uri = Uri.https(dns, "/data/2.5/forecast", queryParameters);
      // print(uri);
      final response = await client.get(uri);

      if (response.statusCode == 200) {
        dynamic json = jsonDecode(response.body);
        dynamic jsonList = json["list"]; //not required to map all object
        final list = List.castFrom(jsonList)
            .map((e) => ForecastDay.fromJson(e))
            .toList();
        return list;
      } else {
        throw Exception('Failed to load forecasts');
      }
    } finally {
      client.close();
    }
  }
}
