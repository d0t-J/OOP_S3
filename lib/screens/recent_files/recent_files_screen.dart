import 'package:flutter/material.dart';
import 'package:test_/utils/storage/recent_files_storage.dart';
import 'package:test_/screens/chat/chat_screen.dart';

class RecentFilesScreen extends StatelessWidget {
  const RecentFilesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recent Files'),
      ),
      body: FutureBuilder<List<Map<String, String>>>(
        future: RecentFilesStorage.getRecentFiles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading recent files'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No recent files'));
          } else {
            final recentFiles = snapshot.data!;
            return ListView.builder(
              itemCount: recentFiles.length,
              itemBuilder: (context, index) {
                final file = recentFiles[index];
                return ListTile(
                  title: Text(file['fileName']!),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                          documentId: file['documentId'],
                          fileName: file['fileName']!,
                          isLoading: false,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
