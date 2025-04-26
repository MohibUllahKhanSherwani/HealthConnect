import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/connections.dart';

class ClinicApiService {
  static final String _baseUrl = Connections.baseUrl;

  static Future<List<dynamic>> getAllClinics() async {
    final response = await http.get(Uri.parse('$_baseUrl/clinics'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load clinics: ${response.body}');
    }
  }

  static Future<Map<String, dynamic>> getClinicById(String id) async {
    final response = await http.get(Uri.parse('$_baseUrl/clinics/\$id'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load clinic: ${response.body}');
    }
  }

  static Future<void> createClinic({
    required String name,
    required String location,
    double? latitude,
    double? longitude,
    required String contactInfo,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/clinics'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'Name': name,
        'Location': location,
        'Latitude': latitude,
        'Longitude': longitude,
        'Contact_Info': contactInfo,
      }),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to create clinic: ${response.body}');
    }
  }

  static Future<void> updateClinic({
    required String id,
    required String name,
    required String location,
    double? latitude,
    double? longitude,
    required String contactInfo,
  }) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/clinics/\$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'Name': name,
        'Location': location,
        'Latitude': latitude,
        'Longitude': longitude,
        'Contact_Info': contactInfo,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update clinic: ${response.body}');
    }
  }

  static Future<void> deleteClinic(String id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/clinics/\$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete clinic: ${response.body}');
    }
  }
}
