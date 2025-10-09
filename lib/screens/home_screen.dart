import 'package:flutter/material.dart';
import '../utils/token_storage.dart';

class HomeScreen extends StatefulWidget {
  final String userEmail;

  const HomeScreen({super.key,required this.userEmail});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? token;

  @override
  void initState() {
    super.initState();
    print('✅ HomeScreen loaded');
    _checkToken();
  }

  Future<void> _checkToken() async {
    final savedToken = await getToken();
    if (!mounted) return;
  
    if (savedToken == null || savedToken.isEmpty) {
 print('✅ Check Token');
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      setState(() {
        token = savedToken;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (token == null) {
      // Loading state while checking token
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
    children: [
      Image.asset(
        'assets/images/logo.png',
        width: 36,
        height: 36,
      ),
      const SizedBox(width: 8),
      const Text('LearnWithAI'),
    ],
  ),
  backgroundColor: Color.fromARGB(255, 190, 176, 198),



        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await clearToken();
              if (!mounted) return;
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to Learn With AI!', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/lessons');
              },
              child: const Text('📘 View Lessons'),
            ),
          ],
        ),
      ),
    );
  }
}
