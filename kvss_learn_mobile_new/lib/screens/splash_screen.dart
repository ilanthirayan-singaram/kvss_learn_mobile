import 'package:flutter/material.dart';
import '../utils/token_storage.dart';
import '../services/api_service.dart';
<<<<<<< HEAD
=======
import '../config/api_config.dart';
>>>>>>> 4eab97b (Remove large RPM file)
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    // Optional small delay for splash effect
    await Future.delayed(const Duration(seconds: 2));

    // Safely get the saved token
<<<<<<< HEAD
    final token = await getToken();
=======
    final token = await TokenStorage.get();
    // final token = await getToken();
>>>>>>> 4eab97b (Remove large RPM file)

    // Check again if widget is still active
    if (!mounted) return;

    // Redirect based on login state
    if (token != null && token.isNotEmpty) {

final isValid = await ApiService.validateToken(token);
  if (!mounted) return;

     if (isValid) {
    Navigator.pushReplacementNamed(context, '/home');
  } else {
    Navigator.pushReplacementNamed(context, '/login');
  }
    } else {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(size: 100),
            SizedBox(height: 20),
            CircularProgressIndicator(),
            SizedBox(height: 10),
            Text('Checking login status...'),
          ],
        ),


      ),
    );
  }
}
