import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class StoryService {

  // GANTI JIKA IP BERUBAH
  static const String baseUrl =
      "http://10.85.110.110:8000/api/auth";

  // =========================
  // UPLOAD STORY
  // =========================
  static Future<bool> uploadStory(
    Uint8List bytes,
    String userId,
  ) async {

    try {

      print("UPLOAD STORY");
      print("USER ID = $userId");

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          '$baseUrl/stories/upload',
        ),
      );

      request.fields['user_id'] = userId;

      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          bytes,
          filename: 'story.jpg',
        ),
      );

      final response =
          await request.send();

      final body =
          await response.stream.bytesToString();

      print("STATUS = ${response.statusCode}");
      print("BODY = $body");

      return response.statusCode == 200;

    } catch (e) {

      print(
        "ERROR UPLOAD STORY = $e",
      );

      return false;
    }
  }

  // =========================
  // GET STORIES
  // =========================
  static Future<List<dynamic>>
      getStories() async {

    try {

      final response = await http.get(
        Uri.parse(
          '$baseUrl/stories',
        ),
      );

      print("GET STORIES");
      print(
        "STATUS = ${response.statusCode}",
      );

      print(
        "BODY = ${response.body}",
      );

      if (response.statusCode == 200) {

        final data =
            jsonDecode(response.body);

        return data['stories'];

      }

      return [];

    } catch (e) {

      print(
        "ERROR GET STORIES = $e",
      );

      return [];
    }
  }

  // =========================
  // STORY IMAGE URL
  // =========================
  static String getStoryImage(
    String filename,
  ) {

    return
        '$baseUrl/story-image/$filename';
  }
}