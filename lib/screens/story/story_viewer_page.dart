import 'dart:async';

import 'package:flutter/material.dart';
import '../../services/story_service.dart';

class StoryViewerPage extends StatefulWidget {

  final List<dynamic> stories;

  const StoryViewerPage({
    super.key,
    required this.stories,
  });

  @override
  State<StoryViewerPage> createState() =>
      _StoryViewerPageState();
}

class _StoryViewerPageState
    extends State<StoryViewerPage> {

  int currentIndex = 0;

  Timer? timer;

  @override
  void initState() {
    super.initState();

    startStory();
  }

  void startStory() {

    timer = Timer.periodic(
      const Duration(seconds: 5),
      (timer) {

        if (currentIndex <
            widget.stories.length - 1) {

          setState(() {
            currentIndex++;
          });

        } else {

          Navigator.pop(context);
        }
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final story =
        widget.stories[currentIndex];

    return Scaffold(

      backgroundColor: Colors.black,

      body: Stack(

        children: [

          Center(
            child: Image.network(
              "http://10.85.110.110:8000/api/auth/story-image/${story['image']}",
              fit: BoxFit.contain,
            ),
          ),

          Positioned(
            top: 50,
            left: 10,
            right: 10,

            child: LinearProgressIndicator(
              value:
                  (currentIndex + 1) /
                  widget.stories.length,
            ),
          ),

          Positioned(
            top: 60,
            right: 20,

            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}