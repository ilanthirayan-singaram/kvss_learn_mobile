import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../utils/token_storage.dart';
// import '../services/auth_service.dart';
import '../config/api_config.dart';
import 'lessons_screen.dart';
import 'login_screen.dart';

class LessonListScreen extends StatefulWidget {
  const LessonListScreen({super.key});

  @override
  State<LessonListScreen> createState() => _LessonListScreenState();
}

class _LessonListScreenState extends State<LessonListScreen> {

  List lessons = [];
  bool isLoading = true;

  Future<void> loadLessons() async {

    final token = await TokenStorage.get();
    print("Using token: $token");

    final response = await http.get(
      Uri.parse("${ApiConfig.baseUrl}/student/lessons"),
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json"
      },
    );

    final data = jsonDecode(response.body);
        if (!mounted) return;

        setState(() {
        lessons = data['data'];
        isLoading = false;
        });

  }

  @override
  void initState() {
    super.initState();
    loadLessons();
  }

  @override
  Widget build(BuildContext context) {

    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(

appBar: AppBar(
  title: const Text("My Lessons"),
  centerTitle: true,
  actions: [
IconButton(
  icon: const Icon(Icons.logout),
  onPressed: () {

    showDialog(
      context: context,
      builder: (context) {

        return AlertDialog(
          title: const Text("Logout"),
          content: const Text(
            "Are you sure you want to logout?",
          ),

          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(context); // close dialog
              },
              child: const Text("Cancel"),
            ),

            TextButton(
              onPressed: () async {

                await TokenStorage.clear();

                if (!mounted) return;

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LoginScreen(),
                  ),
                  (route) => false,
                );

              },
              child: const Text(
                "Logout",
                style: TextStyle(color: Colors.red),
              ),
            ),

          ],
        );
      },
    );

  },
),

  ],


),


      body: ListView.builder(
  itemCount: lessons.length,
  itemBuilder: (context, index) {

    final lesson = lessons[index];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => LessonsScreen(
                lessonId: lesson['id'],
              ),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                children: [

                  const Icon(
                    Icons.menu_book,
                    size: 28,
                    color: Colors.blue,
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      lesson['title'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Text(
                lesson['description'] ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [

                  Icon(
                    Icons.play_circle_fill,
                    color: Colors.green,
                  ),

                  SizedBox(width: 6),

                  Text(
                    "Start Lesson",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  )

                ],
              )

            ],
          ),
        ),
      ),
    );
  },
)



    );
  }
}   