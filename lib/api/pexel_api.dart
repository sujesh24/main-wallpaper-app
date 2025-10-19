import 'package:flutter_dotenv/flutter_dotenv.dart';

class PexelAPi {
  static String baseUrl = 'https://api.pexels.com/v1/';
  static String get pexelAPiKey => dotenv.env['Pexel_API_Key'] ?? '';
}
