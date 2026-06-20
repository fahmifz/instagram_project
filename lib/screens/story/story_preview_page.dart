import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/story_service.dart';

class StoryPreviewPage extends StatefulWidget {
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

  final TextEditingController
      captionController =
      TextEditingController();

  Future<void> uploadStory() async {
    setState(() {
      isLoading = true;
    });

    try {
      final prefs =
          await SharedPreferences.getInstance();

      final userId =
          prefs.getInt('user_id');

      if (userId == null) {
        if (!mounted) return;

        ScaffoldMessenger.of(context)
            .showSnackBar(
          const SnackBar(
            content: Text(
              'User tidak ditemukan',
            ),
          ),
        );

        setState(() {
          isLoading = false;
        });

        return;
      }

      final bytes =
          await widget.imageFile.readAsBytes();

      final success =
          await StoryService.uploadStory(
        bytes,
        userId.toString(),
      );

      if (!mounted) return;

      if (success) {
        ScaffoldMessenger.of(context)
            .showSnackBar(
          const SnackBar(
            content: Text(
              'Story berhasil diupload',
            ),
          ),
        );

        Navigator.pop(context);
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(
          const SnackBar(
            content: Text(
              'Upload story gagal',
            ),
          ),
        );

        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print(
        'UPLOAD STORY ERROR = $e',
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            'Error: $e',
          ),
        ),
      );

      setState(() {
        isLoading = false;
      });
    }
  }

  Widget buildActionButton(
    IconData icon,
  ) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius:
            BorderRadius.circular(21),
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 22,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: Stack(
        
        children: [
          Container(
            color: Colors.black,
          ),
          Positioned.fill(
            child: Image.file(
              widget.imageFile,
              fit: BoxFit.cover,
            ),
          ),

          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor:
                        Colors.black54,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(
                          context,
                        );
                      },
                    ),
                  ),

                  buildActionButton(
                    Icons.text_fields,
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: 80,
            right: 12,
            child: Column(
              children: [
                buildActionButton(
                  Icons.emoji_emotions_outlined,
                ),

                const SizedBox(
                  height: 10,
                ),

                buildActionButton(
                  Icons.music_note,
                ),

                const SizedBox(
                  height: 10,
                ),

                buildActionButton(
                  Icons.brush,
                ),
              ],
            ),
          ),

          Positioned(
            left: 20,
            right: 20,
            bottom: 100,
            child: TextField(
              controller:
                  captionController,
              style:
                  const TextStyle(
                color: Colors.white,
              ),
              decoration:
                  InputDecoration(
                hintText:
                    'Tambahkan keterangan...',
                hintStyle:
                    const TextStyle(
                  color:
                      Colors.white70,
                ),
                filled: true,
                fillColor:
                    Colors.black38,
                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                    25,
                  ),
                  borderSide:
                      BorderSide.none,
                ),
              ),
            ),
          ),

          Positioned(
            left: 15,
            right: 15,
            bottom: 20,
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child:
                        ElevatedButton(
                      onPressed:
                          isLoading
                              ? null
                              : uploadStory,
                      style:
                          ElevatedButton
                              .styleFrom(
                        backgroundColor:
                            Colors.black87,
                      ),
                      child: Text(
                        isLoading
                            ? 'Uploading...'
                            : 'Cerita Anda',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  width: 10,
                ),

                Expanded(
                  child: SizedBox(
                    height: 50,
                    child:
                        ElevatedButton(
                      onPressed:
                          isLoading
                              ? null
                              : uploadStory,
                      style:
                          ElevatedButton
                              .styleFrom(
                        backgroundColor:
                            const Color(0xFF1C1C1E),
                        foregroundColor:
                            Colors.white,
                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                      'Teman Dekat',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    ),
                  ),
                ),

                const SizedBox(
                  width: 10,
                ),

                CircleAvatar(
                  radius: 25,
                  backgroundColor:
                      Colors.blue,
                  child: IconButton(
                    onPressed:
                        isLoading
                            ? null
                            : uploadStory,
                    icon:
                        const Icon(
                      Icons.arrow_forward,
                      color:
                          Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}