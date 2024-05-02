import 'package:intl/intl.dart';

class ForecastDay {
  int timestamp;
  double temperature;
  String description;
  String iconId;

  ForecastDay(
      {required this.timestamp,
      required this.temperature,
      required this.description,
      required this.iconId});

  String get date => parseTimeStamp(timestamp, 'dd/MM/yyyy à HH:mm');

  String get day => parseTimeStamp(timestamp, 'dd/MM/yyyy');

  String get dayOfWeek => parseTimeStamp(timestamp, 'EEEE dd/MM');

  String get hour => parseTimeStamp(timestamp, 'HH:mm');

  String get iconUrl => "https://openweathermap.org/img/wn/$iconId@2x.png";

  @override
  String toString() {
    return 'ForecastDay(date: $date, temperature: $temperature, description: $description ...)';
  }

  factory ForecastDay.fromJson(Map<String, dynamic> json) {
    return ForecastDay(
      timestamp: json['dt'] as int,
      temperature: json['main']['temp'].toDouble() as double,
      description: json['weather'][0]['description'] as String,
      iconId: json['weather'][0]['icon'] as String,
    );
  }

  String parseTimeStamp(int value, String patern) {
    var date = DateTime.fromMillisecondsSinceEpoch(value * 1000);
    var d12 = DateFormat(patern).format(date);
    return d12;
  }
}
