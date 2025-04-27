import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:doctor/services/patient_api_service.dart';
import 'package:doctor/services/doctor_api_service.dart';
import 'package:doctor/services/user_session_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;
  int selectedRoleIndex = 0; // Index for the selected role
  final List<String> roles = ['Patient', 'Doctor'];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Exit App'),
            content: const Text('Are you sure you want to exit the app?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  void _login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final role = roles[selectedRoleIndex];

    try {
      if (role == 'Patient') {
        final response = await PatientApiService.loginPatient(
            email: email, password: password);
        final userId = response['patient']['Patient_ID'].toString();
        final userSession =
            Provider.of<UserSessionProvider>(context, listen: false);
        await userSession.setUserSession(userId, 'Patient');
        context.go('/patient/home');
      } else if (role == 'Doctor') {
        final response = await DoctorApiService.loginDoctor(
            email: email, password: password);
        final userId = response['doctor']['Doctor_ID'].toString();
        final userSession =
            Provider.of<UserSessionProvider>(context, listen: false);
        await userSession.setUserSession(userId, 'Doctor');
        context.go('/doctor/dashboard');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String backgroundImage = selectedRoleIndex == 1
        ? 'assets/images/doctor_background.png'
        : 'assets/images/background.jpg';

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: AnimatedContainer(
          duration: const Duration(milliseconds: 800),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(backgroundImage),
              fit: BoxFit.cover,
            ),
          ),
          child: AnimatedBuilder(
            animation: _fadeAnimation,
            builder: (context, child) {
              return Opacity(
                opacity: _fadeAnimation.value,
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Column(
                      children: [
                        Icon(
                          Icons.local_hospital,
                          size: 100,
                          color: Colors.deepOrange,
                        ),
                        Card(
                          elevation: 5,
                          shadowColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          margin: const EdgeInsets.all(24),
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Welcome Back',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF9B80F3),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                TextField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    prefixIcon: const Icon(
                                      Icons.email,
                                      color: Colors.grey,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                TextField(
                                  controller: passwordController,
                                  obscureText: _obscureText,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    prefixIcon: const Icon(
                                      Icons.lock,
                                      color: Colors.grey,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _obscureText
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _obscureText = !_obscureText;
                                        });
                                      },
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                // Role selection toggle
                                ToggleButtons(
                                  isSelected: List.generate(
                                    roles.length,
                                    (index) => index == selectedRoleIndex,
                                  ),
                                  onPressed: (int index) {
                                    setState(() {
                                      selectedRoleIndex = index;
                                    });
                                  },
                                  children: roles
                                      .map(
                                        (role) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0,
                                            vertical: 8.0,
                                          ),
                                          child: Text(role),
                                        ),
                                      )
                                      .toList(),
                                  borderRadius: BorderRadius.circular(12),
                                  constraints: BoxConstraints(minWidth: 100),
                                  selectedColor: Colors.white,
                                  fillColor: Color(0xFF9B80F3),
                                ),
                                const SizedBox(height: 24),
                                Row(
                                  children: [
                                    Expanded(child: Divider()),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                      ),
                                      child: Text(
                                        "or continue with",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    Expanded(child: Divider()),
                                  ],
                                ),
                                const SizedBox(height: 24),
                                // Google and Facebook login buttons
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: 80,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(13),
                                        color: Colors.grey[200],
                                      ),
                                      child: IconButton(
                                        icon: Image.asset(
                                          'assets/images/google_icon.png',
                                        ),
                                        onPressed: () {
                                          // Handle Google login
                                        },
                                      ),
                                    ),
                                    Container(
                                      width: 80,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(13),
                                        color: Colors.grey[200],
                                      ),
                                      child: IconButton(
                                        icon: Image.asset(
                                          'assets/images/facebook_icon.png',
                                        ),
                                        onPressed: () {
                                          // Handle Facebook login
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 24),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: _login,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFF9B80F3),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 16,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      elevation: 4,
                                      shadowColor: Colors.black.withOpacity(
                                        0.9,
                                      ),
                                    ),
                                    child: const Text(
                                      'Login',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                TextButton(
                                  onPressed: () => context.push('/register'),
                                  child: const Text(
                                    'Don\'t have an account? Register',
                                    style: TextStyle(color: Color(0xFF9B80F3)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
