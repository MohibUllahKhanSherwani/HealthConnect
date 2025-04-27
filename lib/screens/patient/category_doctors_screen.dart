import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../services/doctor_api_service.dart';

class CategoryDoctorsScreen extends StatefulWidget {
  final String category;
  const CategoryDoctorsScreen({super.key, required this.category});

  @override
  State<CategoryDoctorsScreen> createState() => _CategoryDoctorsScreenState();
}

class _CategoryDoctorsScreenState extends State<CategoryDoctorsScreen> {
  List<dynamic> doctors = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchDoctorsByCategory();
  }

  Future<void> fetchDoctorsByCategory() async {
    try {
      final fetchedDoctors =
          await DoctorApiService.getDoctorsBySpecialization(widget.category);
      setState(() {
        doctors = fetchedDoctors;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
          title: Text('${widget.category} Specialists'),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : errorMessage != null
                ? Center(child: Text('Error: $errorMessage'))
                : ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: doctors.length,
                    itemBuilder: (context, index) {
                      final doctor = doctors[index];
                      final doctorName = doctor['Name'] ?? 'Unknown';
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.deepPurpleAccent,
                            child: Text(
                              doctorName.length > 1
                                  ? doctorName.substring(0, 1)
                                  : '?',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          title: Text(doctorName),
                          subtitle: Text(widget.category),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            final doctorId = doctor['Doctor_ID'].toString();
                            context.push('/doctor/profile/$doctorId');
                          },
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
