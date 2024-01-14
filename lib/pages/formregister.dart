import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ventemeuble/auth.dart';

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController numeroController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool _isObscure = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  Future<void> signUp(BuildContext context) async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (nameController.text.isEmpty ||
        cityController.text.isEmpty ||
        numeroController.text.isEmpty ||
        email.isEmpty ||
        !email.contains('@') ||
        password.isEmpty ||
        password != confirmPassword) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please fill all fields correctly.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Auth()),
        );
      }
    } catch (e) {
      print('Error during user registration: $e');
      // Handle specific error cases if needed (e.g., email already in use)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: const Text(
          'Registration Form',
          style:
              TextStyle(fontFamily: 'patch', fontSize: 23, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField(
                controller: nameController,
                hintText: 'Name',
                icon: Icons.person,
              ),
              const SizedBox(height: 10),
              _buildTextField(
                controller: cityController,
                hintText: 'City',
                icon: Icons.location_city,
              ),
              const SizedBox(height: 10),
              _buildTextField(
                controller: numeroController,
                hintText: 'Phone Number',
                icon: Icons.phone,
              ),
              const SizedBox(height: 10),
              _buildTextField(
                controller: emailController,
                hintText: 'Email',
                icon: Icons.email,
              ),
              const SizedBox(height: 10),
              _buildPasswordTextField(
                controller: passwordController,
                hintText: 'Password',
                icon: Icons.lock,
              ),
              const SizedBox(height: 10),
              _buildPasswordTextField(
                controller: confirmPasswordController,
                hintText: 'Confirm Password',
                icon: Icons.lock,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  signUp(context);
                },
                child: const Text("Sign Up"),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildPasswordTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: _isObscure,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon),
        suffixIcon: IconButton(
          icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
          onPressed: _togglePasswordVisibility,
        ),
        border: OutlineInputBorder(),
      ),
    );
  }
}
