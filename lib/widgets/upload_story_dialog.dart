import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:typed_data';

import '../services/story_service.dart';

class UploadStoryDialog extends StatefulWidget {
  const UploadStoryDialog({super.key});

  @override
  State<UploadStoryDialog> createState() =>
      _UploadStoryDialogState();
}

class _UploadStoryDialogState
    extends State<UploadStoryDialog> {

  bool isLoading = false;
  Uint8List? selectedImage;

  int step = 1;

Future<void> pickImage() async {

  FilePickerResult? result =
      await FilePicker.platform.pickFiles(
    type: FileType.image,
    withData: true,
  );

  if (result == null) return;

  final bytes =
      result.files.single.bytes;

  if (bytes == null) return;

  setState(() {
    selectedImage = bytes;
    step = 2;
  });
}

Future<void> uploadStory() async {

  if (selectedImage == null) return;

  final prefs =
      await SharedPreferences.getInstance();

  final userId =
      prefs.getInt('user_id');

  if (userId == null) return;

  final success =
      await StoryService.uploadStory(
    selectedImage!,
    userId.toString(),
  );

  if (!mounted) return;

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        success
            ? "Story berhasil dibagikan"
            : "Upload gagal",
      ),
    ),
  );

  if (success) {
    Navigator.pop(context, true);
  }
}

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF262626),

      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(16),
      ),

      child: SizedBox(
        width: 650,
        height: 550,

        child: Column(
          children: [

            const SizedBox(height: 15),

            const Text(
              "Buat Story Baru",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const Divider(
              color: Colors.white24,
            ),

            const Spacer(),

            selectedImage == null
    ? const Column(
        children: [

          Icon(
            Icons.photo_library_outlined,
            size: 100,
            color: Colors.white,
          ),

          SizedBox(height: 20),

          Text(
            "Seret foto di sini",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
        ],
      )
    : ClipRRect(
        borderRadius:
            BorderRadius.circular(12),

        child: Image.memory(
          selectedImage!,
          width: 350,
          height: 350,
          fit: BoxFit.cover,
        ),
      ),

            const SizedBox(height: 25),

            ElevatedButton(
             onPressed:
              isLoading
                  ? null
                  : (selectedImage == null
                      ? pickImage
                      : uploadStory),

              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(
                  0xFF0095F6,
                ),

                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 14,
                ),
              ),

              child:
                  isLoading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child:
                              CircularProgressIndicator(
                            color:
                                Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          selectedImage == null
                              ? "Pilih dari komputer"
                              : "Bagikan ke Cerita",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}