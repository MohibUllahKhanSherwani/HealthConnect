import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/connections.dart';

class PatientApiService {
  static final String _baseUrl = Connections.baseUrl;

  static Future<void> registerPatient({
    required String name,
    required String email,
    required String dob,
    required String gender,
    required String contactInfo,
    required String password,
  }) async {
    print("almost executed");
    final response = await http.post(
      Uri.parse('$_baseUrl/patients'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'Name': name,
        'Email': email,
        'Date_of_Birth': dob,
        'Gender': gender,
        'Contact_Info': contactInfo,
        'Password': password
      }),
    );

    print("executed");
    if (response.statusCode != 201) {
      throw Exception('Failed to register patient: ${response.body}');
    }
  }

  static Future<Map<String, dynamic>> getPatientById(String id) async {
    final response = await http.get(Uri.parse('$_baseUrl/patients/\$id'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load patient: ${response.body}');
    }
  }

  static Future<List<dynamic>> getAllPatients() async {
    final response = await http.get(Uri.parse('$_baseUrl/patients'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load patients: ${response.body}');
    }
  }

  static Future<void> updatePatient({
    required String id,
    required String name,
    required String email,
    required String dob,
    required String gender,
    required String contactInfo,
  }) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/patients/\$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'Name': name,
        'Email': email,
        'Date_of_Birth': dob,
        'Gender': gender,
        'Contact_Info': contactInfo,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update patient: ${response.body}');
    }
  }

  static Future<void> deletePatient(String id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/patients/\$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete patient: ${response.body}');
    }
  }

  static Future<Map<String, dynamic>> loginPatient({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/patients/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'Email': email,
        'Password': password,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to login patient: ${response.body}');
    }
    return jsonDecode(response.body);
  }
}
