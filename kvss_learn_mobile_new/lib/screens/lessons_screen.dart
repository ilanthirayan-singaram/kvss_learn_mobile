import 'package:flutter/material.dart';
import 'package:kvss_learn_mobile_new/services/api_service.dart';
<<<<<<< HEAD

class LessonsScreen extends StatefulWidget {
  const LessonsScreen({super.key});
=======
import '../config/api_config.dart';
import '../widgets/video_player_widget.dart';
import '../utils/token_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'login_screen.dart';
class LessonsScreen extends StatefulWidget {
  final int lessonId;

  const LessonsScreen({super.key, required this.lessonId});

  // const LessonsScreen({super.key});
>>>>>>> 4eab97b (Remove large RPM file)

  @override
  State<LessonsScreen> createState() => _LessonsScreenState();
}
<<<<<<< HEAD

class _LessonsScreenState extends State<LessonsScreen> {
  late Future<List<dynamic>> _lessonsFuture;

  @override
  void initState() {
    super.initState();
    _lessonsFuture = ApiService.fetchLessons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lessons'),
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _lessonsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data!.isEmpty) {
            return const Center(child: Text('No lessons available'));
          }

          final lessons = snapshot.data!;

          return ListView.separated(
            itemCount: lessons.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final lesson = lessons[index];
              final title = lesson['title'] ?? 'Untitled Lesson';
              final description = lesson['description'] ?? '';
              final type = lesson['type']?.toUpperCase() ?? 'UNKNOWN';
              final creator = lesson['user']?['name'] ?? 'Unknown Creator';

              return ListTile(
                leading: const Icon(Icons.menu_book_outlined, color: Colors.indigo),
                title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(
                  '$type • by $creator\n$description',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () {
                  // later you can open PDF or video here
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Open lesson: $title')),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
=======
// const token = "62|PSimB6d8mEguMDJo3WwXsKgMfZ6aIx9OZaH2S2gL7b37b49e";

class _LessonsScreenState extends State<LessonsScreen> {
Map<String, dynamic>? lesson;

Future<void> loadLesson() async {

  final token = await TokenStorage.get();
// final token = await getToken();

  final response = await http.get(
    Uri.parse("${ApiConfig.baseUrl}/student/lessons/${widget.lessonId}"),

     headers: {
    "Authorization": "Bearer $token",
    "Accept": "application/json",
  },
  );

  final data = jsonDecode(response.body);

  print(data); // debug

  setState(() {
    lesson = data['data'];
  });

}


@override
void initState() {
  super.initState();
  loadLesson();
} 
  
@override
Widget build(BuildContext context) {

  if (lesson == null) {
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
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            lesson!['title'],
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Text(lesson!['description']),

          const SizedBox(height: 20),
            ...(lesson!['contents'] ?? []).map<Widget>((content) {

            print(content['url']);

            if (content['type'] == "image") {
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Image.network(content['url']),
              );
            }

            if (content['type'] == "video") {
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: VideoPlayerWidget(url: content['url']),
              );
            }

            return const SizedBox();

          }).toList(),

        ],
      ),
    ),
  );
}

}

>>>>>>> 4eab97b (Remove large RPM file)
