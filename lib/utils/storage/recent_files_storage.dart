import "package:shared_preferences/shared_preferences.dart";

class RecentFilesStorage {
  static const String _recentFilesKey = 'recentFiles';
  
  static Future<void> addRecentFile(
      String fileName, String documentId, String indexName) async {
    final prefs = await SharedPreferences.getInstance();
    final recentFiles = prefs.getStringList(_recentFilesKey) ?? [];
    final fileData = '$fileName|$documentId|$indexName';
    if (!recentFiles.contains(fileData)) {
      recentFiles.add(fileData);
      await prefs.setStringList(_recentFilesKey, recentFiles);
    }
  }

  static Future<List<Map<String, String>>> getRecentFiles() async {
    final prefs = await SharedPreferences.getInstance();
    final recentFiles = prefs.getStringList(_recentFilesKey) ?? [];
    return recentFiles.map((fileData) {
      final parts = fileData.split('|');
      return {
        'fileName': parts[0],
        'documentId': parts[1],
        'indexName': parts[2],
      };
    }).toList();
  }

  static Future<void> clearRecentFiles() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_recentFilesKey);
  }
}
