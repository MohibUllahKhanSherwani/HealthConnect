import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DoctorDashboardScreen extends StatelessWidget {
  const DoctorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy list of appointments
    final List<Map<String, String>> appointments = [
      {
        'patient': 'John Doe',
        'time': '10:00 AM',
        'date': 'Today',
        'reason': 'Fever'
      },
      {
        'patient': 'Jane Smith',
        'time': '11:30 AM',
        'date': 'Today',
        'reason': 'Headache'
      },
      {
        'patient': 'Robert Brown',
        'time': '2:00 PM',
        'date': 'Tomorrow',
        'reason': 'Follow-up'
      },
    ];

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Doctor Dashboard'),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Welcome, Dr. Smith',
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 24),
              const Text('Upcoming Appointments',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: appointments.length,
                  itemBuilder: (context, index) {
                    final appointment = appointments[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Text(appointment['patient']!),
                        subtitle: Text(
                            '${appointment['date']} at ${appointment['time']} - ${appointment['reason']}'),
                        trailing: ElevatedButton(
                          onPressed: () => context.push('/consultation'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurpleAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text('Start'),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Implement schedule management
                    debugPrint('Manage schedule');
                  },
                  icon: const Icon(Icons.calendar_today),
                  label: const Text('Manage Schedule'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
