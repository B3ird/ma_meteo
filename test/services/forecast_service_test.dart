import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ma_meteo/app/app.locator.dart';
import 'package:http/http.dart' as http;
import 'package:ma_meteo/models/forecast_day.dart';
import 'package:ma_meteo/services/forecast_service.dart';
import '../helpers/test_helpers.dart';
import 'package:ma_meteo/services/api_key.dart';
import 'forecast_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockClient;
  late ForecastService service;

  setUp(() {
    mockClient = MockClient();
    service = ForecastService();
  });

  group('ForecastServiceTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });

  group('fetchForecastsWithClient', () {
    test('returns a list of forecasts if the http call completes successfully', () async {
      LatLng paris = const LatLng(48.862725, 2.287592);
      const json = """
      {
  "cod": "200",
  "message": 0,
  "cnt": 5,
  "list": [
      {
          "dt": 1713128400,
          "main": {
              "temp": 14.81,
              "feels_like": 14.17,
              "temp_min": 13.94,
              "temp_max": 14.81,
              "pressure": 1020,
              "sea_level": 1020,
              "grnd_level": 1011,
              "humidity": 70,
              "temp_kf": 0.87
          },
          "weather": [
              {
                  "id": 804,
                  "main": "Clouds",
                  "description": "couvert",
                  "icon": "04n"
              }
          ],
          "clouds": {
              "all": 100
          },
          "wind": {
              "speed": 4.97,
              "deg": 328,
              "gust": 7.6
          },
          "visibility": 10000,
          "pop": 0,
          "sys": {
              "pod": "n"
          },
          "dt_txt": "2024-04-14 21:00:00"
      }
  ],
  "city": {
      "id": 6545270,
      "name": "Quartier du Palais-Royal",
      "coord": {
          "lat": 48.8627,
          "lon": 2.2876
      },
      "country": "FR",
      "population": 0,
      "timezone": 7200,
      "sunrise": 1713070867,
      "sunset": 1713120032
  }
}
      """;
      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(mockClient
          .get(Uri.parse('https://api.openweathermap.org/data/2.5/forecast?lat=${paris.latitude}&lon=${paris.longitude}&appid=$apiKey&units=metric&lang=fr')))
          .thenAnswer((_) async =>
          http.Response(json, 200));

      expect(await service.fetchForecastsWithClient(mockClient, paris), isA<List<ForecastDay>>());
    });

    test('throws an exception if the http call completes with an error', () {
      LatLng paris = const LatLng(48.862725, 2.287592);

      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      when(mockClient
          .get(Uri.parse('https://api.openweathermap.org/data/2.5/forecast?lat=${paris.latitude}&lon=${paris.longitude}&appid=$apiKey&units=metric&lang=fr')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(service.fetchForecastsWithClient(mockClient, paris), throwsException);
    });

  });
}
