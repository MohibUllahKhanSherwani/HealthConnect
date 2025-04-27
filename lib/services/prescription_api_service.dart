import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/connections.dart';

class PrescriptionApiService {
  static final String _baseUrl = Connections.baseUrl;

  static Future<List<dynamic>> getAllPrescriptions() async {
    final response = await http.get(Uri.parse('$_baseUrl/prescriptions'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load prescriptions: ${response.body}');
    }
  }

  static Future<Map<String, dynamic>> getPrescriptionById(String id) async {
    final response = await http.get(Uri.parse('$_baseUrl/prescriptions/\$id'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load prescription: ${response.body}');
    }
  }

  static Future<void> createPrescription({
    required String appointmentId,
    required String doctorId,
    required String patientId,
    required String pharmacyId,
    required String date,
    required String medicationDetails,
    String? notes,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/prescriptions'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'Appointment_ID': appointmentId,
        'Doctor_ID': doctorId,
        'Patient_ID': patientId,
        'Pharmacy_ID': pharmacyId,
        'Date': date,
        'Medication_Details': medicationDetails,
        'Notes': notes,
      }),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to create prescription: ${response.body}');
    }
  }

  static Future<void> updatePrescription({
    required String id,
    required String appointmentId,
    required String doctorId,
    required String patientId,
    required String pharmacyId,
    required String date,
    required String medicationDetails,
    String? notes,
  }) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/prescriptions/\$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'Appointment_ID': appointmentId,
        'Doctor_ID': doctorId,
        'Patient_ID': patientId,
        'Pharmacy_ID': pharmacyId,
        'Date': date,
        'Medication_Details': medicationDetails,
        'Notes': notes,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update prescription: ${response.body}');
    }
  }

  static Future<void> deletePrescription(String id) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/prescriptions/\$id'),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete prescription: ${response.body}');
    }
  }
}
