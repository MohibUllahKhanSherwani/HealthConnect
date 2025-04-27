import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/connections.dart';

class MedicalRecordApiService {
  static final String _baseUrl = Connections.baseUrl;

  static Future<List<dynamic>> getAllMedicalRecords() async {
    final response = await http.get(Uri.parse('$_baseUrl/medical_records'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load medical records: ${response.body}');
    }
  }

  static Future<Map<String, dynamic>> getMedicalRecordById(String id) async {
    final response =
        await http.get(Uri.parse('$_baseUrl/medical_records/\$id'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load medical record: ${response.body}');
    }
  }

  static Future<void> createMedicalRecord({
    required String patientId,
    required String doctorId,
    required String diagnosis,
    required String treatment,
    required String date,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/medical_records'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'Patient_Id': patientId,
        'Doctor_Id': doctorId,
        'Diagnosis': diagnosis,
        'Treatment': treatment,
        'Date': date,
      }),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to create medical record: ${response.body}');
    }
  }

  static Future<void> updateMedicalRecord({
    required String id,
    required String patientId,
    required String doctorId,
    required String diagnosis,
    required String treatment,
    required String date,
  }) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/medical_records/\$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'Patient_Id': patientId,
        'Doctor_Id': doctorId,
        'Diagnosis': diagnosis,
        'Treatment': treatment,
        'Date': date,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update medical record: ${response.body}');
    }
  }

  static Future<void> deleteMedicalRecord(String id) async {
    final response =
        await http.delete(Uri.parse('$_baseUrl/medical_records/\$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete medical record: ${response.body}');
    }
  }
}
