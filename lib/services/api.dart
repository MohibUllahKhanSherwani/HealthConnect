import 'package:http/http.dart' as http;

class ApiService {
  // Base URL for backend API
  static const String _baseUrl = 'http://10.0.2.2:4000';

  // Test connection to backend API
  static Future<void> testConnection() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));
      if (response.statusCode == 200) {
        print('Connection to backend established successfully.');
      } else {
        print(
            'Failed to connect to backend. Status code: \${response.statusCode}');
      }
    } catch (e) {
      print('Error connecting to backend: \$e');
    }
  }
}
