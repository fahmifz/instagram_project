import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../../widgets/mobile_post_widget.dart';
import '../../widgets/story_widget.dart';
import '../../services/story_service.dart';
import '../story/story_viewer_page.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../story/create_story_page.dart';

class MobileHome extends StatefulWidget {
  const MobileHome({super.key});

  @override
  State<MobileHome> createState() =>
      _MobileHomeState();
}

class _MobileHomeState
    extends State<MobileHome> {
      List<dynamic> allStories = [];

      List<dynamic> stories = [];

      bool isLoadingStories = true;
      int? myUserId;

      dynamic myStory;

      Future<void> pickAndUploadStory() async {

  try {
    

    final picker = ImagePicker();

    final XFile? image =
        await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image == null) return;

    final prefs =
        await SharedPreferences.getInstance();

    final userId =
        prefs.getInt('user_id');

    if (userId == null) return;

    final bytes =
        await File(image.path)
            .readAsBytes();

    final success =
        await StoryService.uploadStory(
      bytes,
      userId.toString(),
    );

    if (success) {

      await loadStories();

      if (mounted) {

        ScaffoldMessenger.of(context)
            .showSnackBar(
          const SnackBar(
            content: Text(
              'Story berhasil diupload',
            ),
          ),
        );
      }
    }

  } catch (e) {

    print(e);
  }
}

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

        final Map<int, dynamic>
            uniqueStories = {};

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

          stories =
              uniqueStories.values.toList();

          isLoadingStories = false;
        });

      } catch (e) {

        print(e);

        setState(() {
          isLoadingStories = false;
        });
      }
    }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final width = size.width;
    final height = size.height;

    return Scaffold(
      backgroundColor: Colors.black,

      // APP BAR
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * 0.07),

        child: SafeArea(
          child: Container(
            height: height * 0.07,
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.035,
            ),
            color: Colors.black,

            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,

              children: [
                // PLUS
                Icon(
                  Icons.add,
                  color: Colors.white,
                  size: width * 0.075,
                ),

                // INSTAGRAM
                Text(
                  "Instagram",

                  style: TextStyle(
                    fontFamily: 'Billabong',
                    fontSize: width * 0.09,
                    color: Colors.white,
                  ),
                ),

                // HEART
                Icon(
                  FeatherIcons.heart,
                  color: Colors.white,
                  size: width * 0.07,
                ),
              ],
            ),
          ),
        ),
      ),

      // BODY
      body: SingleChildScrollView(
        child: Column(
          children: [
            // STORIES
            SizedBox(
              height: height * 0.16,

              child: isLoadingStories
    ? const Center(
        child:
            CircularProgressIndicator(),
      )
    : ListView.builder(
        scrollDirection:
            Axis.horizontal,

        itemCount: stories.length + 1,

        itemBuilder:
            (context, index) {
              if (index == 0) {

  return GestureDetector(

    onTap: () {

        Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              const CreateStoryPage(),
        ),
      ).then((_) {
        loadStories();
      });
    },

    child: Padding(
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

              backgroundImage: myStory != null
    ? NetworkImage(
        StoryService.getStoryImage(myStory['image']),
      )
    : const AssetImage('assets/images/side1.jpeg')
        as ImageProvider,
            ),
          ),

          Positioned(
            right: 0,
            bottom: 0,

            child: GestureDetector(
              onTap: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const CreateStoryPage(),
                  ),
                ).then((_) {
                  loadStories();
                });

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

      const SizedBox(
        width: 70,
        child: Text(
          "Cerita Anda",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ),
    ],
  ),
),
  );
}

final story =
    stories[index - 1];

final userStories =
    allStories.where(
      (s) =>
          s['user_id'] ==
          story['user_id'],
    ).toList();

return GestureDetector(
  onTap: () {

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            StoryViewerPage(
          stories: userStories,
        ),
      ),
    );

  },

  child: StoryWidget(
    username:
        story['user']['username'] ?? '',
    image:
        StoryService.getStoryImage(
      story['image'],
    ),
  ),
);
        },
      ),
            ),

            

            // POST 1
            const MobilePostWidget(
              image:
                  "assets/images/mobile/post1.png",

              username: "gofoodindonesia",

              location: "",

              timeAgo: "",

              caption:
                  "Makanan dan Ongkir 50Ribu 🔥",

              likes: "131",
              comments: "1",
              shares: "",
              sends: "",

              profileImage:
                  "assets/images/mobile/prof3.png",

              verified: true,
            ),

            // HASHTAG
            
            // POST 2
            const MobilePostWidget(
              image:
                  "assets/images/mobile/post2.png",

              username: "daehoon_na",

              location:
                  "DJ Shadow·Six Days(feat. Mos Def)[Remix]",

              timeAgo: "",

              caption:
                  "OOTDae bareng si ganteng😎🤟🏻",

              likes: "51,5rb",
              comments: "331",
              shares: "482",
              sends: "176",

              profileImage:
                  "assets/images/mobile/prof5.png",

              verified: true,
            ),

            // POST 3
            Stack(
              children: [
                // IMAGE
                const MobilePostWidget(
                  showHeader: false,

                  image:
                      "assets/images/cewek.png",

                  username: "",

                  location: "",

                  timeAgo: "",

                  caption: "",

                  likes: "1.781",
                  comments: "8",
                  shares: "33",
                  sends: "11",

                  profileImage: "",

                  verified: false,
                ),

                // HEADER
                Positioned(
                  top: height * 0.018,
                  left: width * 0.03,
                  right: width * 0.03,

                  child: Row(
                    children: [
                      // PROFILE
                      Container(
                        padding:
                            EdgeInsets.all(
                          width * 0.005,
                        ),

                        decoration: BoxDecoration(
                          shape: BoxShape.circle,

                          border: Border.all(
                            color: Colors.orange,
                            width: 2,
                          ),
                        ),

                        child: CircleAvatar(
                          radius: width * 0.04,

                          backgroundImage:
                              const AssetImage(
                            "assets/images/profilimage.jpeg",
                          ),
                        ),
                      ),

                      SizedBox(
                        width: width * 0.025,
                      ),

                      // USERNAME
                      Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [
                          Text(
                            "elaalin_lambert",

                            style: TextStyle(
                              color: Colors.white,
                              fontWeight:
                                  FontWeight.bold,
                              fontSize:
                                  width * 0.038,
                            ),
                          ),

                          SizedBox(
                            height:
                                height * 0.002,
                          ),

                          Text(
                            "1 hari lalu",

                            style: TextStyle(
                              color:
                                  Colors.white70,
                              fontSize:
                                  width * 0.03,
                            ),
                          ),
                        ],
                      ),

                      const Spacer(),

                      // MORE
                      Icon(
                        Icons.more_vert,
                        color: Colors.white,
                        size: width * 0.065,
                      ),
                    ],
                  ),
                ),

                // TEXT TENGAH
                Positioned(
                  top: height * 0.14,
                  left: width * 0.03,
                  right: width * 0.03,

                  child: Center(
                    child: Text(
                      "Prank Lela Mau Pindah ke Jakarta",

                      textAlign:
                          TextAlign.center,

                      style: TextStyle(
                        color: Colors.white,
                        fontWeight:
                            FontWeight.w900,
                        fontSize:
                            width * 0.05,

                        shadows: const [
                          Shadow(
                            offset:
                                Offset(2, 2),
                            blurRadius: 3,
                            color: Colors.black,
                          ),

                          Shadow(
                            offset:
                                Offset(-2, -2),
                            blurRadius: 3,
                            color: Colors.black,
                          ),

                          Shadow(
                            offset:
                                Offset(2, -2),
                            blurRadius: 3,
                            color: Colors.black,
                          ),

                          Shadow(
                            offset:
                                Offset(-2, 2),
                            blurRadius: 3,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: height * 0.02),
          ],
        ),
      ),

      // BOTTOM NAVIGATION
      bottomNavigationBar: Container(
        height: height * 0.075,
        color: Colors.black,

        padding: EdgeInsets.only(
          left: width * 0.045,
          right: width * 0.045,
          bottom: height * 0.005,
        ),

        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween,

          children: [
            // HOME
            Icon(
              Icons.home,
              color: Colors.white,
              size: width * 0.08,
            ),

            // REELS
            Icon(
              Icons.smart_display_outlined,
              color: Colors.white,
              size: width * 0.075,
            ),

            // SEND
            Stack(
              children: [
                Icon(
                  FeatherIcons.send,
                  color: Colors.white,
                  size: width * 0.065,
                ),

                Positioned(
                  right: -1,
                  bottom: 2,

                  child: Container(
                    width: width * 0.02,
                    height: width * 0.02,

                    decoration:
                        const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),

            // SEARCH
            Icon(
              Icons.search,
              color: Colors.white,
              size: width * 0.08,
            ),

            // PROFILE
            Stack(
              children: [
                Container(
                  padding:
                      EdgeInsets.all(
                    width * 0.004,
                  ),

                  decoration: BoxDecoration(
                    shape: BoxShape.circle,

                    border: Border.all(
                      color: Colors.white,
                      width: 1.5,
                    ),
                  ),

                  child: CircleAvatar(
                    radius: width * 0.035,

                    backgroundImage:
                        const AssetImage(
                      "assets/images/mobile/side1.png",
                    ),
                  ),
                ),

                Positioned(
                  right: 0,
                  bottom: 0,

                  child: Container(
                    width: width * 0.02,
                    height: width * 0.02,

                    decoration:
                        const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}