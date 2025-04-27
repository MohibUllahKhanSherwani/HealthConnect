import 'package:go_router/go_router.dart';

import '../screens/splash/splash_screen.dart';
import '../screens/login/login_screen.dart';
import '../screens/auth/registration_screen.dart';
import '../screens/patient/patient_home_screen.dart';
import '../screens/patient/category_doctors_screen.dart';
import '../screens/doctor/doctor_profile_screen.dart';
import '../screens/appointment/appointment_booking_screen.dart' as appointment;
import '../screens/consultation/consultation_chat_screen.dart';
import '../screens/doctor/doctor_dashboard_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegistrationScreen(),
    ),
    GoRoute(
      path: '/patient/home',
      builder: (context, state) => const PatientHomeScreen(),
    ),
    GoRoute(
      path: '/patient/category/:name',
      builder: (context, state) {
        final category = state.params['name'] ?? 'General';
        return CategoryDoctorsScreen(category: category);
      },
    ),
    GoRoute(
      path: '/doctor/profile/:id',
      builder: (context, state) {
        final doctorId = state.params['id']!;
        return DoctorProfileScreen(doctorId: doctorId);
      },
    ),
    GoRoute(
      path: '/appointment-booking',
      builder: (context, state) => const appointment.AppointmentBookingScreen(),
    ),
    GoRoute(
      path: '/consultation',
      builder: (context, state) => const ConsultationChatScreen(),
    ),
    GoRoute(
      path: '/doctor/dashboard',
      builder: (context, state) => const DoctorDashboardScreen(),
    ),
  ],
);
