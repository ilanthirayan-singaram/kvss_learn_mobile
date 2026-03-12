import 'package:flutter/material.dart';
import '../utils/token_storage.dart';
<<<<<<< HEAD

=======
import '../config/api_config.dart';
import '../screens/lessons_screen.dart';
import 'lesson_list_screen.dart';
>>>>>>> 4eab97b (Remove large RPM file)
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
<<<<<<< HEAD
    final savedToken = await getToken();
=======
     final  savedToken = await TokenStorage.get();
   // final savedToken = await getToken();


>>>>>>> 4eab97b (Remove large RPM file)
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
<<<<<<< HEAD
              await clearToken();
=======
              await TokenStorage.clear();
            //  await clearToken();
>>>>>>> 4eab97b (Remove large RPM file)
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
<<<<<<< HEAD
                Navigator.pushNamed(context, '/lessons');
              },
              child: const Text('📘 View Lessons'),
            ),

=======

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      // builder: (_) => LessonsScreen(),
                      builder: (_) => LessonListScreen(),
                    ),
                  );

         //       Navigator.pushNamed(context, '/lessons');
              },
              child: const Text('📘 View Lessons'),
            ),
>>>>>>> 4eab97b (Remove large RPM file)
              ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
              child: const Text('📘 View/update Profile'),
            ),

          ],
        ),
      ),
    );
  }
}
