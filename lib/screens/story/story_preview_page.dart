import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/story_service.dart';

class StoryPreviewPage
    extends StatefulWidget {

  final File imageFile;

  const StoryPreviewPage({
    super.key,
    required this.imageFile,
  });

  @override
  State<StoryPreviewPage> createState() =>
      _StoryPreviewPageState();
}

class _StoryPreviewPageState
    extends State<StoryPreviewPage> {

  bool isLoading = false;

  Future<void> uploadStory() async {

    setState(() {
      isLoading = true;
    });

    final prefs =
        await SharedPreferences.getInstance();

    final userId =
        prefs.getInt('user_id');

    if (userId == null) return;

    final bytes =
        await widget.imageFile
            .readAsBytes();

    final success =
        await StoryService.uploadStory(
      bytes,
      userId.toString(),
    );

    if (!mounted) return;

    Navigator.popUntil(
      context,
      (route) => route.isFirst,
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
      ),

      body: Stack(
        children: [

          Center(
            child: Image.file(
              widget.imageFile,
            ),
          ),

          Positioned(
            bottom: 30,
            left: 20,
            right: 20,

            child: ElevatedButton(
              onPressed:
                  isLoading
                      ? null
                      : uploadStory,

              child: Text(
                isLoading
                    ? "Uploading..."
                    : "Bagikan",
              ),
            ),
          ),
        ],
      ),
    );
  }
}