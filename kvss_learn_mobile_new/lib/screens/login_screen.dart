import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'home_screen.dart';
import '../utils/token_storage.dart';
<<<<<<< HEAD
=======
import '../config/api_config.dart';
import 'lesson_list_screen.dart';
// import '../services/auth_service.dart';
>>>>>>> 4eab97b (Remove large RPM file)
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _loginUser() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final response = await ApiService.loginUser(
      _emailController.text,
      _passwordController.text,
    );

    setState(() => _isLoading = false);

if (response['status'] == 'success') {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Login Successful')),
  );
 final token = response['data']?['token'];
<<<<<<< HEAD
if (token != null) {
  // Save token locally
 

if (token != null) {
  await saveToken(token);
 // final verifyToken = await getToken();
  
=======


if (token != null) {
  
  await TokenStorage.save(token);

  final savedToken = await TokenStorage.get();

    print("Saved token: $savedToken");

>>>>>>> 4eab97b (Remove large RPM file)
 if (!mounted) return; // ✅ ensure context is safe

  // Navigate to HomeScreen and replace login screen
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
<<<<<<< HEAD
      builder: (context) => HomeScreen(userEmail: _emailController.text),
    ),
  );
} else {

   ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Token missing in response')),
    );
}
} else {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(response['message'] ?? 'Login failed')),
  );
}



print( "navegating");
      // Navigate to dashboard or home page
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
=======
    //  builder: (context) => HomeScreen(userEmail: _emailController.text),
    builder: (_) => LessonListScreen(),
    ),
  );
} else {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(response['message'] ?? 'Token missing')),
  );
}
>>>>>>> 4eab97b (Remove large RPM file)
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['message'] ?? 'Login failed')),
      );
    }
<<<<<<< HEAD
  }
=======
  } 
>>>>>>> 4eab97b (Remove large RPM file)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email Or Mobile'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter email Or Mobile' : null,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter password' : null,
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _loginUser,
                      child: const Text('Login'),
                    ),

                    TextButton(
  onPressed: () {
    Navigator.pushReplacementNamed(context, '/register');
  },
  child: const Text("Don't have an account? Register here"),
),
            ],
          ),
        ),
      ),
    );
  }
}
