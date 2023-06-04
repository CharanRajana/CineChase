import 'package:flutter_dotenv/flutter_dotenv.dart';

class Secrets {
  static String projectId = dotenv.env['APPWRITE_PROJECT_ID'] ?? '';
  static String endPoint = 'https://cloud.appwrite.io/v1';
  static String movieApiKey = dotenv.env['MOVIE_API_KEY'] ?? '';
}
