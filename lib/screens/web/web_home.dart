import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../../widgets/sidebar_widget.dart';
import '../../widgets/story_widget.dart';
import '../../widgets/web_post_widget.dart';
import '../../widgets/suggestion_widget.dart';
import '../../services/story_service.dart';
import '../story/story_viewer_page.dart';
import '../../widgets/upload_story_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WebHome extends StatefulWidget {
  const WebHome({super.key});

  @override
  State<WebHome> createState() => _WebHomeState();
}

class _WebHomeState extends State<WebHome> {

  List<dynamic> allStories = [];

  List<dynamic> stories = [];

  bool isLoadingStories = true;

  String myUsername = "Cerita Anda";
  dynamic myStory;

  int? myUserId;

  @override
  void initState() {
    super.initState();
    loadStories();
  }

  Future<void> loadStories() async {

    try {

      final prefs =
    await SharedPreferences.getInstance();

myUserId =
    prefs.getInt('user_id');

final result =
    await StoryService.getStories();

    print("RESULT = $result");
    print("TOTAL STORY = ${result.length}");

    final Map<int, dynamic> uniqueStories = {};

    for (var story in result) {

  final userId =
      story['user_id'];

  if (userId == myUserId) {

    myStory = story;

    continue;
  }

  if (!uniqueStories.containsKey(userId)) {

    uniqueStories[userId] =
        story;
  }
}

    setState(() {

      allStories = result;

      stories = uniqueStories.values.toList();

      isLoadingStories = false;
    });

    } catch (e) {

      print("ERROR STORY : $e");

      setState(() {
        isLoadingStories = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      // FLOATING MESSAGE
      floatingActionButton: Container(
        width: 220,
        height: 55,

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),

          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
            ),
          ],
        ),

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),

          child: Row(
            children: [

              const Icon(
                FeatherIcons.send,
                color: Colors.black,
              ),

              const SizedBox(width: 10),

              const Text(
                "Pesan",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              const Spacer(),

              const CircleAvatar(
                radius: 12,
                backgroundImage: AssetImage(
                  "assets/images/pesan1.png",
                ),
              ),

              const SizedBox(width: 4),

              const CircleAvatar(
                radius: 12,
                backgroundImage: AssetImage(
                  "assets/images/pesan.png",
                ),
              ),

              const SizedBox(width: 4),

              Container(
                width: 22,
                height: 22,

                decoration: const BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),

                child: const Center(
                  child: Text(
                    "🔥",
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),

      // BODY
      body: Row(
  crossAxisAlignment: CrossAxisAlignment.start,

  children: [

    // LEFT SIDEBAR
    SidebarWidget(),

    // SCROLL AREA
    Expanded(
      child: SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            // FEED
            Expanded(
              child: Center(
                child: SizedBox(
                  width: 650,

                  child: Column(
                    children: [

                      const SizedBox(height: 20),

                      SizedBox(
                        height: 110,

                        child: isLoadingStories

                            ? const Center(
                                child: CircularProgressIndicator(),
                              )

                            : ListView.builder(

                                scrollDirection: Axis.horizontal,

                                itemCount: stories.length + 1,

                                itemBuilder: (context, index) {

                                if (index == 0) {

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),

                                  child: Column(
                                    children: [

                                      Stack(
                                        children: [

                                          GestureDetector(
                                            onTap: () {

                                              if (myStory == null) {
                                                return;
                                              }

                                              final myStories =
                                                  allStories.where(
                                                (s) =>
                                                    s['user_id'] ==
                                                    myUserId,
                                              ).toList();

                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) =>
                                                      StoryViewerPage(
                                                    stories: myStories,
                                                  ),
                                                ),
                                              );
                                            },

                                            child: CircleAvatar(
                                              radius: 32,

                                              backgroundImage:
                                                  myStory != null

                                                      ? NetworkImage(
                                                          StoryService
                                                              .getStoryImage(
                                                            myStory['image'],
                                                          ),
                                                        )

                                                      : const AssetImage(
                                                          "assets/images/profil2.jpeg",
                                                        ) as ImageProvider,
                                            ),
                                          ),

                                          Positioned(
                                            right: 0,
                                            bottom: 0,

                                            child: GestureDetector(
                                              onTap: () async {

                                                final result =
                                                    await showDialog(
                                                  context: context,
                                                  builder: (_) =>
                                                      const UploadStoryDialog(),
                                                );

                                                if (result == true) {
                                                  await loadStories();
                                                }
                                              },

                                              child: Container(
                                                width: 22,
                                                height: 22,

                                                decoration:
                                                    const BoxDecoration(
                                                  color: Colors.blue,
                                                  shape: BoxShape.circle,
                                                ),

                                                child: const Icon(
                                                  Icons.add,
                                                  size: 16,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 6),

                                      const Text(
                                        "Cerita Anda",
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }

                                final story = stories[index - 1];

                                  final imageUrl =
                                    "http://localhost:8000/api/auth/story-image/${story['image']}";

                                  print("IMAGE URL = $imageUrl");

                                  return GestureDetector(

                                    onTap: () {

                                      final userStories = allStories
                                      .where(
                                        (s) => s['user_id'] == story['user_id'],
                                      )
                                      .toList();

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => StoryViewerPage(
                                            stories: userStories,
                                          ),
                                        ),
                                      );
                                    },

                                    child: StoryWidget(
                                      username:
                                          story['user']['username'] ?? "User",
                                      image: imageUrl,
                                    ),
                                  );
                                },
                              ),
                      ),

                      // POST 1
                      const WebPostWidget(
                        image: "assets/images/post1.png",
                        username: "putriviiola",
                        headerText: "dan ayuwhyn",
                        timeAgo: "1 hari",
                        caption: "Menikmati senja di Pantai Losari 🌅",
                        likes: "12,542 likes",
                        profileImage: "assets/images/profile1.jpeg",
                        location: "Makassar, Sulawesi, Indonesia",
                        verified: true,
                      ),
                      // POST 2
                      const WebPostWidget(
                        image: "assets/images/post2.png",
                        username: "vinaseptiane_",
                        headerText: "",
                        timeAgo: "1 hari",
                        caption: "Healing dulu sebelum kembali ke rutinitas ✨",
                        likes: "8,321 likes",
                        profileImage: "assets/images/profile2.jpeg",
                        location: "Disarankan untuk Anda",
                        verified: false,
                      ),

                      // POST 3
                      const WebPostWidget(
                        image: "assets/images/post3.png",
                        username: "rachelvennya",
                        headerText: "",
                        timeAgo: "1 hari",
                        caption: "Weekend vibes ☕📖",
                        likes: "21,120 likes",
                        profileImage: "assets/images/profile3.jpeg",
                        location: "",
                        verified: true,
                      ),

                      const SizedBox(height: 50),

                    ],
                  ),
                ),
              ),
            ),

            // RIGHT SIDEBAR
            const SuggestionWidget(),

          ],
        ),
      ),
    ),

  ],
),
    );
  }
}