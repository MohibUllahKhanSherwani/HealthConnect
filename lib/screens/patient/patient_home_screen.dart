import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:doctor/theme/app_theme.dart';
import '../../services/doctor_api_service.dart';
import '../../constants/specializations.dart';

class PatientHomeScreen extends StatefulWidget {
  const PatientHomeScreen({super.key});

  @override
  State<PatientHomeScreen> createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends State<PatientHomeScreen> {
  /// List of specialty categories.
  final List<String> specializations = Specializations.all;

  List<dynamic> doctors = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchDoctors();
  }

  Future<void> fetchDoctors() async {
    try {
      final fetchedDoctors = await DoctorApiService.getAllDoctors();
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
          title: const Text('Patient Home'),
          backgroundColor: Colors.deepPurpleAccent,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => context.go('/login'),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Search bar to enter symptoms.
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter your symptoms...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onSubmitted: (value) {
                  // TODO: Call NLP AI API to process symptoms and return relevant doctors.
                  debugPrint('NLP API call with symptoms: $value');
                },
              ),
              const SizedBox(height: 16),
              // Categories section displayed as circular icons.
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: specializations.length,
                  itemBuilder: (context, index) {
                    final specialization = specializations[index];
                    return GestureDetector(
                      onTap: () {
                        // Use push so that back navigation is preserved.
                        context.push('/patient/category/$specialization');
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor:
                                  // Get the color for a specific specialty
                                  Theme.of(context)
                                      .specialtyColors[specialization]!,
                              child: Text(
                                specialization.substring(0, 2).toUpperCase(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(specialization,
                                style: const TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              // Recommended doctors list.
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : errorMessage != null
                        ? Center(child: Text('Error: $errorMessage'))
                        : ListView.builder(
                            itemCount: doctors.length,
                            itemBuilder: (context, index) {
                              final doctor = doctors[index];
                              final doctorName = doctor['Name'] ?? 'Unknown';
                              final specialization = doctor['Specialization'] ??
                                  'General Physician';
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
                                  title: Text(doctorName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
                                  subtitle: Text(specialization),
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                  onTap: () {
                                    // Use push so that doctor profile is added to stack with doctor ID.
                                    final doctorId =
                                        doctor['Doctor_ID'].toString();
                                    context.push('/doctor/profile/$doctorId');
                                  },
                                ),
                              );
                            },
                          ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: Implement geolocation search for nearby doctors.
                  debugPrint('Show nearby doctors');
                },
                icon: const Icon(Icons.map),
                label: const Text('Show Nearby Doctors'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
