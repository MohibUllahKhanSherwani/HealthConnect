import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/connections.dart';

class PharmacyApiService {
  static final String _baseUrl = Connections.baseUrl;

  static Future<List<dynamic>> getAllPharmacies() async {
    final response = await http.get(Uri.parse('$_baseUrl/pharmacies'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load pharmacies: ${response.body}');
    }
  }

  static Future<Map<String, dynamic>> getPharmacyById(String id) async {
    final response = await http.get(Uri.parse('$_baseUrl/pharmacies/\$id'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load pharmacy: ${response.body}');
    }
  }

  static Future<void> createPharmacy({
    required String name,
    required String location,
    double? latitude,
    double? longitude,
    required String contactInfo,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/pharmacies'),
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
      throw Exception('Failed to create pharmacy: ${response.body}');
    }
  }

  static Future<void> updatePharmacy({
    required String id,
    required String name,
    required String location,
    double? latitude,
    double? longitude,
    required String contactInfo,
  }) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/pharmacies/\$id'),
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
      throw Exception('Failed to update pharmacy: ${response.body}');
    }
  }

  static Future<void> deletePharmacy(String id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/pharmacies/\$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete pharmacy: ${response.body}');
    }
  }
}
