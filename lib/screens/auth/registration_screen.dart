import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:doctor/services/patient_api_service.dart';
import 'package:doctor/services/doctor_api_service.dart';
import 'package:doctor/constants/specializations.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  final _dobController = TextEditingController();
  final _specializationController = TextEditingController();
  String? _selectedSpecialization;
  final _clinicIdController = TextEditingController();
  String? _selectedGender;
  final List<String> _genders = ['Male', 'Female', 'Other'];
  String _selectedUserType = 'Patient';
  final List<String> _userTypes = ['Patient', 'Doctor'];

  void _printControllers() {
    print('User Type: $_selectedUserType');
    print('Email: ${_emailController.text}');
    print('Password: ${_passwordController.text}');
    print('Confirm Password: ${_confirmPasswordController.text}');
    print('Name: ${_nameController.text}');
    print('Contact: ${_contactController.text}');
    if (_selectedUserType == 'Patient') {
      print('Date of Birth: ${_dobController.text}');
      print('Gender: $_selectedGender');
    } else if (_selectedUserType == 'Doctor') {
      print('Specialization: ${_specializationController.text}');
      print('Clinic ID: ${_clinicIdController.text}');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dobController.text = DateFormat('yyyy-MM-dd').format(picked);
        print(_dobController.text);
      });
    }
  }

  Future<void> _registerPatient() async {
    await PatientApiService.registerPatient(
      name: _nameController.text,
      email: _emailController.text,
      dob: _dobController.text,
      gender: _selectedGender!,
      contactInfo: _contactController.text,
      password: _passwordController.text,
    );
  }

  Future<void> _registerDoctor() async {
    await DoctorApiService.createDoctor(
      name: _nameController.text,
      specialization: _specializationController.text,
      contactInfo: _contactController.text,
      email: _emailController.text,
      password: _passwordController.text,
      clinicId: int.parse(_clinicIdController.text),
    );
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
          title: const Text('Register'),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            child: Form(
              key: _formKey,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: const EdgeInsets.all(24),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Text(
                        'Create Account',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 20),
                      // Name Field
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Full Name',
                          prefixIcon: const Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      // User Type Selection
                      DropdownButtonFormField<String>(
                        value: _selectedUserType,
                        decoration: InputDecoration(
                          labelText: 'Register as',
                          prefixIcon: const Icon(Icons.person_outline),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        items: _userTypes.map((type) {
                          return DropdownMenuItem<String>(
                            value: type,
                            child: Text(type),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedUserType = value!;
                            // Clear fields specific to user types when switching
                            _dobController.clear();
                            _selectedGender = null;
                            _specializationController.clear();
                            _clinicIdController.clear();
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      // Email Field
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: const Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      // Conditional Fields for Patient or Doctor
                      if (_selectedUserType == 'Patient') ...[
                        // Date of Birth Field
                        TextFormField(
                          controller: _dobController,
                          readOnly: true,
                          onTap: () => _selectDate(context),
                          decoration: InputDecoration(
                            labelText: 'Date of Birth',
                            prefixIcon: const Icon(Icons.calendar_today),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select your date of birth';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        // Gender Field
                        DropdownButtonFormField<String>(
                          value: _selectedGender,
                          decoration: InputDecoration(
                            labelText: 'Gender',
                            prefixIcon: const Icon(Icons.transgender),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          items: _genders.map((gender) {
                            return DropdownMenuItem<String>(
                              value: gender,
                              child: Text(gender),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Please select your gender';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                      ] else if (_selectedUserType == 'Doctor') ...[
                        // Specialization Field
                        DropdownButtonFormField<String>(
                          value: _selectedSpecialization,
                          decoration: InputDecoration(
                            labelText: 'Specialization',
                            prefixIcon: const Icon(Icons.medical_services),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          items: Specializations.all.map((spec) {
                            return DropdownMenuItem<String>(
                              value: spec,
                              child: Text(spec),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedSpecialization = value;
                              _specializationController.text = value ?? '';
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select your specialization';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        // Clinic ID Field
                        TextFormField(
                          controller: _clinicIdController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Clinic ID',
                            prefixIcon: const Icon(Icons.local_hospital),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your clinic ID';
                            }
                            if (int.tryParse(value) == null) {
                              return 'Clinic ID must be a number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                      ],
                      // Contact Info Field
                      TextFormField(
                        controller: _contactController,
                        decoration: InputDecoration(
                          labelText: 'Contact Info',
                          prefixIcon: const Icon(Icons.phone),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your contact information';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      // Password Field
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      // Confirm Password Field
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          prefixIcon: const Icon(Icons.lock_outline),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      // Register Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            _printControllers();

                            if (_formKey.currentState!.validate()) {
                              if (_selectedUserType == 'Patient') {
                                _registerPatient().then((_) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Registration successful!')));
                                  context.pop();
                                }).catchError((error) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Registration failed: \$error')));
                                });
                              } else if (_selectedUserType == 'Doctor') {
                                _registerDoctor().then((_) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Registration successful!')));
                                  context.pop();
                                }).catchError((error) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Registration failed: \$error')));
                                });
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Register',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
