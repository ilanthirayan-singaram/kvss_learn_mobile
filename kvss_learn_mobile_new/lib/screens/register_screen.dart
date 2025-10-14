import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../screens/login_screen.dart';
import '../screens/lessons_screen.dart';
import '../utils/token_storage.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    // Always dispose controllers to prevent memory leaks
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _mobileController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    setState(() => _isLoading = true);

    try {
      final result = await ApiService.registerUser(
        _nameController.text.trim(),
        _emailController.text.trim(),
        _mobileController.text.trim(),
        _passwordController.text.trim(),
        _confirmPasswordController.text.trim(),
      );

      print('Register response: $result'); // For debugging

      String? token;
      if (result.containsKey('token')) {
        token = result['token'];
      } else if (result.containsKey('access_token')) token = result['access_token'];
      else if (result.containsKey('data')) {
        final data = result['data'];
        if (data is Map) {
          if (data.containsKey('token')) {
            token = data['token'];
          } else if (data.containsKey('access_token')) token = data['access_token'];
          else if (data.containsKey('user') &&
              data['user'] is Map &&
              data['user'].containsKey('token')) {
            token = data['user']['token'];
          }
        }
      }
    
      if (token != null) {
        await saveToken(token);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration successful!')),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LessonsScreen()),
        );
      } else {
        final msg = result['message'] ?? 'Registered but no token returned. Please login.';
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    } catch (e) {
      print('Register error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _mobileController,
              decoration: const InputDecoration(labelText: 'Mobile'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            TextField(
              controller: _confirmPasswordController,
              decoration: const InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _register,
                    child: const Text('Register'),
                  ),

                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: const Text("Already have an account? Login"),
                  ),
          ],
        ),
      ),
    );
  }
}
