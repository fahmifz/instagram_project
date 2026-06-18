import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class PostWidget extends StatelessWidget {
  final String image;
  final String username;
  final String caption;

  // ACTION COUNTS
  final String likes;
  final String comments;
  final String shares;
  final String sends;

  final String profileImage;
  final String location;
  final String timeAgo;
  final bool verified;
  final String headerText;
  final BoxFit imageFit;

  final bool showFollowButton;
  final bool showHeader;

  const PostWidget({
    super.key,
    required this.image,
    required this.username,
    required this.caption,

    // COUNTS
    required this.likes,
    required this.comments,
    required this.shares,
    required this.sends,

    required this.profileImage,
    required this.location,
    required this.timeAgo,
    required this.verified,
    required this.headerText,

    this.showFollowButton = false,
    this.showHeader = true,
    this.imageFit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {

    final isMobile =
        MediaQuery.of(context).size.width < 700;

    return Container(
      width: isMobile ? double.infinity : 500,

      margin: EdgeInsets.symmetric(
        vertical: isMobile ? 0 : 20,
      ),

      decoration: BoxDecoration(
        color:
            isMobile ? Colors.black : Colors.white,

        borderRadius: BorderRadius.circular(
          isMobile ? 0 : 10,
        ),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          // HEADER POST
          // HEADER POST
if (showHeader)
  Padding(
    padding: const EdgeInsets.all(12),

    child: Row(
      children: [

        // PROFILE
        CircleAvatar(
          radius: 18,

          backgroundImage:
              AssetImage(profileImage),
        ),

        const SizedBox(width: 10),

        // USERNAME
        Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            Row(
              children: [

                Text(
                  username,

                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight:
                        FontWeight.bold,
                    fontSize: 15,
                  ),
                ),

                // VERIFIED
                if (verified) ...[
                  const SizedBox(width: 4),

                  const Icon(
                    Icons.verified,
                    color: Colors.blue,
                    size: 15,
                  ),
                ],

              ],
            ),

            // LOCATION / MUSIC
            if (location.isNotEmpty)
              Row(
                children: [

                  const Icon(
                    Icons.music_note,
                    color: Colors.white,
                    size: 13,
                  ),

                  const SizedBox(width: 4),

                  Text(
                    location,

                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                    ),
                  ),

                ],
              ),

          ],
        ),

        const Spacer(),

        // MORE
        IconButton(
          onPressed: () {},

          icon: const Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
        ),

      ],
    ),
  ),

          // IMAGE POST
          ClipRRect(
            borderRadius: BorderRadius.circular(
              isMobile ? 0 : 8,
            ),

            child: Image.asset(
              image,

              height:
                  isMobile ? 420 : 600,

              width: double.infinity,

              fit: imageFit,
            ),
          ),

          // ACTION BUTTONS
          Padding(
            padding: const EdgeInsets.only(
              left: 12,
              right: 12,
              top: 4,
              bottom: 0,
            ),

            child: Row(
              children: [

                // LOVE
                const Icon(
                  FeatherIcons.heart,
                  color: Colors.white,
                  size: 28,
                ),

                const SizedBox(width: 6),

                Text(
                  likes,

                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),

                const SizedBox(width: 18),

                // COMMENT
                const Icon(
                  FeatherIcons.messageCircle,
                  color: Colors.white,
                  size: 26,
                ),

                const SizedBox(width: 6),

                Text(
                  comments,

                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),

                const SizedBox(width: 18),

                // REPOST
                const Icon(
                  FeatherIcons.repeat,
                  color: Colors.white,
                  size: 26,
                ),

                const SizedBox(width: 6),

                Text(
                  shares,

                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),

                const SizedBox(width: 18),

                // SEND
                const Icon(
                  FeatherIcons.send,
                  color: Colors.white,
                  size: 26,
                ),

                const SizedBox(width: 6),

                Text(
                  sends,

                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),

                const Spacer(),

                // SAVE
                const Icon(
                  FeatherIcons.bookmark,
                  color: Colors.white,
                  size: 28,
                ),

              ],
            ),
          ),

          const SizedBox(height: 4),

          // CAPTION
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),

            child: RichText(
              text: TextSpan(
                children: [

                  TextSpan(
                    text: "$username ",

                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight:
                          FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  TextSpan(
                    text: caption,

                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),

                ],
              ),
            ),
          ),

          const SizedBox(height: 4),

          // DIVIDER
          if (isMobile)
            Divider(
              color: Colors.grey.shade900,
              height: 1,
            ),

        ],
      ),
    );
  }
}