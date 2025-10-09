import 'package:flutter/material.dart';
import 'package:learn_mobile/services/api_service.dart';

class LessonsScreen extends StatefulWidget {
  const LessonsScreen({super.key});

  @override
  State<LessonsScreen> createState() => _LessonsScreenState();
}

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
