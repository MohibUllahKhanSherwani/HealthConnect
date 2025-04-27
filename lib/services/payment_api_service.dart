import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/connections.dart';

class PaymentApiService {
  static final String _baseUrl = Connections.baseUrl;

  static Future<List<dynamic>> getAllPayments() async {
    final response = await http.get(Uri.parse('$_baseUrl/payments'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load payments: ${response.body}');
    }
  }

  static Future<Map<String, dynamic>> getPaymentById(String id) async {
    final response = await http.get(Uri.parse('$_baseUrl/payments/\$id'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load payment: ${response.body}');
    }
  }

  static Future<void> createPayment({
    required String appointmentId,
    required String patientId,
    required String amount,
    required String paymentMethod,
    required String status,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/payments'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'Appointment_ID': appointmentId,
        'Patient_ID': patientId,
        'Amount': amount,
        'Payment_Method': paymentMethod,
        'Status': status,
      }),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to create payment: ${response.body}');
    }
  }

  static Future<void> updatePayment({
    required String id,
    required String appointmentId,
    required String patientId,
    required String amount,
    required String paymentMethod,
    required String status,
  }) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/payments/\$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'Appointment_ID': appointmentId,
        'Patient_ID': patientId,
        'Amount': amount,
        'Payment_Method': paymentMethod,
        'Status': status,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update payment: ${response.body}');
    }
  }

  static Future<void> deletePayment(String id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/payments/\$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete payment: ${response.body}');
    }
  }
}
