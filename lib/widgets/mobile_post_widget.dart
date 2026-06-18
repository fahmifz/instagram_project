import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class MobilePostWidget extends StatelessWidget {
  final String image;
  final String username;
  final String caption;

  final String likes;
  final String comments;
  final String shares;
  final String sends;

  final String profileImage;
  final String location;
  final String timeAgo;

  final bool verified;
  final bool showHeader;

  final BoxFit imageFit;

  const MobilePostWidget({
    super.key,
    required this.image,
    required this.username,
    required this.caption,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.sends,
    required this.profileImage,
    required this.location,
    required this.timeAgo,
    required this.verified,
    this.showHeader = true,
    this.imageFit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    final width = size.width;
    final height = size.height;

    return Container(
      color: Colors.black,

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          // HEADER
          if (showHeader)
            Padding(
              padding:
                  EdgeInsets.symmetric(
                horizontal: width * 0.03,
                vertical: height * 0.012,
              ),

              child: Row(
                crossAxisAlignment:
                    CrossAxisAlignment.center,

                children: [

                  // PROFILE
                  CircleAvatar(
                    radius: width * 0.045,

                    backgroundImage:
                        AssetImage(
                      profileImage,
                    ),
                  ),

                  SizedBox(
                    width: width * 0.025,
                  ),

                  // TEXT AREA
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                      mainAxisSize:
                          MainAxisSize.min,

                      children: [

                        // USERNAME
                        Row(
                          children: [

                            Flexible(
                              child: Text(
                                username,

                                maxLines: 1,

                                overflow:
                                    TextOverflow
                                        .ellipsis,

                                style:
                                    TextStyle(
                                  color:
                                      Colors
                                          .white,

                                  fontWeight:
                                      FontWeight
                                          .bold,

                                  fontSize:
                                      width *
                                          0.038,
                                ),
                              ),
                            ),

                            if (verified) ...[
                              SizedBox(
                                width:
                                    width *
                                        0.01,
                              ),

                              Icon(
                                Icons
                                    .verified,

                                color:
                                    Colors
                                        .blue,

                                size:
                                    width *
                                        0.04,
                              ),
                            ],

                          ],
                        ),

                        // LOCATION
                        if (location
                            .isNotEmpty)
                          Padding(
                            padding:
                                EdgeInsets.only(
                              top:
                                  height *
                                      0.002,
                            ),

                            child: Row(
                              children: [

                                Icon(
                                  Icons
                                      .music_note,

                                  color:
                                      Colors
                                          .white,

                                  size:
                                      width *
                                          0.032,
                                ),

                                SizedBox(
                                  width:
                                      width *
                                          0.01,
                                ),

                                Expanded(
                                  child: Text(
                                    location,

                                    maxLines:
                                        1,

                                    overflow:
                                        TextOverflow
                                            .ellipsis,

                                    softWrap:
                                        false,

                                    style:
                                        TextStyle(
                                      color:
                                          Colors
                                              .white,

                                      fontSize:
                                          width *
                                              0.032,
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),

                      ],
                    ),
                  ),

                  SizedBox(
                    width: width * 0.02,
                  ),

                  // MORE
                  Icon(
                    Icons.more_vert,
                    color: Colors.white,
                    size: width * 0.06,
                  ),

                ],
              ),
            ),

          // IMAGE
          Image.asset(
            image,

            width: double.infinity,

            height: height * 0.52,

            fit: imageFit,
          ),

          // ACTION
          Padding(
            padding: EdgeInsets.only(
              left: width * 0.03,
              right: width * 0.03,
              top: height * 0.008,
            ),

            child: Row(
              children: [

                // LIKE
                Icon(
                  FeatherIcons.heart,
                  color: Colors.white,
                  size: width * 0.07,
                ),

                SizedBox(
                  width: width * 0.015,
                ),

                Text(
                  likes,

                  style: TextStyle(
                    color: Colors.white,
                    fontSize:
                        width * 0.04,
                  ),
                ),

                SizedBox(
                  width: width * 0.04,
                ),

                // COMMENT
                Icon(
                  FeatherIcons
                      .messageCircle,

                  color: Colors.white,
                  size: width * 0.065,
                ),

                SizedBox(
                  width: width * 0.015,
                ),

                Text(
                  comments,

                  style: TextStyle(
                    color: Colors.white,
                    fontSize:
                        width * 0.04,
                  ),
                ),

                SizedBox(
                  width: width * 0.04,
                ),

                // SHARE
                Icon(
                  FeatherIcons.repeat,
                  color: Colors.white,
                  size: width * 0.06,
                ),

                SizedBox(
                  width: width * 0.015,
                ),

                Text(
                  shares,

                  style: TextStyle(
                    color: Colors.white,
                    fontSize:
                        width * 0.04,
                  ),
                ),

                SizedBox(
                  width: width * 0.04,
                ),

                // SEND
                Icon(
                  FeatherIcons.send,
                  color: Colors.white,
                  size: width * 0.06,
                ),

                SizedBox(
                  width: width * 0.015,
                ),

                Expanded(
                  child: Text(
                    sends,

                    maxLines: 1,

                    overflow:
                        TextOverflow
                            .ellipsis,

                    style: TextStyle(
                      color: Colors.white,
                      fontSize:
                          width * 0.04,
                    ),
                  ),
                ),

                // BOOKMARK
                Icon(
                  FeatherIcons.bookmark,
                  color: Colors.white,
                  size: width * 0.065,
                ),

              ],
            ),
          ),

          SizedBox(
            height: height * 0.006,
          ),

          // CAPTION
          Padding(
            padding:
                EdgeInsets.symmetric(
              horizontal:
                  width * 0.03,
            ),

            child: RichText(
              text: TextSpan(
                children: [

                  TextSpan(
                    text: "$username ",

                    style: TextStyle(
                      color: Colors.white,

                      fontWeight:
                          FontWeight.bold,

                      fontSize:
                          width * 0.036,
                    ),
                  ),

                  TextSpan(
                    text: caption,

                    style: TextStyle(
                      color: Colors.white,
                      fontSize:
                          width * 0.036,
                    ),
                  ),

                ],
              ),
            ),
          ),

          SizedBox(
            height: height * 0.012,
          ),

          Divider(
            color: Colors.grey.shade900,
            height: 1,
          ),

        ],
      ),
    );
  }
}