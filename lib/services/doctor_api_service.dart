import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/connections.dart';

class DoctorApiService {
  static final String _baseUrl = Connections.baseUrl;

  static Future<List<dynamic>> getAllDoctors() async {
    final response = await http.get(Uri.parse('$_baseUrl/doctors'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load doctors: ${response.body}');
    }
  }

  static Future<List<dynamic>> getDoctorsBySpecialization(
      String specialization) async {
    final response = await http
        .get(Uri.parse('$_baseUrl/doctors/specialization/$specialization'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'Failed to load doctors by specialization: ${response.body}');
    }
  }

  static Future<Map<String, dynamic>> getDoctorById(String id) async {
    final response = await http.get(Uri.parse('$_baseUrl/doctors/$id'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load doctor: ${response.body}');
    }
  }

  static Future<void> createDoctor({
    required String name,
    required String specialization,
    required String contactInfo,
    required String email,
    required String password,
    required int clinicId,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/doctors'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'Name': name,
        'Specialization': specialization,
        'Contact_Info': contactInfo,
        'Email': email,
        'Password': password,
        'Clinic_ID': clinicId,
      }),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to create doctor: ${response.body}');
    }
  }

  static Future<void> updateDoctor({
    required String id,
    required String name,
    required String specialization,
    required String contactInfo,
    required String email,
    required String password,
    required int clinicId,
  }) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/doctors/\$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'Name': name,
        'Specialization': specialization,
        'Contact_Info': contactInfo,
        'Email': email,
        'Password': password,
        'Clinic_ID': clinicId,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update doctor: ${response.body}');
    }
  }

  static Future<void> deleteDoctor(String id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/doctors/\$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete doctor: ${response.body}');
    }
  }

  static Future<Map<String, dynamic>> loginDoctor({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/doctors/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'Email': email,
        'Password': password,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to login doctor: ${response.body}');
    }
    return jsonDecode(response.body);
  }
}
