import 'package:flutter/material.dart';

class WebPostWidget extends StatelessWidget {
  final String image;
  final String username;
  final String profileImage;

  final String likes;
  final String caption;
  final String location;
  final String timeAgo;
  final String headerText;

  final bool verified;

  const WebPostWidget({
    super.key,
    required this.image,
    required this.username,
    required this.profileImage,
    required this.likes,
    required this.caption,
    required this.location,
    required this.timeAgo,
    required this.verified,
    required this.headerText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 470,
      margin: const EdgeInsets.only(
        top: 8,
        bottom: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0xffDBDBDB),
          width: 0.7,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // HEADER
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                CircleAvatar(
                  radius: 16,
                  backgroundImage: AssetImage(profileImage),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [

                      Row(
                        children: [

                          Text(
                            username,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),

                          if (verified) ...[
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.verified,
                              color: Color(0xff0095F6),
                              size: 14,
                            ),
                          ],

                          if (headerText.isNotEmpty) ...[
                            const Text(
                              " dan ",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              headerText.replaceFirst(
                                  "dan ", ""),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight:
                                    FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ],

                          const Text(
                            " • ",
                            style: TextStyle(
                              color: Colors.black54,
                            ),
                          ),

                          Text(
                            timeAgo,
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 2),

                      if (location.isNotEmpty)
                        Text(
                          location,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                    ],
                  ),
                ),

                const Icon(
                  Icons.more_horiz,
                  color: Colors.black,
                ),
              ],
            ),
          ),

          // IMAGE
          ClipRRect(
            child: SizedBox(
              height: 420,
              width: double.infinity,
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // ACTION BUTTONS
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            child: Row(
              children: const [

                Icon(
                  Icons.favorite_border,
                  size: 26,
                  color: Colors.black,
                ),

                SizedBox(width: 14),

                Icon(
                  Icons.chat_bubble_outline,
                  size: 24,
                  color: Colors.black,
                ),

                SizedBox(width: 14),

                Icon(
                  Icons.send_outlined,
                  size: 24,
                  color: Colors.black,
                ),

                Spacer(),

                Icon(
                  Icons.bookmark_border,
                  size: 26,
                  color: Colors.black,
                ),
              ],
            ),
          ),

          // LIKES
          Padding(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            child: Text(
              likes,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ),

          const SizedBox(height: 6),

          // CAPTION
          Padding(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            child: RichText(
              text: TextSpan(
                children: [

                  TextSpan(
                    text: "$username ",
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight:
                          FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),

                  TextSpan(
                    text: caption,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 8),

          // VIEW COMMENTS
          const Padding(
            padding:
                EdgeInsets.symmetric(
              horizontal: 12,
            ),
            child: Text(
              "Lihat semua komentar",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ),

          const SizedBox(height: 8),

          Padding(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            child: Text(
              timeAgo,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 11,
              ),
            ),
          ),

          const SizedBox(height: 12),
        ],
      ),
    );
  }
}