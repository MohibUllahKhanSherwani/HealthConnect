import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/connections.dart';

class AppointmentApiService {
  static final String _baseUrl = Connections.baseUrl;

  static Future<List<dynamic>> getAllAppointments() async {
    final response = await http.get(Uri.parse('$_baseUrl/appointments'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load appointments: ${response.body}');
    }
  }

  static Future<Map<String, dynamic>> getAppointmentById(String id) async {
    final response = await http.get(Uri.parse('$_baseUrl/appointments/\$id'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load appointment: ${response.body}');
    }
  }

  static Future<void> createAppointment({
    required String patientId,
    required String doctorId,
    required String appointmentDate,
    String? reason,
    String? status,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/appointments'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'Patient_ID': patientId,
        'Doctor_ID': doctorId,
        'Appointment_Date': appointmentDate,
        'Reason': reason,
        'Status': status,
      }),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to create appointment: ${response.body}');
    }
  }

  static Future<void> updateAppointment({
    required String id,
    required String patientId,
    required String doctorId,
    required String appointmentDate,
    String? reason,
    String? status,
  }) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/appointments/\$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'Patient_ID': patientId,
        'Doctor_ID': doctorId,
        'Appointment_Date': appointmentDate,
        'Reason': reason,
        'Status': status,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update appointment: ${response.body}');
    }
  }

  static Future<void> deleteAppointment(String id) async {
    final response =
        await http.delete(Uri.parse('$_baseUrl/appointments/\$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete appointment: ${response.body}');
    }
  }
}
