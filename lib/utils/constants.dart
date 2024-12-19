import 'package:flutter_dotenv/flutter_dotenv.dart';

final String baseUrl = dotenv.env['BASE_URL'] ?? 'https://defaulturl.com';
final String apiKey = dotenv.env['API_KEY'] ?? 'default_api_key';